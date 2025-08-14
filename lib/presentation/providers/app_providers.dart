import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/trainer_repository_impl.dart';
import '../../domain/repositories/trainer_repository.dart';
import '../features/auth/viewmodels/auth_viewmodel.dart';

// Firebase providers
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// Repository providers
final trainerRepositoryProvider = Provider<TrainerRepository>((ref) {
  final firestore = ref.read(firestoreProvider);
  return TrainerRepositoryImpl(firestore: firestore);
});

// ViewModel providers
final authViewModelProvider = StateNotifierProvider<AuthViewModel, AsyncValue<User?>>((ref) {
  final auth = ref.read(firebaseAuthProvider);
  final trainerRepository = ref.read(trainerRepositoryProvider);
  return AuthViewModel(
    auth: auth,
    trainerRepository: trainerRepository,
  );
});