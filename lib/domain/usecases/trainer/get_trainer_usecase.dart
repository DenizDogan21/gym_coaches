import '../../entities/trainer_entity.dart';
import '../../repositories/trainer_repository.dart';

/// Eğitmen bilgilerini getirme use case'i
class GetTrainerUseCase {
  final TrainerRepository _trainerRepository;

  GetTrainerUseCase(this._trainerRepository);

  /// Use case çağırma metodu
  Future<TrainerEntity?> call(String trainerId) {
    return _trainerRepository.getTrainerById(trainerId);
  }
}