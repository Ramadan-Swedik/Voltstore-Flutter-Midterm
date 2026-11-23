import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/app_button.dart';
import '../widgets/language_button.dart';
import 'login_page.dart';

// Screen 6: Settings page with working Dark Mode switch (Lecture 10) and Arabic / English button (Lecture 11).
class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
    required this.userName,
    required this.onThemeChanged,
  });

  final String userName;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final String displayUser =
        userName.isEmpty ? context.tr('home.guest') : userName;

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('settings.title')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Section 1: Appearance (Dark Mode Switch)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 4, bottom: 8),
            child: Text(
              context.tr('settings.appearance_section'),
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            child: SwitchListTile(
              secondary: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              title: Text(
                context.tr('settings.dark_mode'),
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                isDark
                    ? context.tr('settings.dark_mode_subtitle_on')
                    : context.tr('settings.dark_mode_subtitle_off'),
              ),
              value: isDark,
              onChanged: onThemeChanged,
            ),
          ).animate().fadeIn(duration: 350.ms).slideY(begin: 0.1),
          const SizedBox(height: 22),

          // Section 2: Language (Arabic / English switcher)
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 4, bottom: 8),
            child: Text(
              context.tr('settings.language_section'),
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 6,
              ),
              leading: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.translate_rounded,
                  color: colorScheme.onSecondaryContainer,
                ),
              ),
              title: Text(
                context.tr('settings.language_label'),
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(context.tr('settings.language_subtitle')),
              trailing: const LanguageButton(),
            ),
          ).animate().fadeIn(delay: 100.ms, duration: 350.ms).slideY(begin: 0.1),
          const SizedBox(height: 22),

          // Section 3: Account & Log Out
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 4, bottom: 8),
            child: Text(
              context.tr('settings.account_section'),
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: colorScheme.primaryContainer,
                        child: Text(
                          displayUser[0].toUpperCase(),
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          context.tr(
                            'settings.signed_in_as',
                            namedArgs: {'user': displayUser},
                          ),
                          style: textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    text: context.tr('settings.logout'),
                    icon: Icons.logout_rounded,
                    isDestructive: true,
                    onPressed: () {
                      // Return to LoginPage cleanly and clear routes above it.
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(
                            onThemeChanged: onThemeChanged,
                          ),
                        ),
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 200.ms, duration: 350.ms).slideY(begin: 0.1),
          const SizedBox(height: 32),

          // App Version Footer
          Center(
            child: Text(
              context.tr('settings.version'),
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
