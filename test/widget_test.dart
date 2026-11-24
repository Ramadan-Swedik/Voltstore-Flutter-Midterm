import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:midterm_shop_app/main.dart';
import 'package:midterm_shop_app/pages/home_page.dart';
import 'package:midterm_shop_app/pages/login_page.dart';
import 'package:midterm_shop_app/pages/onboarding_page.dart';
import 'package:midterm_shop_app/pages/product_details_page.dart';
import 'package:midterm_shop_app/pages/settings_page.dart';
import 'package:midterm_shop_app/pages/sign_up_page.dart';
import 'package:midterm_shop_app/pages/splash_page.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // Mock SharedPreferences channel used internally by easy_localization.
    const MethodChannel prefsChannel =
        MethodChannel('plugins.flutter.io/shared_preferences');
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(prefsChannel, (MethodCall call) async {
      if (call.method == 'getAll') {
        return <String, Object>{};
      }
      return true;
    });
    await EasyLocalization.ensureInitialized();
  });

  testWidgets(
      'Full midterm flow: Splash -> Onboarding -> Login <-> SignUp -> Home -> Details -> Settings (Dark Mode & Arabic RTL)',
      (WidgetTester tester) async {
    // Use a standard mobile phone viewport (412x915).
    tester.view.physicalSize = const Size(412, 915);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        startLocale: const Locale('en'),
        saveLocale: false,
        child: const MyApp(),
      ),
    );
    await tester.pump();

    // 1. Splash screen appears first
    expect(find.byType(SplashPage), findsOneWidget);

    // 2. After 2.5s timer, Onboarding appears with 3 pages
    await tester.pump(const Duration(milliseconds: 2600));
    await tester.pumpAndSettle();
    expect(find.byType(OnboardingPage), findsOneWidget);
    expect(find.text('Discover Next-Gen Tech'), findsOneWidget);

    // 3. Tap Skip -> opens LoginPage
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.text('Welcome back'), findsOneWidget);

    // 4. Tap Sign up -> opens SignUpPage, then tap Log in -> pops back to LoginPage
    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();
    expect(find.byType(SignUpPage), findsOneWidget);
    expect(find.text('Create account'), findsAtLeastNWidgets(1));

    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPage), findsOneWidget);

    // 5. Type email and tap Login -> opens HomePage
    await tester.enterText(find.byType(TextField).first, 'danos@volt.ly');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Hello, danos@volt.ly!'), findsOneWidget);
    expect(find.text('Volt Air Pro'), findsOneWidget);

    // 6. Bonus: Tap a product -> opens ProductDetailsPage, then pop back
    await tester.ensureVisible(find.text('Volt Air Pro'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Volt Air Pro'));
    await tester.pumpAndSettle();
    expect(find.byType(ProductDetailsPage), findsOneWidget);
    expect(find.text('About this gadget'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);

    // 7. Tap Settings icon -> opens SettingsPage
    await tester.tap(find.byIcon(Icons.settings_rounded));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);

    // 8. Toggle Dark Mode switch -> Theme brightness becomes Brightness.dark
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();
    final BuildContext settingsContext =
        tester.element(find.byType(SettingsPage));
    expect(Theme.of(settingsContext).brightness, Brightness.dark);

    // 9. Toggle Language button -> switches to Arabic (RTL)
    await tester.tap(find.text('العربية'));
    await tester.pumpAndSettle();
    expect(find.text('الإعدادات'), findsOneWidget);
    expect(find.text('الوضع الداكن'), findsOneWidget);
    expect(
      Directionality.of(tester.element(find.byType(SettingsPage))),
      ui.TextDirection.rtl,
    );
  });
}
