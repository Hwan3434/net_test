// ignore_for_file: invalid_return_type_for_catch_error

import 'package:domain/repository/user/model/request/delete_rreq_model.dart';
import 'package:domain/repository/user/model/request/user_rreq_model.dart';
import 'package:domain/repository/user/model/request/users_rreq_model.dart';
import 'package:domain/repository/user/user_repository.dart';
import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:domain/usecase/user/user_usecase.dart';

class UserUseCaseImpl2 implements UserUseCase {
  final UserRepository _repository;
  UserUseCaseImpl2(this._repository);

  @override
  Future<Result<UserModel>> getUser({
    required int userId,
  }) {
    return _repository
        .getUser(request: UserRReqModel(userId: userId))
        .then((value) {
      return ResultSuccess(UserModel.fromUser(value));
    }).catchError((error) {
      return ResultError(LocalError(error.toString()));
    });
  }

  @override
  Future<Result<List<UserModel>>> getUsers() {
    return _repository.getUsers(request: UsersRReqModel()).then((value) {
      return ResultSuccess(value.map((e) => UserModel.fromUsers(e)).toList());
    }).catchError((error) {
      return ResultError(LocalError(error.toString()));
    });
  }

  @override
  Future<Result> delete(int userId) async {
    return await _repository
        .delete(request: DeleteRReqModel(userId: userId))
        .then((value) {
      return ResultSuccess<String>('');
    }).catchError((error, stackTrace) {
      return ResultError<String>(LocalError(error.toString()));
    });
  }

  @override
  Future<Result> insert() {
    throw UnimplementedError();
  }

  @override
  Future<Result> update() {
    throw UnimplementedError();
  }
}
