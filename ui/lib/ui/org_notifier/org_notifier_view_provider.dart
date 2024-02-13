import 'package:domain/usecase/result/result.dart';
import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ui/test/user_data_provider.dart';
import 'package:ui/test/user_use_case.dart';

import 'org_notifier_view_model.dart';

final orgNotifierViewProvider = StateNotifierProvider.autoDispose<
    _OrgNotifierViewNotifier, OrgNotifierStateModel>((ref) {
  final userUseCase = ref.read(userUsecaseProvider);
  return _OrgNotifierViewNotifier(userUseCase);
});

class _OrgNotifierViewNotifier extends StateNotifier<OrgNotifierStateModel> {
  final UserUseCase _userUsecase;
  final _userDataNotifier = UserDataNotifier();
  _OrgNotifierViewNotifier(this._userUsecase)
      : super(OrgNotifierStateModelWait()) {
    _userDataNotifier.addListener(_updateState);
    _init();
  }

  void _init() {
    if (_userDataNotifier.size != 0) {
      state = OrgNotifierStateModelSuccess(data: _userDataNotifier.data);
    } else {
      callUsers();
    }
  }

  void _updateState() {
    state = OrgNotifierStateModelSuccess(data: _userDataNotifier.data);
  }

  void callUsers() async {
    state = OrgNotifierStateModelLoading();
    // await Future.delayed(const Duration(seconds: 2));
    _userUsecase.getUsers().then((value) {
      switch (value) {
        case ResultSuccess(data: final successData):
          _userDataNotifier.addAll(successData);
        case ResultError(e: final error):
          debugPrint('error : $error');
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
