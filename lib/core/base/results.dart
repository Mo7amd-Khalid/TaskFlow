sealed class Results<T>{}

class Success<T> extends Results<T>{
  final T? data;
  final String? message;

  Success({this.data, this.message});
}

class Failure<T> extends Results<T>{
  final Exception? exception;
  final String? message;

  Failure({required this.exception, required this.message});
}
