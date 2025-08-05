import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
  wtf,
}

final loggerProvider = Provider<AppLogger>((ref) {
  return AppLogger();
});

class AppLogger {
  LogLevel _minimumLevel = kReleaseMode ? LogLevel.info : LogLevel.verbose;

  void setMinimumLevel(LogLevel level) {
    _minimumLevel = level;
  }

  void v(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.verbose, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  void d(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.debug, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  void i(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.info, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  void w(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.warning, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  void e(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.error, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  void wtf(String message, {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(LogLevel.wtf, message, tag: tag, error: error, stackTrace: stackTrace);
  }

  void _log(
      LogLevel level,
      String message, {
        String? tag,
        dynamic error,
        StackTrace? stackTrace,
      }) {
    if (level.index < _minimumLevel.index) {
      return;
    }

    final now = DateTime.now();
    final prefix = '${_formatTime(now)} ${_levelPrefix(level)}';
    final tagString = tag != null ? '[$tag] ' : '';

    String logMessage = '$prefix $tagString$message';

    if (error != null) {
      logMessage += '\nERROR: $error';
    }

    if (kDebugMode) {
      print(logMessage);
      if (stackTrace != null) {
        print('STACK TRACE:\n$stackTrace');
      }
    }

    // Firebase Crashlytics'e hataları kaydet (Error ve WTF seviyelerinde)
    if (level == LogLevel.error || level == LogLevel.wtf) {
      try {
        FirebaseCrashlytics.instance.log(logMessage);

        if (error != null) {
          FirebaseCrashlytics.instance.recordError(
            error,
            stackTrace,
            reason: message,
            printDetails: !kReleaseMode,
          );
        }
      } catch (e) {
        // Firebase henüz initialize edilmemiş olabilir
        if (kDebugMode) {
          print('Crashlytics error: $e');
        }
      }
    }
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }

  String _levelPrefix(LogLevel level) {
    switch (level) {
      case LogLevel.verbose:
        return '[V]';
      case LogLevel.debug:
        return '[D]';
      case LogLevel.info:
        return '[I]';
      case LogLevel.warning:
        return '[W]';
      case LogLevel.error:
        return '[E]';
      case LogLevel.wtf:
        return '[WTF]';
    }
  }
}