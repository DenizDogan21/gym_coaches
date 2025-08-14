import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/trainer.dart';
import '../../domain/repositories/trainer_repository.dart';
import '../models/trainer_model.dart';

class TrainerRepositoryImpl implements TrainerRepository {
  final FirebaseFirestore _firestore;

  TrainerRepositoryImpl({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createTrainer(Trainer trainer) async {
    try {
      final trainerModel = TrainerModel.fromEntity(trainer);
      final data = trainerModel.toFirestore();
      
      print('TrainerRepositoryImpl.createTrainer: About to write trainer data: $data');
      
      await _firestore
          .collection('trainers')
          .doc(trainer.uid)
          .set(data);
      
      print('TrainerRepositoryImpl.createTrainer: Successfully created trainer document with ID: ${trainer.uid}');
    } catch (error, stackTrace) {
      print('TrainerRepositoryImpl.createTrainer: Error creating trainer: $error');
      print('TrainerRepositoryImpl.createTrainer: Stack trace: $stackTrace');
      rethrow;
    }
  }

  @override
  Future<Trainer?> getTrainer(String uid) async {
    try {
      final doc = await _firestore
          .collection('trainers')
          .doc(uid)
          .get();

      if (!doc.exists) {
        return null;
      }

      return TrainerModel.fromFirestore(doc).toEntity();
    } catch (error) {
      print('TrainerRepositoryImpl.getTrainer: Error getting trainer: $error');
      rethrow;
    }
  }

  @override
  Future<void> updateTrainer(Trainer trainer) async {
    try {
      final trainerModel = TrainerModel.fromEntity(trainer);
      final data = trainerModel.toFirestore();
      
      await _firestore
          .collection('trainers')
          .doc(trainer.uid)
          .update(data);
    } catch (error) {
      print('TrainerRepositoryImpl.updateTrainer: Error updating trainer: $error');
      rethrow;
    }
  }

  @override
  Future<void> deleteTrainer(String uid) async {
    try {
      await _firestore
          .collection('trainers')
          .doc(uid)
          .delete();
    } catch (error) {
      print('TrainerRepositoryImpl.deleteTrainer: Error deleting trainer: $error');
      rethrow;
    }
  }
}