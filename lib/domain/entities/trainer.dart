class Trainer {
  final String uid;
  final String name;
  final String email;
  final DateTime createdAt;
  final List<String>? studentIds;
  final String? photoUrl;
  final String? phoneNumber;
  final String? address;
  final DateTime? updatedAt;

  const Trainer({
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

  Trainer copyWith({
    String? uid,
    String? name,
    String? email,
    DateTime? createdAt,
    List<String>? studentIds,
    String? photoUrl,
    String? phoneNumber,
    String? address,
    DateTime? updatedAt,
  }) {
    return Trainer(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      studentIds: studentIds ?? this.studentIds,
      photoUrl: photoUrl ?? this.photoUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}