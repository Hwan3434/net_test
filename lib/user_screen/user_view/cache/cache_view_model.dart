import 'package:domain/usecase/user/model/response/user_model.dart';

class CacheViewModel {
  final CacheViewState data;
  final CacheUserUpdateState bufferUserUpdateState;

  CacheViewModel({
    required this.data,
    required this.bufferUserUpdateState,
  });

  copyWith({
    CacheViewState? data,
    CacheUserUpdateState? bufferUserUpdateState,
  }) {
    return CacheViewModel(
      data: data ?? this.data,
      bufferUserUpdateState:
          bufferUserUpdateState ?? this.bufferUserUpdateState,
    );
  }
}

sealed class CacheViewState {}

class CacheViewStateWait extends CacheViewState {}

class CacheViewStateLoading extends CacheViewState {}

class CacheViewStateError extends CacheViewState {
  final String errorMessage;

  CacheViewStateError({
    required this.errorMessage,
  });
}

class CacheViewStateSuccess extends CacheViewState {
  CacheViewStateSuccess();
}

sealed class CacheUserUpdateState {
  CacheUserUpdateState();
}

class LoadingBufferUpdate extends CacheUserUpdateState {
  final String stateWait = "WaitBufferUpdate";
  LoadingBufferUpdate();
}

class WaitBufferUpdate extends CacheUserUpdateState {
  final String stateWait = "WaitBufferUpdate";
  WaitBufferUpdate();
}

class SuccessBufferUpdate extends CacheUserUpdateState {
  final String stateSuccess = "SuccessBufferUpdate";
  final List<UserDataModel> data;
  SuccessBufferUpdate({required this.data});
}

class FailBufferUpdate extends CacheUserUpdateState {
  final String stateFail = "SuccessBufferUpdate";
  FailBufferUpdate();
}
