import 'package:domain/sample/login/provider/login_usecase_provider.dart';
import 'package:net_test/test_screen/buffer_sample/buffer_screen_state.dart';
import 'package:net_test/test_screen/test_screen.dart';
import 'package:net_test/user/buffer/user_manager_buffer_singleton.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'buffer_screen_state_view_model.g.dart';

@riverpod
class BufferScreenViewModel extends _$BufferScreenViewModel {
  @override
  BufferScreenState build() {
    return BufferScreenStateWait();
  }

  void fetchData({required String serviceId,}) async {
    state = BufferScreenStateLoading();
    await Future.delayed(delay);
    await ref.read(loginUseCaseProvider).loginUsers().then((value) {
      UserManagerBufferSingleton().addAll(serviceId: serviceId, users: value);
      state = BufferScreenStateSuccess(isUserUpdateState: SuccessBufferUpdate());
    }).catchError((e) {
      state = BufferScreenStateError(errorMessage: e.toString());
    });

  }
}

