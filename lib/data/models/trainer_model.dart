import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/trainer_entity.dart';

class TrainerModel extends TrainerEntity {
  const TrainerModel({
    required String id,
    required String name,
    required String email,
    String? photoUrl,
    String? phoneNumber,  // Eklendi
    String? address,      // Eklendi
    List<String>? studentIds,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super(
    id: id,
    name: name,
    email: email,
    photoUrl: photoUrl,
    phoneNumber: phoneNumber,  // Eklendi
    address: address,          // Eklendi
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
      phoneNumber: entity.phoneNumber,  // Eklendi
      address: entity.address,          // Eklendi
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
      phoneNumber: map['phoneNumber'],  // Eklendi
      address: map['address'],          // Eklendi
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
      'phoneNumber': phoneNumber,  // Eklendi
      'address': address,          // Eklendi
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
    String? phoneNumber,  // Eklendi
    String? address,      // Eklendi
    List<String>? studentIds,
    DateTime? updatedAt,
  }) {
    return TrainerModel(
      id: this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,  // Eklendi
      address: address ?? this.address,              // Eklendi
      studentIds: studentIds ?? this.studentIds,
      createdAt: this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}