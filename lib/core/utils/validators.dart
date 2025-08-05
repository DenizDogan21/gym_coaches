/// Form doğrulama için yardımcı sınıf
class Validators {
  /// E-posta doğrulama
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'E-posta alanı boş bırakılamaz';
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Geçerli bir e-posta adresi girin';
    }

    return null;
  }

  /// Şifre doğrulama
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Şifre alanı boş bırakılamaz';
    }

    if (value.length < 6) {
      return 'Şifre en az 6 karakter olmalıdır';
    }

    return null;
  }

  /// İsim doğrulama
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'İsim alanı boş bırakılamaz';
    }

    if (value.length < 2) {
      return 'İsim en az 2 karakter olmalıdır';
    }

    return null;
  }

  /// Telefon numarası doğrulama
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // İsteğe bağlı
    }

    if (!RegExp(r'^\d{10,11}$').hasMatch(value.replaceAll(RegExp(r'[^\d]'), ''))) {
      return 'Geçerli bir telefon numarası girin';
    }

    return null;
  }

  /// Boş alan kontrolü
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName alanı boş bırakılamaz';
    }

    return null;
  }

  /// Rakam kontrolü
  static String? validateNumeric(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return null; // İsteğe bağlı
    }

    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return '$fieldName sadece rakam içermelidir';
    }

    return null;
  }

  /// İki şifrenin eşleşme kontrolü
  static String? validatePasswordMatch(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Şifre tekrar alanı boş bırakılamaz';
    }

    if (password != confirmPassword) {
      return 'Şifreler eşleşmiyor';
    }

    return null;
  }
}