import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth_repository.dart';

/// Yeni kullanıcı kaydı oluşturma use case'i
class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  /// Use case çağırma metodu
  Future<User> call(String email, String password, String displayName) {
    return _authRepository.createUserWithEmailAndPassword(
        email, password, displayName);
  }
}