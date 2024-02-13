import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/manager/data_manager.dart';

import 'user_list_view_state.dart';

final userListViewProvider = StateNotifierProvider.autoDispose<
    ProviderViewStateNotifier, UserListViewStateModel>((ref) {
  final serviceId = ref.watch(
      DataManager().usecaseStateProvider.select((value) => value.service));
  final userUseCase =
      ref.read(DataManager().userUseCaseFactoryProvider(serviceId));
  return ProviderViewStateNotifier(userUseCase);
});

class ProviderViewStateNotifier extends StateNotifier<UserListViewStateModel> {
  final UserUseCase _loginUseCase;

  ProviderViewStateNotifier(this._loginUseCase)
      : super(UserListViewStateWait()) {
    // init();
  }

  void init() {
    fetchData();
  }

  void fetchData() async {
    state = UserListViewStateLoading();

    await _loginUseCase.getUsers().then((value) {
      switch (value) {
        case ResultSuccess(data: final successData):
          state = UserListViewStateSuccess(successData);
        case ResultError(e: final error):
          state = UserListViewStateError(errorMessage: error.toString());
      }
    });
  }

  void refresh() {
    fetchData();
  }
}
