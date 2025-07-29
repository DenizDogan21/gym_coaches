import 'package:flutter/material.dart';

/// ErrorView widget, hata durumlarında gösterilir.
/// Hata mesajı, yeniden dene butonu parametre olarak alınır.
class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({Key? key, required this.message, required this.onRetry})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.error;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 60, color: color),
            SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: color, fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: onRetry, child: Text('Tekrar Dene')),
          ],
        ),
      ),
    );
  }
}
