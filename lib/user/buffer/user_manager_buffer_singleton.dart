import 'package:domain/usecase/login/res_model/login_user_model.dart';

class UserManagerBufferSingleton {
  static final UserManagerBufferSingleton _singleton =
      UserManagerBufferSingleton._internal();
  final Set<LoginUserModel> data = {};

  factory UserManagerBufferSingleton() {
    return _singleton;
  }

  UserManagerBufferSingleton._internal();

  void add({required LoginUserModel user}) {
    data.add(user);
  }

  void addAll({required List<LoginUserModel> users}) {
    data.addAll(users);
  }
}
