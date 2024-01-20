

import 'package:domain/sample/login/model/login_user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/user/common_model/user_container.dart';
import 'package:net_test/user/common_model/user_manager.dart';

class UserManagerProvider extends StateNotifier<UserManager> {
  UserManagerProvider() : super(UserManager(data: {}));


  void addTreeItem({required String id, required LoginUserModel item}) {
    if (state.data.containsKey(id)) {
      // If the key exists, update the data
      state = state.copyWith(
        data: {
          ...state.data,
          id: UserContainer(
            id,
            {
              ...state.data[id]!.children,
              item,
            },
          ),
        },
      );
    } else {
      // If the key does not exist, add a new key-value pair
      state = state.copyWith(
        data: {
          ...state.data,
          id: UserContainer(
            id,
            {
              item,
            },
          ),
        },
      );
    }
  }

  void removeTreeItem(String id) {
    if (state.data.containsKey(id)) {
      // If the key exists, remove the data
      state = state.copyWith(
        data: {
          ...state.data..remove(id),
        },
      );
    }
  }

}