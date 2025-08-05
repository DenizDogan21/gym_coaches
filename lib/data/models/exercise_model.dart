import '../../domain/entities/exercise_entity.dart';

class ExerciseModel extends ExerciseEntity {
  const ExerciseModel({
    required String id,
    required String name,
    String? description,
    String? imageUrl,
    required int sets,
    required int reps,
    double? weight,
    Duration? restTime,
    bool isCompleted = false,
  }) : super(
    id: id,
    name: name,
    description: description,
    imageUrl: imageUrl,
    sets: sets,
    reps: reps,
    weight: weight,
    restTime: restTime,
    isCompleted: isCompleted,
  );

  // Entity'den Model oluşturma
  factory ExerciseModel.fromEntity(ExerciseEntity entity) {
    return ExerciseModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      imageUrl: entity.imageUrl,
      sets: entity.sets,
      reps: entity.reps,
      weight: entity.weight,
      restTime: entity.restTime,
      isCompleted: entity.isCompleted,
    );
  }

  // Firebase Map'inden model oluşturma
  factory ExerciseModel.fromFirestore(Map<String, dynamic> map, String id) {
    return ExerciseModel(
      id: id,
      name: map['name'] ?? '',
      description: map['description'],
      imageUrl: map['imageUrl'],
      sets: map['sets'] ?? 0,
      reps: map['reps'] ?? 0,
      weight: map['weight']?.toDouble(),
      restTime: map['restTimeSeconds'] != null
          ? Duration(seconds: map['restTimeSeconds'])
          : null,
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  // Model'i Firebase Map'e çevirme
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'sets': sets,
      'reps': reps,
      'weight': weight,
      'restTimeSeconds': restTime?.inSeconds,
      'isCompleted': isCompleted,
    };
  }

  // Model'in yeni bir kopyasını oluşturma
  ExerciseModel copyWithModel({
    String? name,
    String? description,
    String? imageUrl,
    int? sets,
    int? reps,
    double? weight,
    Duration? restTime,
    bool? isCompleted,
  }) {
    return ExerciseModel(
      id: this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      restTime: restTime ?? this.restTime,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}