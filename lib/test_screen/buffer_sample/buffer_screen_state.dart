import 'package:domain/sample/login/model/login_user_model.dart';

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

class SuccessBufferUpdate extends BufferUserUpdateState{}
class FailBufferUpdate extends BufferUserUpdateState{}

