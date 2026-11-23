import 'package:flutter/material.dart';

// Reusable custom text field used on Login and Sign Up pages (Lectures 8, 9 & 10).
// Styling (rounded outline border, fill color) comes from inputDecorationTheme in app_theme.dart.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.icon,
    this.isPassword = false,
    this.onChanged,
    this.keyboardType,
  });

  final String label;
  final IconData icon;
  final bool isPassword;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  // Tracks whether password characters are hidden (Lecture 9 show/hide password bonus).
  bool _hideText = true;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return TextField(
      obscureText: widget.isPassword ? _hideText : false,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon, color: colorScheme.primary),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _hideText = !_hideText;
                  });
                },
                icon: Icon(
                  _hideText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              )
            : null,
      ),
    );
  }
}
