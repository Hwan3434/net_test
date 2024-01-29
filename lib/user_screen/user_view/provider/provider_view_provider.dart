import 'package:domain/usecase/user/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/manager/data_manager.dart';
import 'package:net_test/user_screen/user_view/provider/provider_view_model.dart';

final providerViewProvider = StateNotifierProvider.autoDispose<
    ProviderViewStateNotifier, ProviderViewModel>((ref) {
  final serviceId = ref.watch(
      DataManager().usecaseStateProvider.select((value) => value.service));
  final userUseCase =
      ref.read(DataManager().loginUseCaseFactoryProvider(serviceId));
  return ProviderViewStateNotifier(userUseCase);
});

class ProviderViewStateNotifier extends StateNotifier<ProviderViewModel> {
  final UserUseCase _loginUseCase;

  ProviderViewStateNotifier(this._loginUseCase)
      : super(ProviderViewModelWait()) {
    // init();
  }

  void init() {
    fetchData();
  }

  void fetchData() async {
    state = ProviderViewModelLoading();

    await Future.delayed(AppConst.delay);
    await _loginUseCase.getUsers().then((value) {
      state = ProviderScreenModelSuccess(loginUserList: value);
    }).catchError((e) {
      state = ProviderViewModelError(errorMessage: e.toString());
    });
  }

  void refresh() {
    fetchData();
  }
}
