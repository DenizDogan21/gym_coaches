import 'package:firebase_auth/firebase_auth.dart';
import '../../repositories/auth_repository.dart';

/// Mevcut kullanıcıyı getirme use case'i
class GetCurrentUserUseCase {
  final AuthRepository _authRepository;

  GetCurrentUserUseCase(this._authRepository);

  /// Use case çağırma metodu
  User? call() {
    return _authRepository.getCurrentUser();
  }
}