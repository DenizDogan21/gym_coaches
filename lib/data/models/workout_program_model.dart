import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/workout_program_entity.dart';
import '../../domain/entities/workout_entity.dart';
import 'workout_model.dart';

class WorkoutProgramModel extends WorkoutProgramEntity {
  const WorkoutProgramModel({
    required String id,
    required String trainerId,
    String? studentId,
    required String title,
    String? description,
    required List<WorkoutEntity> workouts,
    required DateTime startDate,
    DateTime? endDate,
    required bool isActive,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super(
    id: id,
    trainerId: trainerId,
    studentId: studentId,
    title: title,
    description: description,
    workouts: workouts,
    startDate: startDate,
    endDate: endDate,
    isActive: isActive,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  // Entity'den Model oluşturma
  factory WorkoutProgramModel.fromEntity(WorkoutProgramEntity entity) {
    return WorkoutProgramModel(
      id: entity.id,
      trainerId: entity.trainerId,
      studentId: entity.studentId,
      title: entity.title,
      description: entity.description,
      workouts: entity.workouts,
      startDate: entity.startDate,
      endDate: entity.endDate,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // Firebase Map'inden model oluşturma
  factory WorkoutProgramModel.fromFirestore(Map<String, dynamic> map, String id) {
    List<WorkoutModel> workouts = [];
    if (map['workouts'] != null) {
      final workoutsList = map['workouts'] as List;
      workouts = workoutsList
          .asMap()
          .entries
          .map((entry) => WorkoutModel.fromFirestore(
        entry.value as Map<String, dynamic>,
        entry.key.toString(),
      ))
          .toList();
    }

    return WorkoutProgramModel(
      id: id,
      trainerId: map['trainerId'] ?? '',
      studentId: map['studentId'],
      title: map['title'] ?? '',
      description: map['description'],
      workouts: workouts,
      startDate: (map['startDate'] != null)
          ? (map['startDate'] as Timestamp).toDate()
          : DateTime.now(),
      endDate: (map['endDate'] != null)
          ? (map['endDate'] as Timestamp).toDate()
          : null,
      isActive: map['isActive'] ?? true,
      createdAt: (map['createdAt'] != null)
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      updatedAt: (map['updatedAt'] != null)
          ? (map['updatedAt'] as Timestamp).toDate()
          : null,
    );
  }

  // Model'i Firebase Map'e çevirme
  Map<String, dynamic> toFirestore() {
    final workoutsData = workouts.map((workout) {
      if (workout is WorkoutModel) {
        return workout.toFirestore();
      } else {
        return WorkoutModel.fromEntity(workout).toFirestore();
      }
    }).toList();

    return {
      'trainerId': trainerId,
      'studentId': studentId,
      'title': title,
      'description': description,
      'workouts': workoutsData,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  // Model'in yeni bir kopyasını oluşturma
  WorkoutProgramModel copyWithModel({
    String? title,
    String? description,
    List<WorkoutEntity>? workouts,
    DateTime? endDate,
    bool? isActive,
    DateTime? updatedAt,
  }) {
    return WorkoutProgramModel(
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