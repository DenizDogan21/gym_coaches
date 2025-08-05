/// String sınıfı için extension metotlar
extension StringExtension on String {
  /// İlk harfi büyük, diğerlerini küçük yapar
  String get capitalize {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + this.substring(1).toLowerCase();
  }

  /// Her kelimenin ilk harfini büyük yapar
  String get titleCase {
    if (this.isEmpty) return this;
    return this.split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Metni kısaltır ve sonuna '...' ekler
  String truncate(int maxLength) {
    if (this.length <= maxLength) return this;
    return '${this.substring(0, maxLength)}...';
  }

  /// E-posta geçerliliğini kontrol eder
  bool get isValidEmail {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  }

  /// Şifre güçlülüğünü kontrol eder (min 8 karakter, en az 1 büyük harf, 1 küçük harf, 1 rakam)
  bool get isStrongPassword {
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(this);
  }

  /// Sadece rakam içerip içermediğini kontrol eder
  bool get isNumeric {
    return RegExp(r'^[0-9]+$').hasMatch(this);
  }

  /// Boş veya null mu kontrolü
  bool get isNullOrEmpty => this.isEmpty;

  /// Sadece harflerden mi oluşuyor kontrolü
  bool get isAlpha {
    return RegExp(r'^[a-zA-Z]+$').hasMatch(this);
  }

  /// Hexadecimal renk kodunu Color nesnesine çevirme
  int? toColor() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return int.tryParse('0x$hexColor');
    }
    return null;
  }
}