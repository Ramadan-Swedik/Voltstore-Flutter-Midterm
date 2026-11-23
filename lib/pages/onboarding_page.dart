import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../widgets/language_button.dart';
import '../widgets/theme_button.dart';
import 'login_page.dart';

// Screen 2: 3-page Onboarding built with the introduction_screen package (Lecture 19).
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.onThemeChanged,
  });

  final ValueChanged<bool> onThemeChanged;

  // Opens the Login page when the user taps Skip or Done.
  void _goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(onThemeChanged: onThemeChanged),
      ),
    );
  }

  Widget _buildIllustration(String assetPath) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Image.asset(
        assetPath,
        width: 260,
        height: 260,
        fit: BoxFit.contain,
      )
          .animate()
          .fadeIn(duration: 500.ms)
          .scale(
            begin: const Offset(0.9, 0.9),
            end: const Offset(1.0, 1.0),
            curve: Curves.easeOut,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: (textTheme.headlineSmall ?? const TextStyle()).copyWith(
        fontWeight: FontWeight.bold,
        color: colorScheme.onSurface,
      ),
      bodyTextStyle: (textTheme.bodyLarge ?? const TextStyle()).copyWith(
        color: colorScheme.onSurfaceVariant,
        height: 1.5,
      ),
      imagePadding: const EdgeInsets.only(top: 32, bottom: 16),
      contentMargin: const EdgeInsets.symmetric(horizontal: 24),
      pageColor: colorScheme.surface,
    );

    return Scaffold(
      body: SafeArea(
        child: IntroductionScreen(
          globalBackgroundColor: colorScheme.surface,
          // Top header so the user can even try Dark Mode or Arabic during onboarding.
          globalHeader: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ThemeButton(onThemeChanged: onThemeChanged),
                const LanguageButton(),
              ],
            ),
          ),
          pages: [
            PageViewModel(
              title: context.tr('onboarding.page1_title'),
              body: context.tr('onboarding.page1_body'),
              image: _buildIllustration('assets/images/onboarding_1.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: context.tr('onboarding.page2_title'),
              body: context.tr('onboarding.page2_body'),
              image: _buildIllustration('assets/images/onboarding_2.png'),
              decoration: pageDecoration,
            ),
            PageViewModel(
              title: context.tr('onboarding.page3_title'),
              body: context.tr('onboarding.page3_body'),
              image: _buildIllustration('assets/images/onboarding_3.png'),
              decoration: pageDecoration,
            ),
          ],
          showSkipButton: true,
          skip: Text(
            context.tr('onboarding.skip'),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          next: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              context.tr('onboarding.next'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          done: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              context.tr('onboarding.done'),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
          onSkip: () => _goToLogin(context),
          onDone: () => _goToLogin(context),
          dotsDecorator: DotsDecorator(
            size: const Size(9, 9),
            activeSize: const Size(24, 9),
            color: colorScheme.outlineVariant,
            activeColor: colorScheme.primary,
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ),
    );
  }
}
