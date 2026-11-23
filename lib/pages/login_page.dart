import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/language_button.dart';
import '../widgets/theme_button.dart';
import 'home_page.dart';
import 'sign_up_page.dart';

// Screen 3: Login page using custom AppTextField and AppButton widgets (Lectures 8, 9, 10, 11).
class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
    required this.onThemeChanged,
  });

  final ValueChanged<bool> onThemeChanged;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Remembers the email typed by the user so we can pass it to HomePage (Lecture 9).
  String _email = '';

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Quick theme & language controls at the top
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ThemeButton(onThemeChanged: widget.onThemeChanged),
                  const LanguageButton(),
                ],
              ),
              const SizedBox(height: 20),
              // App Logo from local assets
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 88,
                    height: 88,
                  ),
                ),
              )
                  .animate()
                  .fadeIn(duration: 450.ms)
                  .scale(begin: const Offset(0.85, 0.85)),
              const SizedBox(height: 24),
              // Title & Subtitle
              Text(
                context.tr('login.title'),
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ).animate().fadeIn(delay: 120.ms).slideY(begin: 0.2),
              const SizedBox(height: 8),
              Text(
                context.tr('login.subtitle'),
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ).animate().fadeIn(delay: 200.ms),
              const SizedBox(height: 32),
              // Email field (custom AppTextField)
              AppTextField(
                label: context.tr('login.email'),
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Password field (custom AppTextField with isPassword: true)
              AppTextField(
                label: context.tr('login.password'),
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 8),
              // RTL-safe "Forgot password?" aligned to the end edge (Lecture 11)
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('login.forgot_snack'.tr()),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  child: Text(context.tr('login.forgot_password')),
                ),
              ),
              const SizedBox(height: 16),
              // Full-width Login button (custom AppButton) — UI-only navigation to Home
              AppButton(
                text: context.tr('login.button'),
                icon: Icons.login_rounded,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        userName: _email.trim(),
                        onThemeChanged: widget.onThemeChanged,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              // Link to Sign Up page (Wrap prevents overflow on narrow screens or large fonts)
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    context.tr('login.no_account'),
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpPage(
                            onThemeChanged: widget.onThemeChanged,
                          ),
                        ),
                      );
                    },
                    child: Text(context.tr('login.signup_link')),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
