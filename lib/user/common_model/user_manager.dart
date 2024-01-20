





import 'package:domain/sample/login/model/login_user_model.dart';
import 'package:net_test/user/common_model/user_container.dart';

class UserManager {
  final Map<String, UserContainer> data;

  UserManager({
    required this.data,
  });


  void add({required String serviceId, required LoginUserModel user}){
    if (data.containsKey(serviceId)) {
      // If the key exists, update the data
      data[serviceId] = data[serviceId]!.copyWith(
        children: {
          ...data[serviceId]!.children,
          user,
        },
      );
    } else {
      // If the key does not exist, add a new key-value pair
      data[serviceId] = UserContainer(
        serviceId,
        {
          user,
        },
      );
    }
  }

  void addAll({required String serviceId, required List<LoginUserModel> users}){
    if (data.containsKey(serviceId)) {
      // If the key exists, update the data
      data[serviceId] = data[serviceId]!.copyWith(
        children: {
          ...data[serviceId]!.children,
          ...users,
        },
      );
    } else {
      // If the key does not exist, add a new key-value pair
      data[serviceId] = UserContainer(
        serviceId,
        {
          ...users,
        },
      );
    }
  }


  UserManager copyWith({
    Map<String, UserContainer>? data,
  }) {
    return UserManager(
      data: data ?? this.data,
    );
  }

}