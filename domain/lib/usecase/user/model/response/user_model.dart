import 'package:domain/repository/user/model/response/user_rres_model.dart';
import 'package:domain/repository/user/model/response/users_rres_model.dart';
import 'package:flutter/widgets.dart';

class UserModel {
  final int id;
  final String name;
  final String email;
  final String userName;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.userName,
  });

  factory UserModel.fromUser(UserRResModel repositoryModel) {
    return UserModel(
      id: repositoryModel.id,
      name: repositoryModel.name,
      email: repositoryModel.email,
      userName: repositoryModel.username,
    );
  }

  factory UserModel.fromUsers(UsersRResModel repositoryModel) {
    return UserModel(
      id: repositoryModel.id,
      name: repositoryModel.name,
      email: '',
      userName: '',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
