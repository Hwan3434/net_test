sealed class OriginalViewStateModel {}

class OriginalViewStateLoading extends OriginalViewStateModel {}

class OriginalViewStateWait extends OriginalViewStateModel {}

class OriginalViewStateSuccess extends OriginalViewStateModel {
  final String data;
  OriginalViewStateSuccess({required this.data});
}

class OriginalViewStateError extends OriginalViewStateModel {
  final String errorMessage;
  OriginalViewStateError({required this.errorMessage});
}
