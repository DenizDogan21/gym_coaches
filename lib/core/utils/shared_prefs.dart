import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


/// Shared Preferences için yardımcı sınıf
class SharedPrefs {
  final SharedPreferences _prefs;

  SharedPrefs(this._prefs);

  /// SharedPreferences instance'ını oluşturma
  static Future<SharedPrefs> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return SharedPrefs(prefs);
  }

  /// String değer kaydetme
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  /// String değer okuma
  String? getString(String key) {
    return _prefs.getString(key);
  }

  /// Integer değer kaydetme
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  /// Integer değer okuma
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// Boolean değer kaydetme
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  /// Boolean değer okuma
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  /// Double değer kaydetme
  Future<bool> setDouble(String key, double value) async {
    return await _prefs.setDouble(key, value);
  }

  /// Double değer okuma
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  /// String listesi kaydetme
  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  /// String listesi okuma
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  /// Key'i silme
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  /// Tüm verileri silme
  Future<bool> clear() async {
    return await _prefs.clear();
  }

  /// Key var mı kontrolü
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  /// Tüm key'leri alma
  Set<String> getKeys() {
    return _prefs.getKeys();
  }
}