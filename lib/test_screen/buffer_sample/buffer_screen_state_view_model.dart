import 'package:domain/sample/login/provider/login_usecase_provider.dart';
import 'package:net_test/test_screen/buffer_sample/buffer_screen_state.dart';
import 'package:net_test/test_screen/test_screen.dart';
import 'package:net_test/user/buffer/user_manager_buffer_singleton.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'buffer_screen_state_view_model.g.dart';

@riverpod
class BufferScreenViewModel extends _$BufferScreenViewModel {

  @override
  BufferScreenModel build() {
    return BufferScreenModel(
      model: BufferScreenStateWait(),
      treeState: WaitBufferUpdate(
        tree: UserManagerBufferSingleton(),
      ),
    );
  }

  void fetchData({required String serviceId,}) async {
    /// 문제 발생 !!
    state = state.copyWith(
      state: BufferScreenStateLoading()
    );
    await Future.delayed(delay);
    await ref.read(loginUseCaseProvider).loginUsers().then((value) {
      UserManagerBufferSingleton().addAll(serviceId: serviceId, users: value);
      state = state.copyWith(isBufferUserUpdateState: SuccessBufferUpdate(
        tree: UserManagerBufferSingleton(),
      ));
    }).catchError((e) {
      state = state.copyWith(isBufferUserUpdateState: FailBufferUpdate(
        tree: UserManagerBufferSingleton(),
      ));
    });
  }
}



class BufferScreenModel {
  final BufferScreenState model;
  final BufferUserUpdateState treeState;


  BufferScreenModel({
    required this.model,
    required this.treeState,
  });


  copyWith({
    BufferScreenState? state,
    BufferUserUpdateState? isBufferUserUpdateState,
  }) {
    return BufferScreenModel(
      model: state ?? this.model,
      treeState: isBufferUserUpdateState ?? this.treeState,
    );
  }
}

