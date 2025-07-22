import 'package:flutter/material.dart';
import '../routes.dart';
import 'theme.dart';

class GymCoachesApp extends StatelessWidget {
  const GymCoachesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Gym Coaches',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}