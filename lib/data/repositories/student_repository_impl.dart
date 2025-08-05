import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/errors/app_exceptions.dart';
import '../../core/providers/providers.dart';
import '../../domain/entities/student_entity.dart';
import '../../domain/repositories/student_repository.dart';
import '../models/student_model.dart';

final studentRepositoryImplProvider = Provider<StudentRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return StudentRepositoryImpl(firestore);
});

class StudentRepositoryImpl implements StudentRepository {
  final FirebaseFirestore _firestore;

  StudentRepositoryImpl(this._firestore);

  @override
  Future<List<StudentEntity>> getStudentsByTrainerId(String trainerId) async {
    try {
      final querySnapshot = await _firestore
          .collection('students')
          .where('trainerId', isEqualTo: trainerId)
          .get();

      return querySnapshot.docs
          .map((doc) => StudentModel.fromFirestore(doc.data(), doc.id))
          .toList();

    } catch (e) {
      throw DatabaseException(
        message: 'Öğrenci listesi alınamadı',
        code: 'get-students-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<StudentEntity?> getStudentById(String id) async {
    try {
      final doc = await _firestore.collection('students').doc(id).get();
      if (doc.exists && doc.data() != null) {
        return StudentModel.fromFirestore(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      throw DatabaseException(
        message: 'Öğrenci bilgileri alınamadı',
        code: 'get-student-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> addStudent(StudentEntity student) async {
    try {
      final studentModel = student is StudentModel
          ? student
          : StudentModel.fromEntity(student);

      // İlk olarak öğrenciyi koleksiyona ekle
      final docRef = _firestore.collection('students').doc();

      // ID'yi model'e ekle
      final modelWithId = StudentModel(
        id: docRef.id,
        trainerId: studentModel.trainerId,
        name: studentModel.name,
        photoUrl: studentModel.photoUrl,
        phoneNumber: studentModel.phoneNumber,
        email: studentModel.email,
        healthInfo: studentModel.healthInfo,
        specialConditions: studentModel.specialConditions,
        birthdate: studentModel.birthdate,
        startDate: studentModel.startDate,
        endDate: studentModel.endDate,
        isActive: studentModel.isActive,
        createdAt: studentModel.createdAt,
        updatedAt: studentModel.updatedAt,
      );

      await docRef.set(modelWithId.toFirestore());

      // Eğitmen belgesini güncelle (öğrenci ID'sini ekle)
      await _firestore.collection('trainers').doc(studentModel.trainerId).update({
        'studentIds': FieldValue.arrayUnion([docRef.id]),
      });

    } catch (e) {
      throw DatabaseException(
        message: 'Öğrenci eklenemedi',
        code: 'add-student-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> updateStudent(StudentEntity student) async {
    try {
      final studentModel = student is StudentModel
          ? student
          : StudentModel.fromEntity(student);

      await _firestore
          .collection('students')
          .doc(student.id)
          .update(studentModel.toFirestore());

    } catch (e) {
      throw DatabaseException(
        message: 'Öğrenci güncellenemedi',
        code: 'update-student-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> deleteStudent(String id) async {
    try {
      // Önce öğrenciyi al (trainer ID'si için)
      final studentDoc = await _firestore.collection('students').doc(id).get();

      if (!studentDoc.exists || studentDoc.data() == null) {
        throw NotFoundException(
          message: 'Silinecek öğrenci bulunamadı',
          code: 'student-not-found',
        );
      }

      final studentData = studentDoc.data()!;
      final trainerId = studentData['trainerId'];

      // Öğrenciyi sil
      await _firestore.collection('students').doc(id).delete();

      // Eğitmen belgesinden öğrenci ID'sini kaldır
      if (trainerId != null) {
        await _firestore.collection('trainers').doc(trainerId).update({
          'studentIds': FieldValue.arrayRemove([id]),
        });
      }

    } catch (e) {
      if (e is NotFoundException) {
        rethrow;
      }

      throw DatabaseException(
        message: 'Öğrenci silinemedi',
        code: 'delete-student-error',
        stackTrace: e,
      );
    }
  }
}