import 'package:domain/usecase/login/res_model/login_user_model.dart';

class BufferPageModel {
  final BufferPageState data;
  final BufferUserUpdateState bufferUserUpdateState;

  BufferPageModel({
    required this.data,
    required this.bufferUserUpdateState,
  });

  copyWith({
    BufferPageState? data,
    BufferUserUpdateState? bufferUserUpdateState,
  }) {
    return BufferPageModel(
      data: data ?? this.data,
      bufferUserUpdateState:
          bufferUserUpdateState ?? this.bufferUserUpdateState,
    );
  }
}

sealed class BufferPageState {}

class BufferPageStateWait extends BufferPageState {}

class BufferPageStateLoading extends BufferPageState {}

class BufferPageStateError extends BufferPageState {
  final String errorMessage;

  BufferPageStateError({
    required this.errorMessage,
  });
}

class BufferPageStateSuccess extends BufferPageState {
  BufferPageStateSuccess();
}

sealed class BufferUserUpdateState {
  BufferUserUpdateState();
}

class LoadingBufferUpdate extends BufferUserUpdateState {
  final String stateWait = "WaitBufferUpdate";
  LoadingBufferUpdate();
}

class WaitBufferUpdate extends BufferUserUpdateState {
  final String stateWait = "WaitBufferUpdate";
  WaitBufferUpdate();
}

class SuccessBufferUpdate extends BufferUserUpdateState {
  final String stateSuccess = "SuccessBufferUpdate";
  final List<LoginUserModel> data;
  SuccessBufferUpdate({required this.data});
}

class FailBufferUpdate extends BufferUserUpdateState {
  final String stateFail = "SuccessBufferUpdate";
  FailBufferUpdate();
}
