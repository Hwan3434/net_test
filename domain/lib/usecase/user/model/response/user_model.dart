import 'package:domain/repository/user/model/response/users_rres_model.dart';

class UserModel {
  final int id;
  final String name;

  UserModel({
    required this.id,
    required this.name,
  });

  factory UserModel.fromUsers(UsersRResModel repositoryModel) {
    return UserModel(id: repositoryModel.id, name: repositoryModel.name);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
