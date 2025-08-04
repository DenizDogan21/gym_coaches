class AppConstants {
  // Uygulama genel sabitleri
  static const String appName = 'Gym Coaches';
  static const String version = '1.0.0';

  // UI Sabitleri
  static const double defaultPadding = 16.0;
  static const double smallPadding = 1.0;
  static const double mediumPadding = 16.0;
  static const double largePadding = 24.0;
  static const double defaultRadius = 8.0;
  static const double cardRadius = 12.0;

  // Yazı boyutları
  static const double headingLarge = 24.0;
  static const double headingMedium = 20.0;
  static const double bodyText = 18.0;
  static const double bodyTextMedium = 16.0;
  static const double bodyTextSmall = 15.0;

  // Collection İsimleri
  static const String trainersCollection = 'trainers';
  static const String studentsCollection = 'students';
  static const String workoutProgramsCollection = 'workout_programs';
  static const String paymentsCollection = 'payments';
  static const String calendarEventsCollection = 'calendar_events';

  // Hata Mesajları
  static const String genericError = 'Bir hata oluştu. Lütfen tekrar deneyin.';
  static const String networkError = 'İnternet bağlantınızı kontrol edin.';
  static const String authError =
      'Giriş yapılamadı. Bilgilerinizi kontrol edin.';
  static const String emptyEmailError = 'E-posta alanı boş bırakılamaz!';
  static const String emptyPasswordError = 'Şifre alanı boş bırakılamaz!';
  static const String invalidEmailError = 'Geçersiz e-posta adresi!';
  static const String shortPasswordError = 'Şifre en az 8 karakter olmalıdır!';

  // Animasyon süreleri (milisaniye)
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration animationNormal = Duration(milliseconds: 300);
  static const Duration animationFast = Duration(milliseconds: 150);
}