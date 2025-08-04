import 'package:flutter/material.dart';

/// StatusBadge widget, success, error, warning ve info türlerinde küçük etiket gösterir.
/// Renk ve ikonları tema renklerinden alır.
class StatusBadge extends StatelessWidget {
  final String text;
  final StatusType statusType;

  const StatusBadge({
    Key? key,
    required this.text,
    this.statusType = StatusType.info,
  }) : super(key: key);

  //Renk ve İkon Belirleme:
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color bgColor;
    IconData icon;
    Color textColor;

    switch (statusType) {
      case StatusType.success:
        bgColor = colorScheme.secondary.withOpacity(0.1);
        textColor = colorScheme.secondary;
        icon = Icons.check_circle;
        break;
      case StatusType.error:
        bgColor = colorScheme.error.withOpacity(0.1);
        textColor = colorScheme.error;
        icon = Icons.error_outline;
        break;
      case StatusType.warning:
        bgColor = colorScheme.secondary.withOpacity(0.1);
        textColor = colorScheme.tertiary;
        icon = Icons.warning;
        break;
      case StatusType.info:
      default:
        bgColor = colorScheme.primary.withOpacity(0.1);
        textColor = colorScheme.primary;
        icon = Icons.info_outline;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: bgColor.darken(0.3)),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

enum StatusType { success, error, warning, info }

extension ColorExtension on Color {
  Color darken([double amount = .1]) {
    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));
    return hslDark.toColor();
  }
}
