import 'package:domain/usecase/login/factory/login_usecase_factory_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_test/common/app_const.dart';
import 'package:net_test/test_screen/buffer/buffer_screen_model.dart';
import 'package:net_test/user/buffer/user_manager_buffer_singleton.dart';

final bufferScreenProvider = StateNotifierProvider.autoDispose<
    BufferScreenStateNotifier, BufferScreenModel>((ref) {
  return BufferScreenStateNotifier(ref: ref);
});

class BufferScreenStateNotifier extends StateNotifier<BufferScreenModel> {
  final Ref ref;

  BufferScreenStateNotifier({
    required this.ref,
  }) : super(
          BufferScreenModel(
            state: BufferScreenStateWait(),
            treeState: WaitBufferUpdate(
              userManagerBufferSingleton: UserManagerBufferSingleton(),
            ),
          ),
        );

  void fetchData({
    required String serviceId,
  }) async {
    state = state.copyWith(state: BufferScreenStateLoading());
    await Future.delayed(AppConst.delay);
    await ref.read(loginUseCaseFactoryProvider).loginUsers().then((value) {
      UserManagerBufferSingleton().addAll(serviceId: serviceId, users: value);
      state = state.copyWith(
          isBufferUserUpdateState: SuccessBufferUpdate(
        userManagerBufferSingleton: UserManagerBufferSingleton(),
      ));
    }).catchError((e) {
      state = state.copyWith(
          isBufferUserUpdateState: FailBufferUpdate(
        userManagerBufferSingleton: UserManagerBufferSingleton(),
      ));
    });
  }
}
