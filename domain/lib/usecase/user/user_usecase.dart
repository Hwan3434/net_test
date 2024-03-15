import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/model/response/user_model.dart';

enum UserUseCaseKeys {
  getUser,
  getUsers,
}

abstract interface class UseCase {}

abstract interface class UserUseCase implements UseCase {
  // Future<UserModel> getUser({
  //   required int userId,
  // });
  // Future<List<UserModel>> getUsers();
  Future<Result<UserModel>> getUser({
    required int userId,
  });
  Future<Result<List<UserModel>>> getUsers();
  Future<void> insert();
  Future<void> update();
  Future<void> delete(int userId);
}
