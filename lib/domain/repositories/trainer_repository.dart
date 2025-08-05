import '../entities/trainer_entity.dart';

/// Eğitmen işlemleri için soyut repository arayüzü
abstract class TrainerRepository {
  /// ID'ye göre eğitmen getirme
  Future<TrainerEntity?> getTrainerById(String id);

  /// Yeni eğitmen oluşturma
  Future<void> createTrainer(TrainerEntity trainer);

  /// Eğitmen bilgilerini güncelleme
  Future<void> updateTrainer(TrainerEntity trainer);

  /// Tüm eğitmenleri getirme
  Future<List<TrainerEntity>> getAllTrainers();

  /// Email'e göre eğitmen getirme
  Future<TrainerEntity?> getTrainerByEmail(String email);
}