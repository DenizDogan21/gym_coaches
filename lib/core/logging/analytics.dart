import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'logger.dart';

final analyticsProvider = Provider<Analytics>((ref) {
  final logger = ref.watch(loggerProvider);
  return Analytics(logger, FirebaseAnalytics.instance);
});

class Analytics {
  final AppLogger _logger;
  final FirebaseAnalytics _analytics;

  Analytics(this._logger, this._analytics);

  void logScreenView(String screenName, {Map<String, dynamic>? parameters}) {
    _logger.i('Screen View: $screenName', tag: 'Analytics');

    // Firebase Analytics ekran görüntüleme
    _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenName,
      parameters: parameters,
    );
  }

  void logLogin({String? method}) {
    _logger.i('User Login', tag: 'Analytics');

    // Firebase Analytics login
    _analytics.logLogin(loginMethod: method ?? 'email');
  }

  void logSignUp({String? method}) {
    _logger.i('User Sign Up', tag: 'Analytics');

    // Firebase Analytics sign up
    _analytics.logSignUp(signUpMethod: method ?? 'email');
  }

  void logEvent(String name, {Map<String, dynamic>? parameters}) {
    _logger.i('Event: $name, Parameters: $parameters', tag: 'Analytics');

    // Firebase Analytics custom event
    _analytics.logEvent(
      name: name,
      parameters: parameters,
    );
  }

  void logSearch(String searchTerm) {
    _logger.i('Search: $searchTerm', tag: 'Analytics');

    // Firebase Analytics search
    _analytics.logSearch(searchTerm: searchTerm);
  }

  void logShare(String contentType, String itemId, {String? method}) {
    _logger.i('Share: $contentType - $itemId', tag: 'Analytics');

    // Firebase Analytics share
    _analytics.logShare(
      contentType: contentType,
      itemId: itemId,
      method: method ?? 'app',
    );
  }

  // Özelleştirilmiş olaylar

  void logWorkoutCreated(String workoutId, String title) {
    logEvent('workout_created', parameters: {
      'workout_id': workoutId,
      'title': title,
    });
  }

  void logStudentAdded(String studentId, String trainerEmail) {
    logEvent('student_added', parameters: {
      'student_id': studentId,
      'trainer_email': trainerEmail,
    });
  }

  void logPaymentReceived(String paymentId, double amount) {
    logEvent('payment_received', parameters: {
      'payment_id': paymentId,
      'amount': amount,
    });
  }

  // Kullanıcı özellikleri

  Future<void> setUserProperties({
    String? userId,
    String? userRole,
    int? studentCount,
  }) async {
    try {
      if (userId != null) {
        await _analytics.setUserId(id: userId);
      }

      if (userRole != null) {
        await _analytics.setUserProperty(name: 'user_role', value: userRole);
      }

      if (studentCount != null) {
        await _analytics.setUserProperty(name: 'student_count', value: studentCount.toString());
      }
    } catch (e) {
      _logger.e('Error setting user properties', error: e);
    }
  }
}