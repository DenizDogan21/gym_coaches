/// Öğrenci varlık sınıfı
class StudentEntity {
  final String id;
  final String trainerId;
  final String name;
  final String? photoUrl;
  final String? phoneNumber;
  final String? email;
  final String? healthInfo;
  final String? specialConditions;
  final DateTime birthdate;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const StudentEntity({
    required this.id,
    required this.trainerId,
    required this.name,
    this.photoUrl,
    this.phoneNumber,
    this.email,
    this.healthInfo,
    this.specialConditions,
    required this.birthdate,
    required this.startDate,
    this.endDate,
    required this.isActive,
    required this.createdAt,
    this.updatedAt,
  });

  /// Güncelleme için kopya oluşturma
  StudentEntity copyWith({
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
    return StudentEntity(
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