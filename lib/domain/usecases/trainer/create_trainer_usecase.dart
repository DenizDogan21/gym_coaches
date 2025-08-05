import '../../entities/trainer_entity.dart';
import '../../repositories/trainer_repository.dart';

/// Yeni eğitmen oluşturma use case'i
class CreateTrainerUseCase {
  final TrainerRepository _trainerRepository;

  CreateTrainerUseCase(this._trainerRepository);

  /// Use case çağırma metodu
  Future<void> call(TrainerEntity trainer) {
    return _trainerRepository.createTrainer(trainer);
  }
}