sealed class FirstStateModel {}

class FirstStateModelWait extends FirstStateModel {}

class FirstStateModelLoading extends FirstStateModel {}

class FirstStateModelSuccess extends FirstStateModel {
  final String data;

  FirstStateModelSuccess({
    this.data = '',
  });
}

class FirstStateModelError extends FirstStateModel {
  final String errorMessage;

  FirstStateModelError({
    this.errorMessage = '',
  });
}
