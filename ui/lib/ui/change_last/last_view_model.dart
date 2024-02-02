sealed class LastStateModel {}

class LastStateModelWait extends LastStateModel {}

class LastStateModelLoading extends LastStateModel {}

class LastStateModelSuccess extends LastStateModel {
  final String data;

  LastStateModelSuccess({
    required this.data,
  });
}

class LastStateModelError extends LastStateModel {
  final String errorMessage;

  LastStateModelError({
    this.errorMessage = '',
  });
}
