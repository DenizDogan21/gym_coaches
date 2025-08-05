import 'app_exceptions.dart';
import 'failures.dart';
import '../logging/logger.dart';

/// Hataları yakalayıp uygun Failure nesnelerine çeviren sınıf
class ErrorHandler {
  final AppLogger _logger;

  ErrorHandler(this._logger);

  /// Exception'ı Failure'a çevirme
  Failure handleError(dynamic error) {
    _logger.e('Error caught: $error');

    if (error is AuthException) {
      return AuthFailure(
        message: error.message,
        code: error.code,
      );
    }

    if (error is DatabaseException) {
      return DatabaseFailure(
        message: error.message,
        code: error.code,
      );
    }

    if (error is NetworkException) {
      return NetworkFailure(
        message: error.message,
        code: error.code,
      );
    }

    if (error is NotFoundException) {
      return NotFoundFailure(
        message: error.message,
        code: error.code,
      );
    }

    if (error is FormatException) {
      return ValidationFailure(
        message: error.message,
        code: error.code,
      );
    }

    // Diğer tüm hatalar için unexpected failure
    return UnexpectedFailure(
      message: error.toString(),
      code: 'unexpected_error',
    );
  }
}