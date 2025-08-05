/// Base failure sınıfı
abstract class Failure {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});
}

/// Kimlik doğrulama hataları için failure
class AuthFailure extends Failure {
  const AuthFailure({required String message, String? code})
      : super(message: message, code: code);
}

/// Database işlem hataları için failure
class DatabaseFailure extends Failure {
  const DatabaseFailure({required String message, String? code})
      : super(message: message, code: code);
}

/// Network hataları için failure
class NetworkFailure extends Failure {
  const NetworkFailure({required String message, String? code})
      : super(message: message, code: code);
}

/// Kaynak bulunamadı hataları için failure
class NotFoundFailure extends Failure {
  const NotFoundFailure({required String message, String? code})
      : super(message: message, code: code);
}

/// Geçersiz giriş hataları için failure
class ValidationFailure extends Failure {
  const ValidationFailure({required String message, String? code})
      : super(message: message, code: code);
}

/// Beklenmeyen hatalar için failure
class UnexpectedFailure extends Failure {
  const UnexpectedFailure({required String message, String? code})
      : super(message: message, code: code);
}