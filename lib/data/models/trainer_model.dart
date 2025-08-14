import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/trainer.dart';

class TrainerModel {
  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;
  final List<String>? studentIds;
  final String? photoUrl;
  final String? phoneNumber;
  final String? address;
  final DateTime? updatedAt;

  const TrainerModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.createdAt,
    this.studentIds,
    this.photoUrl,
    this.phoneNumber,
    this.address,
    this.updatedAt,
  });

  // Convert to domain entity
  Trainer toEntity() {
    return Trainer(
      uid: uid,
      name: name,
      email: email,
      createdAt: createdAt,
      studentIds: studentIds,
      photoUrl: photoUrl,
      phoneNumber: phoneNumber,
      address: address,
      updatedAt: updatedAt,
    );
  }

  // Create model from domain entity
  factory TrainerModel.fromEntity(Trainer trainer) {
    return TrainerModel(
      uid: trainer.uid,
      name: trainer.name,
      email: trainer.email,
      createdAt: trainer.createdAt,
      studentIds: trainer.studentIds,
      photoUrl: trainer.photoUrl,
      phoneNumber: trainer.phoneNumber,
      address: trainer.address,
      updatedAt: trainer.updatedAt,
    );
  }

  // Convert to Firestore document - FIXED: studentIds no longer gated by photoUrl
  Map<String, dynamic> toFirestore() {
    final data = <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
    };

    // Only add non-null optional fields
    if (studentIds != null) {
      data['studentIds'] = studentIds;
    }
    if (photoUrl != null) {
      data['photoUrl'] = photoUrl;
    }
    if (phoneNumber != null) {
      data['phoneNumber'] = phoneNumber;
    }
    if (address != null) {
      data['address'] = address;
    }
    if (updatedAt != null) {
      data['updatedAt'] = Timestamp.fromDate(updatedAt!);
    }

    return data;
  }

  // Create model from Firestore document
  factory TrainerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TrainerModel(
      uid: data['uid'] as String,
      name: data['name'] as String,
      email: data['email'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      studentIds: data['studentIds'] != null 
          ? List<String>.from(data['studentIds']) 
          : null,
      photoUrl: data['photoUrl'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      address: data['address'] as String?,
      updatedAt: data['updatedAt'] != null 
          ? (data['updatedAt'] as Timestamp).toDate() 
          : null,
    );
  }
}