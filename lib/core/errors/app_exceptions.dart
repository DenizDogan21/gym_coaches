/// Uygulama genelinde kullanılacak temel exception sınıfı
class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.stackTrace,
  });

  @override
  String toString() => 'AppException: $message (Code: $code)';
}

/// Authentication ile ilgili hatalar için exception
class AuthException extends AppException {
  AuthException({
    required String message,
    String? code,
    dynamic stackTrace,
  }) : super(
    message: message,
    code: code,
    stackTrace: stackTrace,
  );

  /// Firebase auth hatalarını özelleştirilmiş hatalara dönüştürme
  factory AuthException.fromFirebaseAuthError(String code) {
    switch (code) {
      case 'user-not-found':
        return AuthException(
          message: 'Bu e-posta adresine sahip kullanıcı bulunamadı.',
          code: code,
        );
      case 'wrong-password':
        return AuthException(
          message: 'Hatalı şifre girdiniz.',
          code: code,
        );
      case 'email-already-in-use':
        return AuthException(
          message: 'Bu e-posta adresi zaten kullanımda.',
          code: code,
        );
      case 'weak-password':
        return AuthException(
          message: 'Şifre çok zayıf. Daha güçlü bir şifre belirleyin.',
          code: code,
        );
      case 'invalid-email':
        return AuthException(
          message: 'Geçersiz e-posta adresi.',
          code: code,
        );
      case 'user-disabled':
        return AuthException(
          message: 'Bu kullanıcı hesabı devre dışı bırakılmış.',
          code: code,
        );
      case 'too-many-requests':
        return AuthException(
          message: 'Çok fazla başarısız giriş denemesi. Lütfen daha sonra tekrar deneyin.',
          code: code,
        );
      default:
        return AuthException(
          message: 'Kimlik doğrulama hatası: $code',
          code: code,
        );
    }
  }
}

/// Database ile ilgili hatalar için exception
class DatabaseException extends AppException {
  DatabaseException({
    required String message,
    String? code,
    dynamic stackTrace,
  }) : super(
    message: message,
    code: code,
    stackTrace: stackTrace,
  );
}

/// Network ile ilgili hatalar için exception
class NetworkException extends AppException {
  NetworkException({
    required String message,
    String? code,
    dynamic stackTrace,
  }) : super(
    message: message,
    code: code,
    stackTrace: stackTrace,
  );
}

/// Geçersiz veri formatı hataları için exception
class FormatException extends AppException {
  FormatException({
    required String message,
    String? code,
    dynamic stackTrace,
  }) : super(
    message: message,
    code: code,
    stackTrace: stackTrace,
  );
}

/// Kaynak bulunamadı hataları için exception
class NotFoundException extends AppException {
  NotFoundException({
    required String message,
    String? code,
    dynamic stackTrace,
  }) : super(
    message: message,
    code: code,
    stackTrace: stackTrace,
  );
}