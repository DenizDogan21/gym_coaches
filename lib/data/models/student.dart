class Student {
  final String id;
  final String name;
  final String healthInfo;
  final String specialCondition;

  Student({
    required this.id,
    required this.name,
    this.healthInfo = '',
    this.specialCondition = '',
  });

// FromMap ve toMap metotları
}