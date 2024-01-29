import 'package:domain/usecase/user/model/response/user_detail_model.dart';

import 'model/response/user_model.dart';

abstract interface class UserUseCase {
  Future<UserDetailModel> getUser({
    required int userId,
  });
  Future<List<UserModel>> getUsers();
}
