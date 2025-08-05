import '../../domain/entities/workout_entity.dart';
import '../../domain/entities/exercise_entity.dart';
import 'exercise_model.dart';

class WorkoutModel extends WorkoutEntity {
  const WorkoutModel({
    required String id,
    required String name,
    String? description,
    required List<ExerciseEntity> exercises,
    required int dayOfWeek,
    bool isCompleted = false,
  }) : super(
    id: id,
    name: name,
    description: description,
    exercises: exercises,
    dayOfWeek: dayOfWeek,
    isCompleted: isCompleted,
  );

  // Entity'den Model oluşturma
  factory WorkoutModel.fromEntity(WorkoutEntity entity) {
    return WorkoutModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      exercises: entity.exercises,
      dayOfWeek: entity.dayOfWeek,
      isCompleted: entity.isCompleted,
    );
  }

  // Firebase Map'inden model oluşturma
  factory WorkoutModel.fromFirestore(Map<String, dynamic> map, String id) {
    List<ExerciseModel> exercises = [];
    if (map['exercises'] != null) {
      final exercisesList = map['exercises'] as List;
      exercises = exercisesList
          .asMap()
          .entries
          .map((entry) => ExerciseModel.fromFirestore(
        entry.value as Map<String, dynamic>,
        entry.key.toString(),
      ))
          .toList();
    }

    return WorkoutModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'],
      exercises: exercises,
      dayOfWeek: map['dayOfWeek'] ?? 1,
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  // Model'i Firebase Map'e çevirme
  Map<String, dynamic> toFirestore() {
    final exercisesData = exercises.map((exercise) {
      if (exercise is ExerciseModel) {
        return exercise.toFirestore();
      } else {
        return ExerciseModel.fromEntity(exercise).toFirestore();
      }
    }).toList();

    return {
      'name': name,
      'description': description,
      'exercises': exercisesData,
      'dayOfWeek': dayOfWeek,
      'isCompleted': isCompleted,
    };
  }

  // Model'in yeni bir kopyasını oluşturma
  WorkoutModel copyWithModel({
    String? name,
    String? description,
    List<ExerciseEntity>? exercises,
    int? dayOfWeek,
    bool? isCompleted,
  }) {
    return WorkoutModel(
      id: this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      exercises: exercises ?? this.exercises,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}