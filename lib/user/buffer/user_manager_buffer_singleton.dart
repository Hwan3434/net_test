import 'package:domain/sample/login/model/login_user_model.dart';
import 'package:net_test/user/common_model/user_manager.dart';

class UserManagerBufferSingleton {
  static final UserManagerBufferSingleton _singleton = UserManagerBufferSingleton._internal();
  final UserManager treeManager = UserManager(data: {});

  factory UserManagerBufferSingleton() {
    return _singleton;
  }

  UserManagerBufferSingleton._internal();

  void add({required String serviceId, required LoginUserModel user}) {
    treeManager.add(serviceId: serviceId, user: user);
  }

  void addAll({required String serviceId, required List<LoginUserModel> users}) {
    treeManager.addAll(serviceId: serviceId, users: users);
  }
}