/// Eğitmen varlık sınıfı
class TrainerEntity {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? phoneNumber; // Eklendi
  final String? address; // Eklendi
  final List<String>? studentIds;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const TrainerEntity({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.phoneNumber, // Eklendi
    this.address, // Eklendi
    this.studentIds,
    required this.createdAt,
    this.updatedAt,
  });

  /// Güncelleme için kopya oluşturma
  TrainerEntity copyWith({
    String? name,
    String? email,
    String? photoUrl,
    String? phoneNumber, // Eklendi
    String? address, // Eklendi
    List<String>? studentIds,
    DateTime? updatedAt,
  }) {
    return TrainerEntity(
      id: this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber, // Eklendi
      address: address ?? this.address, // Eklendi
      studentIds: studentIds ?? this.studentIds,
      createdAt: this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}
