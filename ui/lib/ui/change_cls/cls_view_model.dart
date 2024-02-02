sealed class ClsStateModel {}

class ClsStateModelWait extends ClsStateModel {}

class ClsStateModelLoading extends ClsStateModel {}

class ClsStateModelSuccess extends ClsStateModel {
  final String data;

  ClsStateModelSuccess({
    required this.data,
  });
}

class ClsStateModelError extends ClsStateModel {
  final String errorMessage;

  ClsStateModelError({
    this.errorMessage = '',
  });
}
