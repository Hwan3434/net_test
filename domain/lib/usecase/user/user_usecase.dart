import 'package:domain/usecase/user/model/response/user_model.dart';

enum UserUseCaseKeys {
  getUser,
  getUsers,
}

abstract interface class UserUseCase {
  Future<UserModel> getUser({
    required int userId,
  });
  Future<List<UserModel>> getUsers();
}
