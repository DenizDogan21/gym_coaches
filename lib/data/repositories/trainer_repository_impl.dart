import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/errors/app_exceptions.dart';
import '../../core/providers/providers.dart';
import '../../domain/entities/trainer_entity.dart';
import '../../domain/repositories/trainer_repository.dart';
import '../models/trainer_model.dart';

final trainerRepositoryImplProvider = Provider<TrainerRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return TrainerRepositoryImpl(firestore);
});

class TrainerRepositoryImpl implements TrainerRepository {
  final FirebaseFirestore _firestore;

  TrainerRepositoryImpl(this._firestore);

  @override
  Future<TrainerEntity?> getTrainerById(String id) async {
    try {
      final doc = await _firestore.collection('trainers').doc(id).get();
      if (doc.exists && doc.data() != null) {
        return TrainerModel.fromFirestore(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      throw DatabaseException(
        message: 'Eğitmen bilgileri alınamadı',
        code: 'get-trainer-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> createTrainer(TrainerEntity trainer) async {
    try {
      final trainerModel = trainer is TrainerModel
          ? trainer
          : TrainerModel.fromEntity(trainer);

      await _firestore
          .collection('trainers')
          .doc(trainer.id)
          .set(trainerModel.toFirestore());

    } catch (e) {
      throw DatabaseException(
        message: 'Eğitmen oluşturulamadı',
        code: 'create-trainer-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> updateTrainer(TrainerEntity trainer) async {
    try {
      final trainerModel = trainer is TrainerModel
          ? trainer
          : TrainerModel.fromEntity(trainer);

      await _firestore
          .collection('trainers')
          .doc(trainer.id)
          .update(trainerModel.toFirestore());

    } catch (e) {
      throw DatabaseException(
        message: 'Eğitmen güncellenemedi',
        code: 'update-trainer-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<List<TrainerEntity>> getAllTrainers() async {
    try {
      final querySnapshot = await _firestore.collection('trainers').get();

      return querySnapshot.docs
          .map((doc) => TrainerModel.fromFirestore(doc.data(), doc.id))
          .toList();

    } catch (e) {
      throw DatabaseException(
        message: 'Eğitmenler listesi alınamadı',
        code: 'get-all-trainers-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<TrainerEntity?> getTrainerByEmail(String email) async {
    try {
      final querySnapshot = await _firestore
          .collection('trainers')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      final doc = querySnapshot.docs.first;
      return TrainerModel.fromFirestore(doc.data(), doc.id);

    } catch (e) {
      throw DatabaseException(
        message: 'E-posta ile eğitmen bulunamadı',
        code: 'get-trainer-by-email-error',
        stackTrace: e,
      );
    }
  }
}