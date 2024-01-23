import 'package:net_test/user/buffer/user_manager_buffer_singleton.dart';

class BufferScreenModel {
  final BufferScreenState state;
  final BufferUserUpdateState treeState;

  BufferScreenModel({
    required this.state,
    required this.treeState,
  });


  copyWith({
    BufferScreenState? state,
    BufferUserUpdateState? isBufferUserUpdateState,
  }) {
    return BufferScreenModel(
      state: state ?? this.state,
      treeState: isBufferUserUpdateState ?? this.treeState,
    );
  }
}


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
  final UserManagerBufferSingleton userManagerBufferSingleton;
  BufferUserUpdateState({
    required this.userManagerBufferSingleton,
  });
}

class WaitBufferUpdate extends BufferUserUpdateState{
  final String stateWait = "WaitBufferUpdate";
  WaitBufferUpdate({
    required super.userManagerBufferSingleton
  });
}

class SuccessBufferUpdate extends BufferUserUpdateState{
  final String stateSuccess = "SuccessBufferUpdate";
  SuccessBufferUpdate({
    required super.userManagerBufferSingleton
  });
}
class FailBufferUpdate extends BufferUserUpdateState{
  final String stateFail = "SuccessBufferUpdate";
  FailBufferUpdate({
    required super.userManagerBufferSingleton
  });
}

