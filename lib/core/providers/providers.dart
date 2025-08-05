import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_coaches/domain/entities/trainer_entity.dart';
import 'package:gym_coaches/domain/usecases/auth/get_auth_state_usecase.dart';
import 'package:gym_coaches/domain/usecases/auth/get_current_user_usecase.dart';
import 'package:gym_coaches/domain/usecases/auth/sign_in_usecase.dart';
import 'package:gym_coaches/domain/usecases/auth/sign_out_usecase.dart';
import 'package:gym_coaches/domain/usecases/auth/sign_up_usecase.dart';
import 'package:gym_coaches/domain/usecases/trainer/create_trainer_usecase.dart';
import 'package:gym_coaches/domain/usecases/trainer/get_trainer_by_email_usecase.dart';
import 'package:gym_coaches/domain/usecases/trainer/get_trainer_usecase.dart';
import 'package:gym_coaches/domain/usecases/trainer/update_trainer_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/trainer_repository_impl.dart';
import '../../data/repositories/student_repository_impl.dart';
import '../../data/repositories/workout_repository_impl.dart';
import '../../data/repositories/payment_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/trainer_repository.dart';
import '../../domain/repositories/student_repository.dart';
import '../../domain/repositories/workout_repository.dart';
import '../../domain/repositories/payment_repository.dart';

import '../logging/logger.dart';
import '../logging/analytics.dart';
import '../utils/shared_prefs.dart';

// Firebase servisleri için provider'lar
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firebaseAnalyticsProvider = Provider<FirebaseAnalytics>((ref) {
  return FirebaseAnalytics.instance;
});

// Repository provider'ları
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(firebaseAuthProvider));
});

final trainerRepositoryProvider = Provider<TrainerRepository>((ref) {
  return TrainerRepositoryImpl(ref.watch(firebaseFirestoreProvider));
});

final studentRepositoryProvider = Provider<StudentRepository>((ref) {
  return StudentRepositoryImpl(ref.watch(firebaseFirestoreProvider));
});

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  return WorkoutRepositoryImpl(ref.watch(firebaseFirestoreProvider));
});

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return PaymentRepositoryImpl(ref.watch(firebaseFirestoreProvider));
});

// Diğer Utility provider'lar
final loggerProvider = Provider<AppLogger>((ref) {
  return AppLogger();
});

final analyticsProvider = Provider<Analytics>((ref) {
  return Analytics(ref.watch(loggerProvider), ref.watch(firebaseAnalyticsProvider));
});

final sharedPrefsProvider = Provider<SharedPrefs>((ref) {
  throw UnimplementedError('SharedPrefs provider should be overridden with SharedPrefs instance');
});

// User stream provider - auth durumunu tüm uygulamada izlemek için
final authStateChangesProvider = StreamProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).authStateChanges();
});

// Mevcut kullanıcıyı okumak için provider
final currentUserProvider = Provider<User?>((ref) {
  return ref.watch(authStateChangesProvider).asData?.value;
});

// Kullanıcının giriş yapıp yapmadığını kontrol eden provider
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider) != null;
});

// Mevcut trainer bilgilerini sağlayan provider
final currentTrainerProvider = FutureProvider<TrainerEntity?>((ref) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;

  final trainerRepository = ref.watch(trainerRepositoryProvider);
  return await trainerRepository.getTrainerById(user.uid);
});

// Use Case Providers
// Auth Use Case Providers
final signInUseCaseProvider = Provider((ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
});

final signUpUseCaseProvider = Provider((ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
});

final signOutUseCaseProvider = Provider((ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
});

final getCurrentUserUseCaseProvider = Provider((ref) {
  return GetCurrentUserUseCase(ref.watch(authRepositoryProvider));
});

final getAuthStateUseCaseProvider = Provider((ref) {
  return GetAuthStateUseCase(ref.watch(authRepositoryProvider));
});

// Trainer Use Case Providers
final getTrainerUseCaseProvider = Provider((ref) {
  return GetTrainerUseCase(ref.watch(trainerRepositoryProvider));
});

final createTrainerUseCaseProvider = Provider((ref) {
  return CreateTrainerUseCase(ref.watch(trainerRepositoryProvider));
});

final updateTrainerUseCaseProvider = Provider((ref) {
  return UpdateTrainerUseCase(ref.watch(trainerRepositoryProvider));
});

final getTrainerByEmailUseCaseProvider = Provider((ref) {
  return GetTrainerByEmailUseCase(ref.watch(trainerRepositoryProvider));
});