/// Egzersiz varlık sınıfı
class ExerciseEntity {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final int sets;
  final int reps;
  final double? weight;
  final Duration? restTime;
  final bool isCompleted;

  const ExerciseEntity({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.sets,
    required this.reps,
    this.weight,
    this.restTime,
    this.isCompleted = false,
  });

  /// Güncelleme için kopya oluşturma
  ExerciseEntity copyWith({
    String? name,
    String? description,
    String? imageUrl,
    int? sets,
    int? reps,
    double? weight,
    Duration? restTime,
    bool? isCompleted,
  }) {
    return ExerciseEntity(
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