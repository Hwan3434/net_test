import 'package:domain/repository/user/model/response/user_rres_model.dart';

import 'user_model.dart';

class UserDetailModel extends UserModel {
  final String email;
  final String userName;

  UserDetailModel({
    required super.id,
    required super.name,
    required this.email,
    required this.userName,
  });

  factory UserDetailModel.fromUser(UserRResModel repositoryModel) {
    return UserDetailModel(
      id: repositoryModel.id,
      name: repositoryModel.name,
      email: repositoryModel.email,
      userName: repositoryModel.username,
    );
  }
}

class AppUserDataModel {}
