import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/test/user_data_provider.dart';
import 'package:ui/test/user_use_case.dart';

import 'org_notifier_view_model_2.dart';

final orgNotifierViewProvider2 = StateNotifierProvider.autoDispose<
    _OrgNotifierViewNotifier2, OrgNotifierViewModel>((ref) {
  final userUseCase = ref.read(userUsecaseProvider);
  return _OrgNotifierViewNotifier2(
    userUseCase,
    OrgNotifierViewModel(state: OrgNotifierViewState.wait, data: {}),
  );
});

class _OrgNotifierViewNotifier2 extends StateNotifier<OrgNotifierViewModel> {
  final UserUseCase _userUsecase;
  final _userDataNotifier = UserDataNotifier();
  _OrgNotifierViewNotifier2(this._userUsecase, super._state) {
    _userDataNotifier.addListener(_updateState);
    _init();
  }

  void _init() {
    if (_userDataNotifier.size != 0) {
      _updateState();
    } else {
      callUsers();
    }
  }

  void _updateState() {
    state = state.copyWith(
      state: OrgNotifierViewState.success,
      data: _userDataNotifier.data,
    );
  }

  void callUsers() async {
    state = state.copyWith(state: OrgNotifierViewState.loading);
    await Future.delayed(const Duration(seconds: 2));
    _userUsecase.getUsers().then((value) {
      switch (value) {
        case ResultSuccess(data: final successData):
          _userDataNotifier.addAll(successData);
        case ResultError(e: final error):
          state = state.copyWith(state: OrgNotifierViewState.error);
      }
    });
  }

  void delete(int i) async {
    _userDataNotifier.delete(i);
  }

  @override
  void dispose() {
    super.dispose();
    _userDataNotifier.removeListener(_updateState);
  }
}
