import 'package:intl/intl.dart';

/// Veri formatlama için yardımcı sınıf
class Formatters {
  /// Para birimi formatı
  static String formatCurrency(double amount, {String symbol = '₺', int decimalDigits = 2}) {
    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
      locale: 'tr_TR',
    );
    return formatter.format(amount);
  }

  /// Tarih formatı (gün/ay/yıl)
  static String formatDate(DateTime date) {
    final formatter = DateFormat('dd/MM/yyyy', 'tr_TR');
    return formatter.format(date);
  }

  /// Tarih ve saat formatı
  static String formatDateTime(DateTime date) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm', 'tr_TR');
    return formatter.format(date);
  }

  /// İnsan tarafından okunabilir tarih formatı (örn: "Bugün", "Dün", "3 gün önce")
  static String formatDateToReadable(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Az önce';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} dakika önce';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} saat önce';
    } else if (difference.inDays < 2) {
      return 'Dün';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} gün önce';
    } else {
      return formatDate(date);
    }
  }

  /// Telefon numarası formatı
  static String formatPhoneNumber(String phoneNumber) {
    // Sadece rakamları al
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.length < 10) return phoneNumber; // Geçersiz format

    if (digitsOnly.length == 10) {
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)} ${digitsOnly.substring(6)}';
    }

    if (digitsOnly.length == 11 && digitsOnly.startsWith('0')) {
      return '(${digitsOnly.substring(1, 4)}) ${digitsOnly.substring(4, 7)} ${digitsOnly.substring(7)}';
    }

    return phoneNumber;
  }

  /// Metni kısaltma (örn: "Bu uzun bir metindir..." -> "Bu uzun bir...")
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Dosya boyutu formatı (örn: "1.5 MB", "820 KB")
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
}