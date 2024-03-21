import 'package:domain/repository/user/model/response/user_rres_model.dart';
import 'package:domain/repository/user/model/response/users_rres_model.dart';

class UserDataModel {
  final int id;
  final String name;
  final String email;
  final String userName;

  UserDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
  });

  factory UserDataModel.fromUser(UserRResModel repositoryModel) {
    return UserDataModel(
      id: repositoryModel.id,
      name: repositoryModel.name,
      email: repositoryModel.email,
      userName: repositoryModel.username,
    );
  }

  factory UserDataModel.fromUsers(UsersRResModel repositoryModel) {
    return UserDataModel(
      id: repositoryModel.id,
      name: repositoryModel.name,
      email: '',
      userName: '',
    );
  }
}
