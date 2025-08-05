import 'exercise_entity.dart';

/// Egzersiz planı varlık sınıfı
class WorkoutEntity {
  final String id;
  final String name;
  final String? description;
  final List<ExerciseEntity> exercises;
  final int dayOfWeek; // 1 = Pazartesi, 7 = Pazar
  final bool isCompleted;

  const WorkoutEntity({
    required this.id,
    required this.name,
    this.description,
    required this.exercises,
    required this.dayOfWeek,
    this.isCompleted = false,
  });

  /// Güncelleme için kopya oluşturma
  WorkoutEntity copyWith({
    String? name,
    String? description,
    List<ExerciseEntity>? exercises,
    int? dayOfWeek,
    bool? isCompleted,
  }) {
    return WorkoutEntity(
      id: this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      exercises: exercises ?? this.exercises,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}