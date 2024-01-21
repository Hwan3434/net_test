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


sealed class BufferUserUpdateState{}

class WaitBufferUpdate extends BufferUserUpdateState{
  final String stateWait = "WaitBufferUpdate";
}

class SuccessBufferUpdate extends BufferUserUpdateState{
  final String stateSuccess = "SuccessBufferUpdate";
}
class FailBufferUpdate extends BufferUserUpdateState{
  final String stateFail = "SuccessBufferUpdate";
}

