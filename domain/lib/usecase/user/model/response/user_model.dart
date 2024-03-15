import 'package:domain/repository/user/model/response/user_rres_model.dart';
import 'package:domain/repository/user/model/response/users_rres_model.dart';

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
      other is UserModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          userName == other.userName;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ email.hashCode ^ userName.hashCode;

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? userName,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      userName: userName ?? this.userName,
    );
  }
}
