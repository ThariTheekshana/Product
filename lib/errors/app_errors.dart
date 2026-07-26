// errors/app_errors.dart
abstract class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => message;
}

/// No connectivity or the request timed out.
class NetworkException extends AppException {
  const NetworkException()
      : super('Network error. Please check your connection.');
}

/// Server responded with a non-2xx status code.
class ServerException extends AppException {
  final int statusCode;
  ServerException(this.statusCode)
      : super('Server error ($statusCode). Please try again later.');
}

/// API response could not be decoded.
class ParseException extends AppException {
  const ParseException() : super('Could not read product data.');
}

/// Catch-all for unexpected runtime errors.
class UnexpectedException extends AppException {
  const UnexpectedException()
      : super('Something went wrong. Please try again.');
}
