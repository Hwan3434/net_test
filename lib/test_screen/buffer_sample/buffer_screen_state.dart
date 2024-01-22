import 'package:net_test/user/buffer/user_manager_buffer_singleton.dart';

sealed class BufferScreenState {}

class BufferScreenStateWait extends BufferScreenState {}

class BufferScreenStateLoading extends BufferScreenState {}

class BufferScreenStateError extends BufferScreenState {
  final String errorMessage;

  BufferScreenStateError({
    required this.errorMessage,
  });
}

class BufferScreenStateSuccess extends BufferScreenState {
  final BufferUserUpdateState isUserUpdateState;

  BufferScreenStateSuccess({
    required this.isUserUpdateState,
  });
}


sealed class BufferUserUpdateState{
  UserManagerBufferSingleton tree;
  BufferUserUpdateState({required this.tree});
}

class WaitBufferUpdate extends BufferUserUpdateState{
  final String stateWait = "WaitBufferUpdate";
  WaitBufferUpdate({required super.tree});
}

class SuccessBufferUpdate extends BufferUserUpdateState{
  final String stateSuccess = "SuccessBufferUpdate";
  SuccessBufferUpdate({required super.tree});

}
class FailBufferUpdate extends BufferUserUpdateState{
  final String stateFail = "SuccessBufferUpdate";
  FailBufferUpdate({required super.tree});
}

