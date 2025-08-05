import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/errors/app_exceptions.dart';
import '../../core/providers/providers.dart';
import '../../domain/entities/workout_entity.dart';
import '../../domain/entities/workout_program_entity.dart';
import '../../domain/repositories/workout_repository.dart';
import '../models/workout_model.dart';
import '../models/workout_program_model.dart';

final workoutRepositoryImplProvider = Provider<WorkoutRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return WorkoutRepositoryImpl(firestore);
});

class WorkoutRepositoryImpl implements WorkoutRepository {
  final FirebaseFirestore _firestore;

  WorkoutRepositoryImpl(this._firestore);

  @override
  Future<List<WorkoutProgramEntity>> getProgramsByTrainerId(String trainerId) async {
    try {
      final querySnapshot = await _firestore
          .collection('workoutPrograms')
          .where('trainerId', isEqualTo: trainerId)
          .get();

      return querySnapshot.docs
          .map((doc) => WorkoutProgramModel.fromFirestore(doc.data(), doc.id))
          .toList();

    } catch (e) {
      throw DatabaseException(
        message: 'Egzersiz programları listesi alınamadı',
        code: 'get-programs-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<List<WorkoutProgramEntity>> getProgramsByStudentId(String studentId) async {
    try {
      final querySnapshot = await _firestore
          .collection('workoutPrograms')
          .where('studentId', isEqualTo: studentId)
          .get();

      return querySnapshot.docs
          .map((doc) => WorkoutProgramModel.fromFirestore(doc.data(), doc.id))
          .toList();

    } catch (e) {
      throw DatabaseException(
        message: 'Öğrenci egzersiz programları listesi alınamadı',
        code: 'get-student-programs-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<WorkoutProgramEntity?> getProgramById(String id) async {
    try {
      final doc = await _firestore.collection('workoutPrograms').doc(id).get();
      if (doc.exists && doc.data() != null) {
        return WorkoutProgramModel.fromFirestore(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      throw DatabaseException(
        message: 'Program bilgileri alınamadı',
        code: 'get-program-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> addProgram(WorkoutProgramEntity program) async {
    try {
      final programModel = program is WorkoutProgramModel
          ? program
          : WorkoutProgramModel.fromEntity(program);

      final docRef = _firestore.collection('workoutPrograms').doc();

      // ID ile model oluştur
      final modelWithId = WorkoutProgramModel(
        id: docRef.id,
        trainerId: programModel.trainerId,
        studentId: programModel.studentId,
        title: programModel.title,
        description: programModel.description,
        workouts: programModel.workouts,
        startDate: programModel.startDate,
        endDate: programModel.endDate,
        isActive: programModel.isActive,
        createdAt: programModel.createdAt,
        updatedAt: programModel.updatedAt,
      );

      await docRef.set(modelWithId.toFirestore());

    } catch (e) {
      throw DatabaseException(
        message: 'Program eklenemedi',
        code: 'add-program-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> updateProgram(WorkoutProgramEntity program) async {
    try {
      final programModel = program is WorkoutProgramModel
          ? program
          : WorkoutProgramModel.fromEntity(program);

      await _firestore
          .collection('workoutPrograms')
          .doc(program.id)
          .update(programModel.toFirestore());

    } catch (e) {
      throw DatabaseException(
        message: 'Program güncellenemedi',
        code: 'update-program-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> deleteProgram(String id) async {
    try {
      await _firestore.collection('workoutPrograms').doc(id).delete();
    } catch (e) {
      throw DatabaseException(
        message: 'Program silinemedi',
        code: 'delete-program-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> addWorkoutToProgram(String programId, WorkoutEntity workout) async {
    try {
      // Önce programı al
      final doc = await _firestore.collection('workoutPrograms').doc(programId).get();
      if (!doc.exists || doc.data() == null) {
        throw NotFoundException(
          message: 'Program bulunamadı',
          code: 'program-not-found',
        );
      }

      // Mevcut workout'ları al
      final program = WorkoutProgramModel.fromFirestore(doc.data()!, doc.id);

      // Workout model'e dönüştür
      final workoutModel = workout is WorkoutModel
          ? workout
          : WorkoutModel.fromEntity(workout);

      // Yeni workout ID'si atama (timestamp kullanarak)
      final newWorkout = WorkoutModel(
        id: 'workout_${DateTime.now().millisecondsSinceEpoch}',
        name: workoutModel.name,
        description: workoutModel.description,
        exercises: workoutModel.exercises,
        dayOfWeek: workoutModel.dayOfWeek,
        isCompleted: workoutModel.isCompleted,
      );

      // Yeni workout'u listeye ekle
      final updatedWorkouts = [...program.workouts, newWorkout];

      // Programı güncelle
      await _firestore.collection('workoutPrograms').doc(programId).update({
        'workouts': updatedWorkouts.map((w) {
          if (w is WorkoutModel) {
            return w.toFirestore();
          } else {
            return WorkoutModel.fromEntity(w).toFirestore();
          }
        }).toList(),
        'updatedAt': Timestamp.now(),
      });

    } catch (e) {
      if (e is NotFoundException) {
        rethrow;
      }

      throw DatabaseException(
        message: 'Egzersiz eklenemedi',
        code: 'add-workout-error',
        stackTrace: e,
      );
    }
  }
}