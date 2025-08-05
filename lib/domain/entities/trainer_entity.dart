/// Eğitmen varlık sınıfı
class TrainerEntity {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final List<String>? studentIds;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const TrainerEntity({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.studentIds,
    required this.createdAt,
    this.updatedAt,
  });

  /// Güncelleme için kopya oluşturma
  TrainerEntity copyWith({
    String? name,
    String? email,
    String? photoUrl,
    List<String>? studentIds,
    DateTime? updatedAt,
  }) {
    return TrainerEntity(
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