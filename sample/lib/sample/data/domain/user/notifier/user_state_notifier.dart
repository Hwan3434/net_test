import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/sample/aaa_test/agent_usecase.dart';
import 'package:sample/sample/data/domain/user/model/user_model.dart';

class UserStateNotifier extends StateNotifier<UserListModel> {
  final AgentUseCase agentUseCase;
  final UserUseCase userUseCase;
  UserStateNotifier(
    super.state, {
    required this.agentUseCase,
    required this.userUseCase,
  });

  void fetch() async {
    state = state.copyWith(
      state: UserListState.loading,
    );
    await Future.delayed(Duration(seconds: 3));
    await userUseCase.getUsers().then((value) {
      switch (value) {
        case ResultSuccess(data: final data):
          {
            state = state.copyWith(
              state: UserListState.success,
              data: data,
            );
          }
        case ResultError():
          {
            state = state.copyWith(state: UserListState.error);
          }
      }
    });
  }

  void update(UserModel userModel) {
    state = state.copyWith(
        data: state.data.map((e) {
      if (userModel.id == e.id) {
        return userModel;
      } else {
        return e;
      }
    }).toList());
  }

  void addUser(UserModel userModel) {
    state = state.copyWith(
      state: state.state,
      data: [...state.data, userModel],
    );
  }

  UserModel get(int userId) {
    return state.data.singleWhere((element) => element.id == userId);
  }
}
