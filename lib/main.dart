import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'pages/splash_page.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  // Required before reading saved locale from device storage (Lecture 11).
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

// Root app widget — manages ThemeMode with simple setState, no Provider (Lecture 10).
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  // Passed down to screens via constructor callbacks so Settings can switch themes.
  void _changeTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VoltStore',
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: _themeMode,
      // Wire easy_localization into MaterialApp (Lecture 11).
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SplashPage(onThemeChanged: _changeTheme),
    );
  }
}
