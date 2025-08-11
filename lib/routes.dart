import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gym_coaches/presentation/features/home/views/dashboard_screen.dart';
import 'package:gym_coaches/presentation/features/auth/views/login_screen.dart';
import 'package:gym_coaches/presentation/features/auth/views/register_screen.dart';
import 'package:gym_coaches/presentation/features/profile/views/profile_screen.dart';

// Şimdilik boş placeholder widget
class PlaceholderScreen extends StatelessWidget {
  final String screenName;
  const PlaceholderScreen({Key? key, required this.screenName})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(screenName)),
      body: Center(child: Text('$screenName ekranı hazırlanıyor...')),
    );
  }
}

// Router yapılandırması
final router = GoRouter(
  initialLocation: '/profil',
  routes: [
    // Splash ve Auth ekranları
    GoRoute(
      path: '/',
      name: 'splash',
      builder:
          (context, state) => const PlaceholderScreen(screenName: 'Splash'),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgotPassword',
      builder:
          (context, state) =>
              const PlaceholderScreen(screenName: 'Forgot Password '),
    ),
    // Dashboard
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),

    // Ana ekran ve alt ekranları
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const PlaceholderScreen(screenName: 'Home '),
    ),
    GoRoute(
      path: '/profil',
      name: 'profil',
      builder: (context, state) => const ProfileScreen(),
    ),

    // Öğrenci ekranları
    GoRoute(
      path: '/students',
      name: 'studentList',
      builder:
          (context, state) =>
              const PlaceholderScreen(screenName: 'Öğrenci Listesi'),
      routes: [
        GoRoute(
          path: 'add',
          name: 'addStudent',
          builder:
              (context, state) =>
                  const PlaceholderScreen(screenName: 'Öğrenci Ekle'),
        ),
        GoRoute(
          path: ':id',
          name: 'studentDetail',
          builder: (context, state) {
            final studentId = state.pathParameters['id'] ?? 'unknown';
            return PlaceholderScreen(screenName: 'Öğrenci Detayı: $studentId');
          },
        ),
      ],
    ),

    // Diğer ana ekranlar
    GoRoute(
      path: '/workout-programs',
      name: 'workoutPrograms',
      builder:
          (context, state) =>
              const PlaceholderScreen(screenName: 'Antrenman Programları'),
    ),
    GoRoute(
      path: '/calendar',
      name: 'calendar',
      builder:
          (context, state) => const PlaceholderScreen(screenName: 'Takvim'),
    ),
    GoRoute(
      path: '/payments',
      name: 'payments',
      builder:
          (context, state) => const PlaceholderScreen(screenName: 'Ödemeler'),
    ),
  ],
);

// Kolay erişim için route isimleri
class AppRoutes {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String register = 'register';
  static const String forgotPassword = 'forgotPassword';
  static const String dashboard = 'dashboard';
  static const String home = 'home';
  static const String profil = 'profil';
  static const String studentList = 'studentList';
  static const String studentDetail = 'studentDetail';
  static const String addStudent = 'addStudent';
  static const String workoutPrograms = 'workoutPrograms';
  static const String calendar = 'calendar';
  static const String payments = 'payments';
}
