import 'package:domain/usecase/login/factory/login_usecase_factory_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/test_screen/provider/provider_screen_model.dart';
import 'package:net_test/test_screen/test_screen.dart';

final providerScreenProvider = StateNotifierProvider.autoDispose<
    ProviderScreenStateNotifier, ProviderScreenModel>((ref) {
  return ProviderScreenStateNotifier(ref: ref);
});

class ProviderScreenStateNotifier extends StateNotifier<ProviderScreenModel> {
  final Ref ref;

  ProviderScreenStateNotifier({
    required this.ref,
  }) : super(ProviderScreenModelWait());

  void fetchData() async {
    state = ProviderScreenModelLoading();

    await Future.delayed(AppConst.delay);
    await ref.read(loginUseCaseFactoryProvider).loginUsers().then((value) {
      state = ProviderScreenModelSuccess(loginUserList: value);
    }).catchError((e) {
      state = ProviderScreenModelError(errorMessage: e.toString());
    });
  }
}
