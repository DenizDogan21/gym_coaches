import 'workout_entity.dart';

/// Egzersiz programı varlık sınıfı
class WorkoutProgramEntity {
  final String id;
  final String trainerId;
  final String? studentId; // Null ise genel bir program
  final String title;
  final String? description;
  final List<WorkoutEntity> workouts;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const WorkoutProgramEntity({
    required this.id,
    required this.trainerId,
    this.studentId,
    required this.title,
    this.description,
    required this.workouts,
    required this.startDate,
    this.endDate,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  /// Güncelleme için kopya oluşturma
  WorkoutProgramEntity copyWith({
    String? title,
    String? description,
    List<WorkoutEntity>? workouts,
    DateTime? endDate,
    bool? isActive,
    DateTime? updatedAt,
  }) {
    return WorkoutProgramEntity(
      id: this.id,
      trainerId: this.trainerId,
      studentId: this.studentId,
      title: title ?? this.title,
      description: description ?? this.description,
      workouts: workouts ?? this.workouts,
      startDate: this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      createdAt: this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}