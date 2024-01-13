import 'package:domain/sample/login/provider/login_usecase_provider.dart';
import 'package:net_test/test_screen/test_screen_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_screen_state_container.g.dart';

@riverpod
class TestScreenStateContainer extends _$TestScreenStateContainer {
  @override
  TestScreenState build() {
    return TestScreenStateWait();
  }

  void fetchData() async {
    state = TestScreenStateLoading();

    await Future.delayed(const Duration(seconds: 3));

    await ref.read(loginUseCaseProvider).loginUsers().then((value) {
      state = TestScreenStateSuccess(loginUserList: value);
    }).catchError((e) {
      state = TestScreenStateError(errorMessage: e.toString());
    });
  }
}
