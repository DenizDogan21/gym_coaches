import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/errors/app_exceptions.dart';
import '../../core/providers/providers.dart';
import '../../domain/entities/payment_entity.dart';
import '../../domain/repositories/payment_repository.dart';
import '../models/payment_model.dart';

final paymentRepositoryImplProvider = Provider<PaymentRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  return PaymentRepositoryImpl(firestore);
});

class PaymentRepositoryImpl implements PaymentRepository {
  final FirebaseFirestore _firestore;

  PaymentRepositoryImpl(this._firestore);

  @override
  Future<List<PaymentEntity>> getPaymentsByTrainerId(String trainerId) async {
    try {
      final querySnapshot = await _firestore
          .collection('payments')
          .where('trainerId', isEqualTo: trainerId)
          .orderBy('dueDate', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => PaymentModel.fromFirestore(doc.data(), doc.id))
          .toList();

    } catch (e) {
      throw DatabaseException(
        message: 'Ödeme listesi alınamadı',
        code: 'get-payments-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<List<PaymentEntity>> getPaymentsByStudentId(String studentId) async {
    try {
      final querySnapshot = await _firestore
          .collection('payments')
          .where('studentId', isEqualTo: studentId)
          .orderBy('dueDate', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => PaymentModel.fromFirestore(doc.data(), doc.id))
          .toList();

    } catch (e) {
      throw DatabaseException(
        message: 'Öğrenci ödemeleri listesi alınamadı',
        code: 'get-student-payments-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> addPayment(PaymentEntity payment) async {
    try {
      final paymentModel = payment is PaymentModel
          ? payment
          : PaymentModel.fromEntity(payment);

      final docRef = _firestore.collection('payments').doc();

      // ID ile model oluştur
      final modelWithId = PaymentModel(
        id: docRef.id,
        trainerId: paymentModel.trainerId,
        studentId: paymentModel.studentId,
        amount: paymentModel.amount,
        description: paymentModel.description,
        dueDate: paymentModel.dueDate,
        paymentDate: paymentModel.paymentDate,
        status: paymentModel.status,
        method: paymentModel.method,
        createdAt: paymentModel.createdAt,
        updatedAt: paymentModel.updatedAt,
      );

      await docRef.set(modelWithId.toFirestore());

    } catch (e) {
      throw DatabaseException(
        message: 'Ödeme eklenemedi',
        code: 'add-payment-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> updatePaymentStatus(String id, PaymentStatus status) async {
    try {
      await _firestore.collection('payments').doc(id).update({
        'status': _paymentStatusToString(status),
        'updatedAt': Timestamp.now(),
      });

    } catch (e) {
      throw DatabaseException(
        message: 'Ödeme durumu güncellenemedi',
        code: 'update-payment-status-error',
        stackTrace: e,
      );
    }
  }

  @override
  Future<void> deletePayment(String id) async {
    try {
      await _firestore.collection('payments').doc(id).delete();
    } catch (e) {
      throw DatabaseException(
        message: 'Ödeme silinemedi',
        code: 'delete-payment-error',
        stackTrace: e,
      );
    }
  }

  // PaymentStatus enum'u string'e çevirme
  String _paymentStatusToString(PaymentStatus status) {
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
}