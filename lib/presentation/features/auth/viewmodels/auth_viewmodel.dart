import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/trainer.dart';
import '../../../domain/repositories/trainer_repository.dart';

class AuthViewModel extends StateNotifier<AsyncValue<User?>> {
  final FirebaseAuth _auth;
  final TrainerRepository _trainerRepository;

  AuthViewModel({
    required FirebaseAuth auth,
    required TrainerRepository trainerRepository,
  })  : _auth = auth,
        _trainerRepository = trainerRepository,
        super(AsyncValue.data(auth.currentUser));

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      state = const AsyncValue.loading();
      
      print('AuthViewModel.signUp: Starting sign up process for email: $email');
      
      // Create Firebase Authentication user
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      final user = userCredential.user;
      if (user == null) {
        throw Exception('Failed to create user');
      }
      
      print('AuthViewModel.signUp: Successfully created Firebase user with UID: ${user.uid}');
      
      // Create trainer document in Firestore
      print('AuthViewModel.signUp: Starting trainer creation in Firestore');
      
      final trainer = Trainer(
        uid: user.uid,
        name: name,
        email: email,
        createdAt: DateTime.now(),
      );
      
      await _trainerRepository.createTrainer(trainer);
      
      print('AuthViewModel.signUp: Successfully created trainer document');
      
      state = AsyncValue.data(user);
    } catch (error, stackTrace) {
      print('AuthViewModel.signUp: Error during sign up: $error');
      print('AuthViewModel.signUp: Stack trace: $stackTrace');
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      state = const AsyncValue.loading();
      
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      state = AsyncValue.data(userCredential.user);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}