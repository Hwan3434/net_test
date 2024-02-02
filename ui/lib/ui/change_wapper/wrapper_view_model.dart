sealed class WrapperStateModel {}

class WrapperStateModelWait extends WrapperStateModel {}

class WrapperStateModelLoading extends WrapperStateModel {}

class WrapperStateModelSuccess extends WrapperStateModel {
  final String data;

  WrapperStateModelSuccess({
    required this.data,
  });
}

class WrapperStateModelError extends WrapperStateModel {
  final String errorMessage;

  WrapperStateModelError({
    this.errorMessage = '',
  });
}
