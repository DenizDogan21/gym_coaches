import '../entities/trainer.dart';

abstract class TrainerRepository {
  Future<void> createTrainer(Trainer trainer);
  Future<Trainer?> getTrainer(String uid);
  Future<void> updateTrainer(Trainer trainer);
  Future<void> deleteTrainer(String uid);
}