import 'package:domain/repository/user/model/request/user_rreq_model.dart';
import 'package:domain/repository/user/model/request/users_rreq_model.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/user/login_usecase.dart';
import 'package:domain/usecase/user/model/response/user_detail_model.dart';
import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../cache/app_cache.dart';

class UserUseCaseImpl implements UserUseCase {
  final UserRepository _repository;

  final AppCache? cache;

  UserUseCaseImpl(this._repository, {this.cache});

  @override
  Future<UserDetailModel> getUser({
    required int userId,
  }) {
    return _repository
        .getUser(request: UserRReqModel(userId: userId))
        .then((value) {
      final result = UserDetailModel.fromUser(value);
      try {
        cache?.save(result);
      } catch (e) {
        debugPrint('e :: ${e.toString()}');
      }
      return result;
    }).catchError((error) {
      throw error;
    });
  }

  @override
  Future<List<UserModel>> getUsers() {
    return _repository.getUsers(request: UsersRReqModel()).then((value) {
      return value.map((e) => UserModel.fromUsers(e)).toList();
    }).catchError((error) {
      throw error;
    });
  }
}
