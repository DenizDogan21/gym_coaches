import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/student_entity.dart';

class StudentModel extends StudentEntity {
  const StudentModel({
    required String id,
    required String trainerId,
    required String name,
    String? photoUrl,
    String? phoneNumber,
    String? email,
    String? healthInfo,
    String? specialConditions,
    required DateTime birthdate,
    required DateTime startDate,
    DateTime? endDate,
    required bool isActive,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super(
    id: id,
    trainerId: trainerId,
    name: name,
    photoUrl: photoUrl,
    phoneNumber: phoneNumber,
    email: email,
    healthInfo: healthInfo,
    specialConditions: specialConditions,
    birthdate: birthdate,
    startDate: startDate,
    endDate: endDate,
    isActive: isActive,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  // Entity'den Model oluşturma
  factory StudentModel.fromEntity(StudentEntity entity) {
    return StudentModel(
      id: entity.id,
      trainerId: entity.trainerId,
      name: entity.name,
      photoUrl: entity.photoUrl,
      phoneNumber: entity.phoneNumber,
      email: entity.email,
      healthInfo: entity.healthInfo,
      specialConditions: entity.specialConditions,
      birthdate: entity.birthdate,
      startDate: entity.startDate,
      endDate: entity.endDate,
      isActive: entity.isActive,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // Firebase Map'inden model oluşturma
  factory StudentModel.fromFirestore(Map<String, dynamic> map, String id) {
    return StudentModel(
      id: id,
      trainerId: map['trainerId'] ?? '',
      name: map['name'] ?? '',
      photoUrl: map['photoUrl'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      healthInfo: map['healthInfo'],
      specialConditions: map['specialConditions'],
      birthdate: (map['birthdate'] != null)
          ? (map['birthdate'] as Timestamp).toDate()
          : DateTime.now(),
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
    return {
      'trainerId': trainerId,
      'name': name,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'email': email,
      'healthInfo': healthInfo,
      'specialConditions': specialConditions,
      'birthdate': Timestamp.fromDate(birthdate),
      'startDate': Timestamp.fromDate(startDate),
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
      'isActive': isActive,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  // Model'in yeni bir kopyasını oluşturma
  StudentModel copyWithModel({
    String? name,
    String? photoUrl,
    String? phoneNumber,
    String? email,
    String? healthInfo,
    String? specialConditions,
    DateTime? endDate,
    bool? isActive,
    DateTime? updatedAt,
  }) {
    return StudentModel(
      id: this.id,
      trainerId: this.trainerId,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      healthInfo: healthInfo ?? this.healthInfo,
      specialConditions: specialConditions ?? this.specialConditions,
      birthdate: this.birthdate,
      startDate: this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      createdAt: this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}