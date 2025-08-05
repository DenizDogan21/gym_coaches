import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth_repository.dart';

/// Email ve şifre ile giriş yapma use case'i
class SignInUseCase {
  final AuthRepository _authRepository;

  SignInUseCase(this._authRepository);

  /// Use case çağırma metodu
  Future<User> call(String email, String password) {
    return _authRepository.signInWithEmailAndPassword(email, password);
  }
}