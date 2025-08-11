// lib/app/theme.dart
import 'package:flutter/material.dart';
import 'package:gym_coaches/core/constants/app_constants.dart';

class AppTheme {
  // Renk tanımları (Light tema için)
  static const Color primaryLight = Color.fromARGB(255, 35, 4, 116);
  static const Color secondaryLight = Color(0xFFF57C00);
  static const Color successLight = Color(0xFF43A047);
  static const Color errorLight = Color(0xFFE53935);
  static const Color warningLight = Color(0xFFFDD835);
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color surfaceLight = Colors.white;

  // Renk tanımları (Dark tema için)
  static const Color primaryDark = Color(0xFF82B1FF);
  static const Color secondaryDark = Color(0xFFFFAB40);
  static const Color successDark = Color(0xFF81C784);
  static const Color errorDark = Color(0xFFEF9A9A);
  static const Color warningDark = Color(0xFFFFF176);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Gradient tanımları
  static const Gradient lightBackgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromARGB(255, 187, 198, 230),
      Color.fromARGB(255, 120, 140, 200),
    ],
    stops: [0.0, 1.0],
  );

  static const Gradient darkBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF121212), Color(0xFF1E1E1E), Color(0xFF2D2D2D)],
    stops: [0.0, 0.5, 1.0],
  );
  // Light Tema
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: Colors.white,
      secondary: secondaryLight,
      onSecondary: Colors.white,
      error: errorLight,
      onError: Colors.white,
      tertiary: Colors.deepOrange,
      background: backgroundLight,
      onBackground: Colors.black87,
      surface: surfaceLight,
      onSurface: Colors.black87,
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 204, 211, 230),
    cardTheme: CardThemeData(
      color: surfaceLight,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color.fromARGB(255, 148, 163, 216),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.smallPadding,
          horizontal: AppConstants.defaultPadding,
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: AppConstants.headingLarge,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
      headlineMedium: TextStyle(
        fontSize: AppConstants.headingMedium,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      bodyLarge: TextStyle(
        fontSize: AppConstants.bodyText,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontSize: AppConstants.bodyText - 2,
        color: Colors.black54,
      ),
    ),
  );

  // Dark Tema
  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryDark,
      onPrimary: Colors.black,
      secondary: secondaryDark,
      onSecondary: Colors.black,
      error: errorDark,
      onError: Colors.black,
      background: backgroundDark,
      onBackground: Colors.white70,
      surface: surfaceDark,
      onSurface: Colors.white70,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardTheme: CardThemeData(
      color: surfaceDark,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      margin: const EdgeInsets.all(AppConstants.defaultPadding),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey.shade800,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppConstants.smallPadding,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.defaultRadius),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.smallPadding,
          horizontal: AppConstants.defaultPadding,
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: AppConstants.headingLarge,
        fontWeight: FontWeight.bold,
        color: Colors.white70,
      ),
      headlineMedium: TextStyle(
        fontSize: AppConstants.headingMedium,
        fontWeight: FontWeight.w600,
        color: Colors.white70,
      ),
      bodyLarge: TextStyle(
        fontSize: AppConstants.bodyText,
        color: Colors.white70,
      ),
      bodyMedium: TextStyle(
        fontSize: AppConstants.bodyText - 2,
        color: Colors.white60,
      ),
    ),
  );
}
