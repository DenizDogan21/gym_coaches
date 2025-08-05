import '../../entities/trainer_entity.dart';
import '../../repositories/trainer_repository.dart';

/// Eğitmen bilgilerini güncelleme use case'i
class UpdateTrainerUseCase {
  final TrainerRepository _trainerRepository;

  UpdateTrainerUseCase(this._trainerRepository);

  /// Use case çağırma metodu
  Future<void> call(TrainerEntity trainer) {
    return _trainerRepository.updateTrainer(trainer);
  }
}