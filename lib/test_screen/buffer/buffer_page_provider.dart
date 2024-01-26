import 'package:domain/usecase/login/login_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/common/app_global_current_provider.dart';
import 'package:net_test/manager/usecase_provider_manager.dart';
import 'package:net_test/test_screen/buffer/buffer_page_model.dart';
import 'package:net_test/user/buffer/user_manager_buffer_singleton.dart';

final bufferPageProvider =
    StateNotifierProvider.autoDispose<BufferPageStateNotifier, BufferPageModel>(
        (ref) {
  final serviceId = ref.watch(currentProvider.select((value) => value.service));
  final loginUseCase =
      ref.read(UsecaseProviderManager().loginUseCaseFactoryProvider(serviceId));
  return BufferPageStateNotifier(loginUseCase);
});

class BufferPageStateNotifier extends StateNotifier<BufferPageModel> {
  final LoginUseCase _loginUseCase;

  BufferPageStateNotifier(this._loginUseCase)
      : super(
          BufferPageModel(
            data: BufferPageStateWait(),
            bufferUserUpdateState: WaitBufferUpdate(),
          ),
        ) {
    // initLoad();
  }

  void initLoad() async {
    fetchData();
  }

  void fetchData() async {
    state = state.copyWith(bufferUserUpdateState: LoadingBufferUpdate());
    await Future.delayed(AppConst.delay);
    await _loginUseCase.loginUsers(memberNo: 3).then((value) {
      UserManagerBufferSingleton().addAll(users: value);
      state = state.copyWith(
        data: state.data,
        bufferUserUpdateState: SuccessBufferUpdate(
          data: value,
        ),
      );
    }).catchError((e) {
      state = state.copyWith(
        data: state.data,
        bufferUserUpdateState: FailBufferUpdate(),
      );
    });
  }
}
