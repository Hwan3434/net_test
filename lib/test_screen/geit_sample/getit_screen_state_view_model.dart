import 'package:domain/getit/locator.dart';
import 'package:domain/sample/login/impl/login_usercase_impl.dart';
import 'package:domain/sample/login/login_usecase.dart';
import 'package:net_test/test_screen/geit_sample/getit_screen_state.dart';
import 'package:net_test/test_screen/test_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'getit_screen_state_view_model.g.dart';

@riverpod
class GetItScreenViewModel extends _$GetItScreenViewModel {

  late final LoginUseCase _loginUseCase;

  @override
  GetItScreenState build() {
    init();
    return GetItScreenStateWait();
  }

  init(){
    _loginUseCase = locator<LoginUseCaseImpl>();
  }

  void fetchData() async {
    state = GetItScreenStateLoading();

    await Future.delayed(delay);
    await _loginUseCase.loginUsers().then((value) {
      state = GetItScreenStateSuccess(loginUserList: value);
    }).catchError((e) {
      state = GetItScreenStateError(errorMessage: e.toString());
    });

  }
}
