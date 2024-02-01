import 'package:domain/repository/user/model/request/user_rreq_model.dart';
import 'package:domain/repository/user/model/request/users_rreq_model.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/cache/app_cache.dart';
import 'package:domain/usecase/user/cache_config/user_usecase_cache_config.dart';
import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter/widgets.dart';

class UserUseCaseImpl implements UserUseCase {
  final UserRepository _repository;
  final UserUseCaseCacheConfig cacheConfig;
  final Map<UserUseCaseKeys, DataCache> userCache = {
    UserUseCaseKeys.getUser: DataCache<UserModel>(),
    UserUseCaseKeys.getUsers: DataCache<List<UserModel>>(),
  };

  UserUseCaseImpl(this._repository, this.cacheConfig);

  T? _getCache<T>(UserUseCaseKeys key, List<dynamic> param) {
    assert(cacheConfig.cache.containsKey(UserUseCaseKeys.getUser));
    assert(userCache.containsKey(UserUseCaseKeys.getUser));
    return userCache[UserUseCaseKeys.getUser]!.getFromParameter(param);
  }

  void _addCache<T>(UserUseCaseKeys key, List<dynamic> param, T data) {
    assert(cacheConfig.cache.containsKey(UserUseCaseKeys.getUser));
    assert(userCache.containsKey(UserUseCaseKeys.getUser));
    userCache[UserUseCaseKeys.getUser]!.add(param, data);
  }

  @override
  Future<UserModel> getUser({
    required int userId,
  }) {
    const cacheKey = UserUseCaseKeys.getUser;
    final paramKey = [userId];
    assert(cacheConfig.cache.containsKey(cacheKey));

    if (cacheConfig.cache[cacheKey]!) {
      final data = _getCache<UserModel>(cacheKey, paramKey);
      if (data != null) {
        debugPrint('캐시에서 가져옵니다.');
        return Future.value(_getCache<UserModel>(cacheKey, paramKey));
      }
    }
    return _repository
        .getUser(request: UserRReqModel(userId: userId))
        .then((value) {
      final result = UserModel.fromUser(value);
      debugPrint('웹에서 가져옵니다.');
      if (cacheConfig.cache[cacheKey]!) {
        _addCache<UserModel>(cacheKey, paramKey, result);
      }
      return result;
    }).catchError((error) {
      throw error;
    });
  }

  @override
  Future<List<UserModel>> getUsers() {
    const cacheKey = UserUseCaseKeys.getUsers;
    final paramKey = [];
    assert(cacheConfig.cache.containsKey(cacheKey));

    if (cacheConfig.cache[cacheKey]!) {
      return Future.value(_getCache<List<UserModel>>(cacheKey, paramKey));
    }
    return _repository.getUsers(request: UsersRReqModel()).then((value) {
      final result = value.map((e) => UserModel.fromUsers(e)).toList();
      if (cacheConfig.cache[cacheKey]!) {
        _addCache<List<UserModel>>(cacheKey, paramKey, result);
      }
      return result;
    }).catchError((error) {
      throw error;
    });
  }
}
