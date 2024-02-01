import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/manager/data_manager.dart';

import 'inje_user_detail_view_model.dart';

final injeUserDetailViewProvider = StateNotifierProvider.autoDispose
    .family<_InjeUserDetailViewStateNotifier, InjeUserDetailViewModel, int>(
        (ref, userId) {
  final serviceId = ref.read(
      DataManager().usecaseStateProvider.select((value) => value.service));
  final userUseCase =
      ref.read(DataManager().userUseCaseFactoryProvider(serviceId));
  return _InjeUserDetailViewStateNotifier(userUseCase, userId: userId);
});

class _InjeUserDetailViewStateNotifier
    extends StateNotifier<InjeUserDetailViewModel> {
  final int userId;
  final UserUseCase _userUseCase;

  _InjeUserDetailViewStateNotifier(
    this._userUseCase, {
    required this.userId,
  }) : super(InjeUserDetailViewModel()) {
    init();
  }

  void init() {
    fetchData();
  }

  void fetchData() async {
    state =
        InjeUserDetailViewModel(state: InjeUserDetailViewModelState.loading);
    await Future.delayed(Duration(seconds: 3));
    _userUseCase.getUser(userId: userId).then((value) {
      state = InjeUserDetailViewModel(
        state: InjeUserDetailViewModelState.success,
        name: value.name,
        email: value.email,
      );
    }).catchError((onError) {
      debugPrint('에러 : ${onError.toString()}');
      state =
          InjeUserDetailViewModel(state: InjeUserDetailViewModelState.error);
    });
  }
}
