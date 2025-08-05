import '../entities/student_entity.dart';

/// Öğrenci işlemleri için soyut repository arayüzü
abstract class StudentRepository {
  /// Eğitmenin öğrencilerini getirme
  Future<List<StudentEntity>> getStudentsByTrainerId(String trainerId);

  /// ID'ye göre öğrenci getirme
  Future<StudentEntity?> getStudentById(String id);

  /// Yeni öğrenci ekleme
  Future<void> addStudent(StudentEntity student);

  /// Öğrenci bilgilerini güncelleme
  Future<void> updateStudent(StudentEntity student);

  /// Öğrenciyi silme
  Future<void> deleteStudent(String id);
}