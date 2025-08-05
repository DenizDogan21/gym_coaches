import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth_repository.dart';

/// Kullanıcı auth durumunu stream olarak getirme use case'i
class GetAuthStateUseCase {
  final AuthRepository _authRepository;

  GetAuthStateUseCase(this._authRepository);

  /// Use case çağırma metodu - stream döndürür
  Stream<User?> call() {
    return _authRepository.authStateChanges;
  }
}