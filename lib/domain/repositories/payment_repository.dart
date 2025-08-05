import '../entities/payment_entity.dart';

/// Ödeme işlemleri için soyut repository arayüzü
abstract class PaymentRepository {
  /// Eğitmenin tüm ödemelerini getirme
  Future<List<PaymentEntity>> getPaymentsByTrainerId(String trainerId);

  /// Öğrencinin ödemelerini getirme
  Future<List<PaymentEntity>> getPaymentsByStudentId(String studentId);

  /// Yeni ödeme ekleme
  Future<void> addPayment(PaymentEntity payment);

  /// Ödeme durumunu güncelleme
  Future<void> updatePaymentStatus(String id, PaymentStatus status);

  /// Ödemeyi silme
  Future<void> deletePayment(String id);
}