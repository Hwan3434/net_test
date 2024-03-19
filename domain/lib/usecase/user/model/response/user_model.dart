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

  /// todo 전체를 ==에 사용한 이유는
  /// id만 유니크키로 잡으면 provider에서 watch가 동작하지않게됩니다.
  /// 예를들어 A사용자의 email을 변경하면 copyWith로 하면 id, name, userName은 동일하고 email만
  /// 변경되는데 이때 id가 같기으면 같은객체기때문에 provider는 변화감지를 하지못합니다.
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
