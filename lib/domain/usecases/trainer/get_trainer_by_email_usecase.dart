import '../../entities/trainer_entity.dart';
import '../../repositories/trainer_repository.dart';

/// Email'e göre eğitmen getirme use case'i
class GetTrainerByEmailUseCase {
  final TrainerRepository _trainerRepository;

  GetTrainerByEmailUseCase(this._trainerRepository);

  /// Use case çağırma metodu
  Future<TrainerEntity?> call(String email) {
    return _trainerRepository.getTrainerByEmail(email);
  }
}