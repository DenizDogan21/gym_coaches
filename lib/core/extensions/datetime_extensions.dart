/// DateTime sınıfı için extension metotlar
extension DateTimeExtension on DateTime {
  /// Sadece tarih bölümünü içeren DateTime döndürür (saat kısmı sıfırlanır)
  DateTime get dateOnly {
    return DateTime(this.year, this.month, this.day);
  }

  /// İki tarih arasındaki farkı gün olarak döndürür
  int daysBetween(DateTime to) {
    final from = this.dateOnly;
    final toDate = to.dateOnly;
    return (toDate.difference(from).inHours / 24).round();
  }

  /// Tarih formatını "dd/MM/yyyy" olarak döndürür
  String get formattedDate {
    return '${this.day.toString().padLeft(2, '0')}/${this.month.toString().padLeft(2, '0')}/${this.year}';
  }

  /// Tarih ve saat formatını "dd/MM/yyyy HH:mm" olarak döndürür
  String get formattedDateTime {
    return '${formattedDate} ${this.hour.toString().padLeft(2, '0')}:${this.minute.toString().padLeft(2, '0')}';
  }

  /// Tarih aynı gün mü kontrolü
  bool isSameDay(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }

  /// Tarih bugün mü kontrolü
  bool get isToday {
    final now = DateTime.now();
    return this.isSameDay(now);
  }

  /// Tarih dün mü kontrolü
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(Duration(days: 1));
    return this.isSameDay(yesterday);
  }

  /// Tarih yarın mı kontrolü
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return this.isSameDay(tomorrow);
  }

  /// Bu hafta içinde mi kontrolü
  bool get isThisWeek {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(Duration(days: 6));
    return this.isAfter(weekStart) && this.isBefore(weekEnd);
  }

  /// Geçmiş bir tarih mi kontrolü
  bool get isPast {
    final now = DateTime.now();
    return this.isBefore(now);
  }

  /// Gelecek bir tarih mi kontrolü
  bool get isFuture {
    final now = DateTime.now();
    return this.isAfter(now);
  }
}