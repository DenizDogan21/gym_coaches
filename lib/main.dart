import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/shared_prefs.dart';
import 'core/providers/providers.dart';
import 'firebase_options.dart';
import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase'i başlat
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Crashlytics konfigürasyonu
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  // SharedPreferences instance oluştur
  final sharedPrefs = await SharedPrefs.getInstance();

  // Riverpod ile uygulamayı başlat
  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(sharedPrefs),
      ],
      child: const GymCoachesApp(),
    ),
  );
}