import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gym_coaches/app/theme.dart';
import 'package:gym_coaches/core/constants/app_constants.dart';
import 'package:gym_coaches/presentation/features/home/widgets/summary_card.dart';
import 'package:gym_coaches/presentation/features/home/widgets/training_card.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.mediumPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppConstants.largePadding),

          Center(
            child: Text(
              'Hoş geldin, Antrenör!',
              style: textTheme.headlineLarge,
            ),
          ),
          const SizedBox(height: AppConstants.mediumPadding),

          // Özet kartlar
          Row(
            children: const [
              Expanded(
                child: SummaryCard(
                  title: "Toplam Öğrenci",
                  value: "12",
                  icon: Icons.people,
                  color: AppTheme.primaryLight,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: SummaryCard(
                  title: "Aktif Program",
                  value: "5",
                  icon: Icons.fitness_center,
                  color: AppTheme.successLight,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: SummaryCard(
                  title: "Gelecek Ödeme",
                  value: "3",
                  icon: Icons.attach_money,
                  color: AppTheme.secondaryLight,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppConstants.largePadding),
          Text('Yaklaşan Antrenmanlar', style: textTheme.headlineMedium),
          const SizedBox(height: AppConstants.smallPadding),

          // Dummy antrenmanlar
          ...List.generate(3, (index) {
            return TrainingCard(
              title: "Antrenman ${index + 1}",
              time: "Bugün - 17:00",
            );
          }),
        ],
      ),
    );
  }
}

// Diğer tablar placeholder
class StudentsTab extends StatelessWidget {
  const StudentsTab({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("Öğrenciler Sayfası"));
}

class ProgramsTab extends StatelessWidget {
  const ProgramsTab({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("Programlar Sayfası"));
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});
  @override
  Widget build(BuildContext context) =>
      const Center(child: Text("Profil Sayfası"));
}

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeTab(),
    StudentsTab(),
    ProgramsTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Öğrenciler',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Programlar',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
