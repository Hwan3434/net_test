import 'package:domain/repository/user/model/request/user_rreq_model.dart';
import 'package:domain/repository/user/model/request/users_rreq_model.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/cache/app_cache.dart';
import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/cache_config/user_usecase_cache_config.dart';
import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:domain/usecase/user/user_usecase.dart';

class UserUseCaseImpl implements UserUseCase {
  final UserRepository _repository;
  final UserUseCaseCacheConfig cacheConfig;
  final Map<UserUseCaseKeys, DataCache> userCache = {
    UserUseCaseKeys.getUser: DataCache<UserModel>(),
    UserUseCaseKeys.getUsers: DataCache<List<UserModel>>(),
  };

  UserUseCaseImpl(this._repository, this.cacheConfig);

  T? _getCacheOrNull<T>(UserUseCaseKeys key, String paramKey) {
    assert(cacheConfig.cache.containsKey(UserUseCaseKeys.getUser));
    assert(userCache.containsKey(UserUseCaseKeys.getUser));

    return cacheConfig.cache[key]!
        ? userCache[key]!.getFromParameter(paramKey)
        : null;
  }

  void _IsUseAddCache<T>(UserUseCaseKeys key, String paramKey, T data) {
    assert(cacheConfig.cache.containsKey(UserUseCaseKeys.getUser));
    assert(userCache.containsKey(UserUseCaseKeys.getUser));
    userCache[key]!.add(paramKey, data);
  }

  String _createParamKey(List<dynamic> param) {
    return param.map((e) => e.toString()).join(",");
  }

  @override
  Future<Result<UserModel>> getUser({
    required int userId,
  }) {
    const cacheKey = UserUseCaseKeys.getUser;
    final paramKey = _createParamKey([userId]);
    assert(cacheConfig.cache.containsKey(cacheKey));

    final cache = _getCacheOrNull<UserModel>(cacheKey, paramKey);
    if (cache != null) {
      return Future.value(ResultSuccess(cache));
    }

    return _repository
        .getUser(request: UserRReqModel(userId: userId))
        .then((value) {
      final result = UserModel.fromUser(value);
      _IsUseAddCache<UserModel>(cacheKey, paramKey, result);
      return ResultSuccess(result);
    }).catchError((error) {
      return ResultError(error);
    });
  }

  @override
  Future<Result<List<UserModel>>> getUsers() {
    const cacheKey = UserUseCaseKeys.getUsers;
    final paramKey = _createParamKey([]);
    assert(cacheConfig.cache.containsKey(cacheKey));

    final cache = _getCacheOrNull<List<UserModel>>(cacheKey, paramKey);
    if (cache != null) {
      return Future.value(ResultSuccess(cache));
    }
    return _repository.getUsers(request: UsersRReqModel()).then((value) {
      final result = value.map((e) => UserModel.fromUsers(e)).toList();
      _IsUseAddCache<List<UserModel>>(cacheKey, paramKey, result);
      return ResultSuccess(result);
    }).catchError((error) {
      return ResultError(error);
    });
  }

  @override
  Future<Result> delete(int userId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Result> insert() {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<Result> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
