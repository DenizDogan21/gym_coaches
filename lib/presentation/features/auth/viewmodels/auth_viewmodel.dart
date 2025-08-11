import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../domain/entities/trainer_entity.dart';
import '../../../../core/providers/providers.dart';
import '../../../../domain/repositories/auth_repository.dart';
import '../../../../domain/repositories/trainer_repository.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final trainerRepository = ref.watch(trainerRepositoryProvider);
  return AuthViewModel(authRepository, trainerRepository);
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final TrainerRepository _trainerRepository;

  AuthViewModel(this._authRepository, this._trainerRepository)
      : super(const AuthState.initial()) {
    // Başlangıçta auth durumunu kontrol et
    _checkCurrentUser();
  }

  // Mevcut kullanıcıyı kontrol et
  Future<void> _checkCurrentUser() async {
    final user = _authRepository.getCurrentUser();
    if (user != null) {
      try {
        final trainer = await _trainerRepository.getTrainerById(user.uid);
        if (trainer != null) {
          state = AuthState.authenticated(user: user, trainer: trainer);
        } else {
          state = const AuthState.unauthenticated();
        }
      } catch (e) {
        state = AuthState.error(message: e.toString());
      }
    } else {
      state = const AuthState.unauthenticated();
    }
  }

  // Giriş yapma
  Future<void> signIn(String email, String password) async {
    state = const AuthState.authenticating();

    try {
      final user = await _authRepository.signInWithEmailAndPassword(email, password);
      final trainer = await _trainerRepository.getTrainerById(user.uid);

      if (trainer != null) {
        state = AuthState.authenticated(user: user, trainer: trainer);
      } else {
        // Eğer trainer bilgisi yoksa hata durumu
        state = const AuthState.error(message: "Eğitmen bilgileri bulunamadı");
      }
    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }

  // Kayıt olma
  Future<void> signUp(String email, String password, String name) async {
    state = const AuthState.authenticating();

    try {
      // Kullanıcı oluştur
      final user = await _authRepository.createUserWithEmailAndPassword(
        email,
        password,
        name,
      );

      // Trainer oluştur
      final trainer = TrainerEntity(
        id: user.uid,
        name: name,
        email: email,
        phoneNumber: "",
        address: "",
        photoUrl: null,
        studentIds: [],
        createdAt: DateTime.now(),
      );

      await _trainerRepository.createTrainer(trainer);

      state = AuthState.authenticated(user: user, trainer: trainer);
    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }

  // Çıkış yapma
  Future<void> signOut() async {
    try {
      await _authRepository.signOut();
      state = const AuthState.unauthenticated();
    } catch (e) {
      state = AuthState.error(message: e.toString());
    }
  }
}

// Auth state sınıfı
class AuthState {
  final bool isLoading;
  final User? user;
  final TrainerEntity? trainer;
  final String? errorMessage;

  const AuthState({
    required this.isLoading,
    this.user,
    this.trainer,
    this.errorMessage,
  });

  const AuthState.initial()
      : isLoading = true,
        user = null,
        trainer = null,
        errorMessage = null;

  const AuthState.authenticating()
      : isLoading = true,
        user = null,
        trainer = null,
        errorMessage = null;

  const AuthState.unauthenticated()
      : isLoading = false,
        user = null,
        trainer = null,
        errorMessage = null;

  const AuthState.authenticated({
    required User user,
    required TrainerEntity trainer,
  }) : isLoading = false,
        user = user,
        trainer = trainer,
        errorMessage = null;

  const AuthState.error({required String message})
      : isLoading = false,
        user = null,
        trainer = null,
        errorMessage = message;

  bool get isAuthenticated => user != null && trainer != null;
}
