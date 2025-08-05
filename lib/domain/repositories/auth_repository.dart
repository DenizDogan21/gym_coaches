import 'package:firebase_auth/firebase_auth.dart';

/// Auth işlemleri için soyut repository arayüzü
abstract class AuthRepository {
  /// Email ve şifre ile giriş yapma
  Future<User> signInWithEmailAndPassword(String email, String password);

  /// Email, şifre ve ad ile yeni hesap oluşturma
  Future<User> createUserWithEmailAndPassword(
      String email, String password, String displayName);

  /// Çıkış yapma
  Future<void> signOut();

  /// Mevcut oturum açmış kullanıcıyı alma
  User? getCurrentUser();

  /// Auth durum değişikliklerini dinleme stream'i
  Stream<User?> get authStateChanges;
}