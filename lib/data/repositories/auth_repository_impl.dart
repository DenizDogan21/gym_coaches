import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/errors/app_exceptions.dart';
import '../../core/providers/providers.dart';
import '../../domain/repositories/auth_repository.dart';

final authRepositoryImplProvider = Provider<AuthRepository>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthRepositoryImpl(firebaseAuth);
});

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;

  AuthRepositoryImpl(this._firebaseAuth);

  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw AuthException(
          message: 'Giriş yapılamadı.',
          code: 'null-user',
        );
      }

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuthError(e.code);
    } catch (e) {
      throw AuthException(
        message: 'Giriş yaparken beklenmeyen bir hata oluştu.',
        code: 'unknown-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user == null) {
        throw AuthException(
          message: 'Kullanıcı oluşturulamadı.',
          code: 'null-user',
        );
      }

      // Kullanıcı profili güncelleme
      await credential.user!.updateDisplayName(displayName);

      // Profil güncellemelerinin aktif olması için kullanıcıyı yeniden yükle
      await credential.user!.reload();

      return _firebaseAuth.currentUser!;
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuthError(e.code);
    } catch (e) {
      throw AuthException(
        message: 'Kullanıcı oluştururken beklenmeyen bir hata oluştu.',
        code: 'unknown-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthException(
        message: 'Çıkış yapılırken bir hata oluştu.',
        code: 'sign-out-error',
        stackTrace: e,
      );
    }
  }

  @override
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
}