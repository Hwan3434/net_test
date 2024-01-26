import 'package:domain/usecase/login/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/common/app_global_current_provider.dart';
import 'package:net_test/manager/usecase_provider_manager.dart';
import 'package:net_test/test_screen/provider/provider_page_model.dart';

final providerPageProvider = StateNotifierProvider.autoDispose<
    ProviderPageStateNotifier, ProviderScreenModel>((ref) {
  final serviceId = ref.watch(currentProvider.select((value) => value.service));
  final loginUseCase =
      ref.read(UsecaseProviderManager().loginUseCaseFactoryProvider(serviceId));
  return ProviderPageStateNotifier(loginUseCase);
});

class ProviderPageStateNotifier extends StateNotifier<ProviderScreenModel> {
  final LoginUseCase _loginUseCase;

  ProviderPageStateNotifier(this._loginUseCase)
      : super(ProviderScreenModelWait()) {
    // init();
  }

  void init() {
    fetchData();
  }

  void fetchData() async {
    state = ProviderScreenModelLoading();

    await Future.delayed(AppConst.delay);
    await _loginUseCase.loginUsers(memberNo: 3).then((value) {
      state = ProviderScreenModelSuccess(loginUserList: value);
    }).catchError((e) {
      state = ProviderScreenModelError(errorMessage: e.toString());
    });
  }
}
