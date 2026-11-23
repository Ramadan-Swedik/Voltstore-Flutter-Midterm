import 'package:flutter/material.dart';

// Reusable full-width primary button used across Login, Sign Up, Details, and Settings (Lecture 8 & 10).
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isDestructive = false,
  });

  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final ButtonStyle? style = isDestructive
        ? ElevatedButton.styleFrom(
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
          )
        : null;

    if (icon != null) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: style,
          onPressed: onPressed,
          icon: Icon(icon),
          label: Text(text),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: style,
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
