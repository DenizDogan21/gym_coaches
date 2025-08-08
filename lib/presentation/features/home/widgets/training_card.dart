import 'package:flutter/material.dart';
import 'package:gym_coaches/app/theme.dart';
import 'package:gym_coaches/core/constants/app_constants.dart';

class TrainingCard extends StatelessWidget {
  final String title;
  final String time;
  final Color backgroundColor;

  const TrainingCard({
    super.key,
    required this.title,
    required this.time,
    this.backgroundColor = AppTheme.primaryDark,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.cardRadius),
      ),
      child: ListTile(
        leading: const Icon(Icons.access_time),
        title: Text(title, style: textTheme.bodyLarge),
        subtitle: Text(time, style: textTheme.bodyMedium),
      ),
    );
  }
}
