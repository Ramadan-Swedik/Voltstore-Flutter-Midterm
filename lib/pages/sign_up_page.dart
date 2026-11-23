import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import 'home_page.dart';

// Screen 4: Sign Up page reusing AppTextField (x4) and AppButton (Project 2 & Lecture 9).
class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
    required this.onThemeChanged,
  });

  final ValueChanged<bool> onThemeChanged;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _fullName = '';

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // AppBar automatically shows the Back arrow because this page was pushed.
      appBar: AppBar(
        title: Text(context.tr('signup.app_bar')),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title & Subtitle
              Text(
                context.tr('signup.title'),
                textAlign: TextAlign.center,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.2),
              const SizedBox(height: 8),
              Text(
                context.tr('signup.subtitle'),
                textAlign: TextAlign.center,
                style: textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ).animate().fadeIn(delay: 120.ms),
              const SizedBox(height: 28),
              // 4 fields built with our reusable AppTextField
              AppTextField(
                label: context.tr('signup.full_name'),
                icon: Icons.person_outline,
                onChanged: (value) {
                  setState(() {
                    _fullName = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: context.tr('signup.email'),
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: context.tr('signup.password'),
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: context.tr('signup.confirm_password'),
                icon: Icons.lock_reset_outlined,
                isPassword: true,
              ),
              const SizedBox(height: 28),
              // Full-width Create Account button (reusable AppButton)
              AppButton(
                text: context.tr('signup.button'),
                icon: Icons.person_add_alt_1_rounded,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(
                        userName: _fullName.trim(),
                        onThemeChanged: widget.onThemeChanged,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              // Return to Login page with Navigator.pop (Wrap prevents overflow)
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    context.tr('signup.have_account'),
                    style: textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(context.tr('signup.login_link')),
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
