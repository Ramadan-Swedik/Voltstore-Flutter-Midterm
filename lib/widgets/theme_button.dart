import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Reusable sun/moon button that switches Light and Dark mode (Lecture 10).
class ThemeButton extends StatelessWidget {
  const ThemeButton({
    super.key,
    required this.onThemeChanged,
  });

  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return IconButton(
      tooltip: isDark
          ? context.tr('theme.light_mode')
          : context.tr('theme.dark_mode'),
      onPressed: () {
        onThemeChanged(!isDark);
      },
      icon: Icon(
        isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
        color: colorScheme.primary,
      ),
    );
  }
}
