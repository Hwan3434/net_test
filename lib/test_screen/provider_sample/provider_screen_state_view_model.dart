import 'package:domain/sample/login/model/login_user_model.dart';
import 'package:domain/sample/login/provider/login_usecase_provider.dart';
import 'package:net_test/test_screen/provider_sample/provider_screen_state.dart';
import 'package:net_test/test_screen/test_screen.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'provider_screen_state_view_model.g.dart';

@riverpod
class ProviderScreenViewModel extends _$ProviderScreenViewModel {
  @override
  ProviderScreenState build() {
    return ProviderScreenStateWait();
  }

  void fetchData() async {
    state = ProviderScreenStateLoading();

    await Future.delayed(delay);

    await ref.read(loginUseCaseProvider).loginUsers().then((value) {
      state = ProviderScreenStateSuccess(loginUserList: value);
    }).catchError((e) {
      state = ProviderScreenStateError(errorMessage: e.toString());
    });
  }


  Future<List<LoginUserModel>> getData() async {
    await Future.delayed(delay);
    return await ref.read(loginUseCaseProvider).loginUsers();
  }

}
