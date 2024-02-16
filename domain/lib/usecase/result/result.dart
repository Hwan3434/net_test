sealed class Result<T> {}

class ResultSuccess<T> extends Result<T> {
  T data;
  ResultSuccess(this.data);
}

class ResultError<T> extends Result<T> {
  Error e;
  ResultError(this.e);
}

sealed class Error {
  final String errorMessage;

  const Error({
    required this.errorMessage,
  });
}

class NetworkError extends Error {
  NetworkError({required super.errorMessage});
}

class LocalError extends Error {
  LocalError({required super.errorMessage});
}
