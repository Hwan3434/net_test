sealed class Result<T> {}

class ResultSuccess<T> extends Result<T> {
  T data;
  ResultSuccess(this.data);
}

class ResultError<T> extends Result<T> {
  Error e;
  ResultError(this.e);
}

sealed class Error {}

class NetworkError extends Error {}

class LocalError extends Error {
  String errorMessage;
  LocalError(this.errorMessage);
}
