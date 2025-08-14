import 'package:flutter_test/flutter_test.dart';
import '../lib/data/models/trainer_model.dart';

void main() {
  group('TrainerModel', () {
    test('toFirestore should include studentIds when not null, regardless of photoUrl', () {
      // Test case: studentIds provided but no photoUrl
      final trainer = TrainerModel(
        uid: 'test-uid',
        name: 'Test Trainer',
        email: 'test@example.com',
        createdAt: DateTime(2023, 1, 1),
        studentIds: ['student1', 'student2'],
        photoUrl: null, // No photo URL
      );

      final firestoreData = trainer.toFirestore();

      // studentIds should be included even without photoUrl
      expect(firestoreData['studentIds'], equals(['student1', 'student2']));
      expect(firestoreData['uid'], equals('test-uid'));
      expect(firestoreData['name'], equals('Test Trainer'));
      expect(firestoreData['email'], equals('test@example.com'));
      expect(firestoreData.containsKey('photoUrl'), isFalse);
    });

    test('toFirestore should include all non-null optional fields', () {
      final trainer = TrainerModel(
        uid: 'test-uid',
        name: 'Test Trainer',
        email: 'test@example.com',
        createdAt: DateTime(2023, 1, 1),
        studentIds: ['student1'],
        photoUrl: 'http://example.com/photo.jpg',
        phoneNumber: '+1234567890',
        address: '123 Main St',
        updatedAt: DateTime(2023, 1, 2),
      );

      final firestoreData = trainer.toFirestore();

      expect(firestoreData['studentIds'], equals(['student1']));
      expect(firestoreData['photoUrl'], equals('http://example.com/photo.jpg'));
      expect(firestoreData['phoneNumber'], equals('+1234567890'));
      expect(firestoreData['address'], equals('123 Main St'));
      expect(firestoreData.containsKey('updatedAt'), isTrue);
    });

    test('toFirestore should exclude null optional fields', () {
      final trainer = TrainerModel(
        uid: 'test-uid',
        name: 'Test Trainer',
        email: 'test@example.com',
        createdAt: DateTime(2023, 1, 1),
        studentIds: null,
        photoUrl: null,
        phoneNumber: null,
        address: null,
        updatedAt: null,
      );

      final firestoreData = trainer.toFirestore();

      expect(firestoreData.containsKey('studentIds'), isFalse);
      expect(firestoreData.containsKey('photoUrl'), isFalse);
      expect(firestoreData.containsKey('phoneNumber'), isFalse);
      expect(firestoreData.containsKey('address'), isFalse);
      expect(firestoreData.containsKey('updatedAt'), isFalse);
    });
  });
}