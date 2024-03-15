import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/model/response/user_model.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../test/log.dart';

class UserListStateNotifier extends StateNotifier<UserListState> {
  final UserUseCase _userUseCase;
  UserListStateNotifier(super.state, this._userUseCase) {
    init();
  }

  void init() {
    fetch();
  }

  void add(String name) {
    assert(state is! UserListWait, '대기중일때 데이터를 조작 할 수 없습니다.');
    assert(state is! UserListLoading, '로딩중일때 데이터를 조작 할 수 없습니다.');
    assert(state is! UserListError, '에러일때 데이터를 조작 할 수 없습니다.');
    Log.d('UserListStateNotifier Add');
    state = UserListSuccess(data: [
      UserModel(id: 11, name: '나미', email: 'Na@naver.com', userName: 'nami'),
      ...(state as UserListSuccess).data,
    ]);
  }

  void fetch() async {
    Log.d('UserListStateNotifier Fetch');
    // _userUseCase.dio.options.baseUrl = 'https://${orgName}.nhn-cloud.com';
    state = UserListLoading();
    await Future.delayed(Duration(seconds: 3));
    final resultList = await _userUseCase.getUsers();
    switch (resultList) {
      case ResultSuccess(data: final list):
        state = UserListSuccess(data: list);
      case ResultError():
        state = UserListError();
    }
  }

  void remove(int id) {
    assert(state is! UserListWait, '대기중일때 데이터를 조작 할 수 없습니다.');
    assert(state is! UserListLoading, '로딩중일때 데이터를 조작 할 수 없습니다.');
    assert(state is! UserListError, '에러일때 데이터를 조작 할 수 없습니다.');
    Log.d('_UserListStateNotifier Remove');
  }
}

sealed class UserListState {}

class UserListWait extends UserListState {}

class UserListLoading extends UserListState {}

class UserListSuccess extends UserListState {
  final List<UserModel> data;

  UserListSuccess({
    required this.data,
  });
}

class UserListError extends UserListState {}
