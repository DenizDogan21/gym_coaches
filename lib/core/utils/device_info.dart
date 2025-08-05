import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Device info provider
final deviceInfoProvider = Provider<DeviceInfo>((ref) {
  return DeviceInfo();
});

/// Cihaz bilgileri için yardımcı sınıf
class DeviceInfo {
  /// Platformu kontrol etme
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isWeb => kIsWeb;

  /// Platformu string olarak alma
  String get platformName {
    if (kIsWeb) return 'Web';
    if (Platform.isAndroid) return 'Android';
    if (Platform.isIOS) return 'iOS';
    if (Platform.isWindows) return 'Windows';
    if (Platform.isMacOS) return 'macOS';
    if (Platform.isLinux) return 'Linux';
    return 'Unknown';
  }

  /// Cihazın oryantasyonunu kontrol etme
  bool isLandscape(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return mediaQuery.orientation == Orientation.landscape;
  }

  /// Cihazın boyutunu kontrol etme
  DeviceScreenType getDeviceType(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;

    if (width < 600) return DeviceScreenType.phone;
    if (width < 900) return DeviceScreenType.tablet;
    return DeviceScreenType.desktop;
  }

  /// Cihazın ekran boyutlarını alma
  Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// Cihazın safe area değerlerini alma
  EdgeInsets getSafeArea(BuildContext context) {
    return MediaQuery.of(context).padding;
  }

  /// Cihazın piksel oranını alma
  double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// Cihazın aydınlık/karanlık mod durumunu alma
  bool isDarkMode(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  /// Klavye yüksekliğini alma
  double getKeyboardHeight(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom;
  }

  /// Klavye açık mı kontrolü
  bool isKeyboardVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom > 0;
  }
}

/// Cihaz ekran tipi enum
enum DeviceScreenType {
  phone,
  tablet,
  desktop,
}