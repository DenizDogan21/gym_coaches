/// Ödeme durumu enum
enum PaymentStatus {
  pending,  // Beklemede
  completed, // Tamamlandı
  overdue,   // Gecikmiş
  canceled   // İptal edildi
}

/// Ödeme yöntemi enum
enum PaymentMethod {
  cash,     // Nakit
  creditCard, // Kredi kartı
  bankTransfer, // Banka havalesi
  other     // Diğer
}

/// Ödeme varlık sınıfı
class PaymentEntity {
  final String id;
  final String trainerId;
  final String studentId;
  final double amount;
  final String? description;
  final DateTime dueDate;
  final DateTime? paymentDate;
  final PaymentStatus status;
  final PaymentMethod method;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const PaymentEntity({
    required this.id,
    required this.trainerId,
    required this.studentId,
    required this.amount,
    this.description,
    required this.dueDate,
    this.paymentDate,
    required this.status,
    required this.method,
    required this.createdAt,
    this.updatedAt,
  });

  /// Güncelleme için kopya oluşturma
  PaymentEntity copyWith({
    double? amount,
    String? description,
    DateTime? dueDate,
    DateTime? paymentDate,
    PaymentStatus? status,
    PaymentMethod? method,
    DateTime? updatedAt,
  }) {
    return PaymentEntity(
      id: this.id,
      trainerId: this.trainerId,
      studentId: this.studentId,
      amount: amount ?? this.amount,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      paymentDate: paymentDate ?? this.paymentDate,
      status: status ?? this.status,
      method: method ?? this.method,
      createdAt: this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }
}