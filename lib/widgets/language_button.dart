import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Reusable Arabic / English language switch button using easy_localization (Lecture 11).
class LanguageButton extends StatelessWidget {
  const LanguageButton({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';

    return TextButton.icon(
      onPressed: () {
        context.setLocale(
          isArabic ? const Locale('en') : const Locale('ar'),
        );
      },
      icon: const Icon(Icons.language),
      // Shows the OTHER language in its own script, just like Lecture 11.
      label: Text(isArabic ? 'English' : 'العربية'),
    );
  }
}
