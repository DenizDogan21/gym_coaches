import '../../repositories/auth_repository.dart';

/// Çıkış yapma use case'i
class SignOutUseCase {
  final AuthRepository _authRepository;

  SignOutUseCase(this._authRepository);

  /// Use case çağırma metodu
  Future<void> call() {
    return _authRepository.signOut();
  }
}