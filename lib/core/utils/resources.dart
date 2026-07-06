enum States { initial, loading, success, failure }

class Resources<T> {
  final T? data;
  final Exception? exception;
  final String? message;
  final States state;

  const Resources.initial()
    : data = null,
      exception = null,
      message = null,
      state = States.initial;

  const Resources.loading({this.data})
    : exception = null,
      message = null,
      state = States.loading;

  const Resources.success({this.data, this.message})
    : exception = null,
      state = States.success;

  const Resources.failure({this.exception, this.message, this.data})
    : state = States.failure;

  const Resources._(this.data, this.state, this.message, this.exception);
}
