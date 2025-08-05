import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/payment_entity.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required String id,
    required String trainerId,
    required String studentId,
    required double amount,
    String? description,
    required DateTime dueDate,
    DateTime? paymentDate,
    required PaymentStatus status,
    required PaymentMethod method,
    required DateTime createdAt,
    DateTime? updatedAt,
  }) : super(
    id: id,
    trainerId: trainerId,
    studentId: studentId,
    amount: amount,
    description: description,
    dueDate: dueDate,
    paymentDate: paymentDate,
    status: status,
    method: method,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );

  // Entity'den Model oluşturma
  factory PaymentModel.fromEntity(PaymentEntity entity) {
    return PaymentModel(
      id: entity.id,
      trainerId: entity.trainerId,
      studentId: entity.studentId,
      amount: entity.amount,
      description: entity.description,
      dueDate: entity.dueDate,
      paymentDate: entity.paymentDate,
      status: entity.status,
      method: entity.method,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  // Firebase Map'inden model oluşturma
  factory PaymentModel.fromFirestore(Map<String, dynamic> map, String id) {
    return PaymentModel(
      id: id,
      trainerId: map['trainerId'] ?? '',
      studentId: map['studentId'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      description: map['description'],
      dueDate: (map['dueDate'] != null)
          ? (map['dueDate'] as Timestamp).toDate()
          : DateTime.now(),
      paymentDate: (map['paymentDate'] != null)
          ? (map['paymentDate'] as Timestamp).toDate()
          : null,
      status: _getPaymentStatusFromString(map['status'] ?? 'pending'),
      method: _getPaymentMethodFromString(map['method'] ?? 'cash'),
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
      'studentId': studentId,
      'amount': amount,
      'description': description,
      'dueDate': Timestamp.fromDate(dueDate),
      'paymentDate': paymentDate != null ? Timestamp.fromDate(paymentDate!) : null,
      'status': _paymentStatusToString(status),
      'method': _paymentMethodToString(method),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
    };
  }

  // Model'in yeni bir kopyasını oluşturma
  PaymentModel copyWithModel({
    double? amount,
    String? description,
    DateTime? dueDate,
    DateTime? paymentDate,
    PaymentStatus? status,
    PaymentMethod? method,
    DateTime? updatedAt,
  }) {
    return PaymentModel(
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

  // PaymentStatus enum'u string'e çevirme
  static String _paymentStatusToString(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return 'pending';
      case PaymentStatus.completed:
        return 'completed';
      case PaymentStatus.overdue:
        return 'overdue';
      case PaymentStatus.canceled:
        return 'canceled';
      default:
        return 'pending';
    }
  }

  // String'i PaymentStatus enum'a çevirme
  static PaymentStatus _getPaymentStatusFromString(String status) {
    switch (status) {
      case 'pending':
        return PaymentStatus.pending;
      case 'completed':
        return PaymentStatus.completed;
      case 'overdue':
        return PaymentStatus.overdue;
      case 'canceled':
        return PaymentStatus.canceled;
      default:
        return PaymentStatus.pending;
    }
  }

  // PaymentMethod enum'u string'e çevirme
  static String _paymentMethodToString(PaymentMethod method) {
    switch (method) {
      case PaymentMethod.cash:
        return 'cash';
      case PaymentMethod.creditCard:
        return 'creditCard';
      case PaymentMethod.bankTransfer:
        return 'bankTransfer';
      case PaymentMethod.other:
        return 'other';
      default:
        return 'cash';
    }
  }

  // String'i PaymentMethod enum'a çevirme
  static PaymentMethod _getPaymentMethodFromString(String method) {
    switch (method) {
      case 'cash':
        return PaymentMethod.cash;
      case 'creditCard':
        return PaymentMethod.creditCard;
      case 'bankTransfer':
        return PaymentMethod.bankTransfer;
      case 'other':
        return PaymentMethod.other;
      default:
        return PaymentMethod.cash;
    }
  }
}