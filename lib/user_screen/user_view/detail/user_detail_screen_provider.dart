import 'package:domain/usecase/user/user_usecase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/manager/data_manager.dart';
import 'package:net_test/user_screen/user_view/detail/user_detail_screen_model.dart';

final userDetailScreenProvider = StateNotifierProvider.autoDispose
    .family<_UserDetailScreenStateNotifier, UserDetailScreenStateModel, int>(
        (ref, userId) {
  final serviceId = ref.watch(
      DataManager().usecaseStateProvider.select((value) => value.service));
  final userUseCase =
      ref.read(DataManager().userUseCaseFactoryProvider(serviceId));
  return _UserDetailScreenStateNotifier(userUseCase, userId: userId);
});

class _UserDetailScreenStateNotifier
    extends StateNotifier<UserDetailScreenStateModel> {
  final int userId;
  final UserUseCase _userUseCase;

  _UserDetailScreenStateNotifier(
    this._userUseCase, {
    required this.userId,
  }) : super(UserDetailScreenStateModelWait()) {
    init();
  }

  void init() async {
    state = UserDetailScreenStateModelLoading();
    await Future.delayed(Duration(seconds: 3));
    _userUseCase.getUser(userId: userId).then((value) {
      state = UserDetailScreenStateModelSuccess(
          viewModel: UserDetailScreenDataModel(model: value));
    }).catchError((onError) {
      debugPrint('에러 : ${onError.toString()}');
      state = UserDetailScreenStateModelError();
    });
  }
}
