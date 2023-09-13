sealed class ApiResponse {}

class Success<T> extends ApiResponse {
  final T data;
  Success({required this.data});
}

class Error extends ApiResponse {
  final String message;
  Error({required this.message});
}