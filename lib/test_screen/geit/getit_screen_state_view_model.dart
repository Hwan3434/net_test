import 'package:domain/getit/locator.dart';
import 'package:domain/usecase/login/impl/login_usercase_impl.dart';
import 'package:domain/usecase/login/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/test_screen/geit/getit_screen_model.dart';
import 'package:net_test/test_screen/test_screen.dart';

final getItScreenProvider =
    StateNotifierProvider<GetItScreenStateNotifier, GetItScreenModel>((ref) {
  final loginUseCase = locator<LoginUseCaseImpl>();
  return GetItScreenStateNotifier(loginUseCase);
});

class GetItScreenStateNotifier extends StateNotifier<GetItScreenModel> {
  final LoginUseCase _loginUseCase;

  GetItScreenStateNotifier(
    this._loginUseCase,
  ) : super(GetItScreenModelWait());

  void fetchData() async {
    state = GetItScreenModelLoading();

    await Future.delayed(AppConst.delay);
    await _loginUseCase.loginUsers().then((value) {
      state = GetItScreenModelSuccess(loginUserList: value);
    }).catchError((e) {
      state = GetItScreenModelError(errorMessage: e.toString());
    });
  }
}
