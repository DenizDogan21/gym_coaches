import '../entities/workout_entity.dart';
import '../entities/workout_program_entity.dart';

/// Egzersiz programları için soyut repository arayüzü
abstract class WorkoutRepository {
  /// Eğitmenin egzersiz programlarını getirme
  Future<List<WorkoutProgramEntity>> getProgramsByTrainerId(String trainerId);

  /// Öğrencinin egzersiz programlarını getirme
  Future<List<WorkoutProgramEntity>> getProgramsByStudentId(String studentId);

  /// Program ID'sine göre egzersiz programını getirme
  Future<WorkoutProgramEntity?> getProgramById(String id);

  /// Yeni egzersiz programı ekleme
  Future<void> addProgram(WorkoutProgramEntity program);

  /// Egzersiz programını güncelleme
  Future<void> updateProgram(WorkoutProgramEntity program);

  /// Egzersiz programını silme
  Future<void> deleteProgram(String id);

  /// Programa egzersiz ekleme
  Future<void> addWorkoutToProgram(String programId, WorkoutEntity workout);
}