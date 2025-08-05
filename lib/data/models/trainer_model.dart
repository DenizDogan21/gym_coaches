import '../../domain/entities/trainer_entity.dart';
// Timestap için import edilmeli
import 'package:cloud_firestore/cloud_firestore.dart';

class TrainerModel extends TrainerEntity {
  const TrainerModel({
    required String id,
    required String name,
    required String email,
    String? photoUrl,
    List<String>? studentIds,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super(
    id: id,
    name: name,
    email: email,
    photoUrl: photoUrl,
    studentIds: studentIds,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  // Entity'den Model oluşturma
  factory TrainerModel.fromEntity(TrainerEntity entity) {
    return TrainerModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      photoUrl: entity.photoUrl,
      studentIds: entity.studentIds,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // Firebase Map'inden model oluşturma
  factory TrainerModel.fromFirestore(Map<String, dynamic> map, String id) {
    return TrainerModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      studentIds: map['studentIds'] != null
          ? List<String>.from(map['studentIds'])
          : null,
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
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'studentIds': studentIds,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  // Model'in yeni bir kopyasını oluşturma
  TrainerModel copyWithModel({
    String? name,
    String? email,
    String? photoUrl,
    List<String>? studentIds,
    DateTime? updatedAt,
  }) {
    return TrainerModel(
      id: this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      studentIds: studentIds ?? this.studentIds,
      createdAt: this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
