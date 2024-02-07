import 'package:domain/usecase/result/result.dart';

enum UserUseCaseKeys {
  getUser,
  getUsers,
}

abstract interface class UserUseCase {
  // Future<UserModel> getUser({
  //   required int userId,
  // });
  // Future<List<UserModel>> getUsers();
  Future<Result> getUser({
    required int userId,
  });
  Future<Result> getUsers();
  Future<Result> insert();
  Future<Result> update();
  Future<Result> delete(int userId);
}
