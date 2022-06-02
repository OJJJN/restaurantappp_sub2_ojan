enum Status{loading, hasData, error}

class ResultState<T>{
  final Status status;
  final String? message;
  final T? data;

  ResultState({
    required this.status,
    required this.message,
    required this.data
  });
}