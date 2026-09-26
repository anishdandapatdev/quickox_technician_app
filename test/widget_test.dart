import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quickox_technician_app/features/auth/screens/login_screen.dart';
import 'package:quickox_technician_app/features/auth/screens/otp_verification_screen.dart';
import 'package:quickox_technician_app/features/auth/screens/profile_setup_screen.dart';
import 'package:quickox_technician_app/features/auth/widgets/rounded_password_input.dart';
import 'package:quickox_technician_app/features/auth/widgets/rounded_phone_input.dart';
import 'package:quickox_technician_app/features/auth/widgets/rounded_text_input.dart';
import 'package:quickox_technician_app/features/navigation/main_navigation_screen.dart';
import 'package:quickox_technician_app/features/navigation/widgets/modern_bottom_nav_bar.dart';
import 'package:quickox_technician_app/features/profile/screens/profile_screen.dart';
import 'package:quickox_technician_app/features/services/screens/shop_parts_screen.dart';
import 'package:quickox_technician_app/main.dart';

void main() {
  testWidgets('QuickoxApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const QuickoxApp());
    expect(find.byType(QuickoxApp), findsOneWidget);
  });

  testWidgets('ShopPartsScreen renders without error', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: ShopPartsScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Products & Spare Parts'), findsOneWidget);
    expect(find.text('AC Power Cord'), findsOneWidget);
  });

  testWidgets('ShopPartsScreen renders on small 360x640 screen without overflow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(720, 1280);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: ShopPartsScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Products & Spare Parts'), findsOneWidget);
    expect(find.text('AC Power Cord'), findsOneWidget);
  });

  testWidgets('MainNavigationScreen renders modern nav bar and switches tabs', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: MainNavigationScreen(),
      ),
    );
    await tester.pumpAndSettle();

    final navBarFinder = find.byType(ModernBottomNavBar);
    expect(navBarFinder, findsOneWidget);

    // Verify nav items are present inside ModernBottomNavBar
    expect(find.descendant(of: navBarFinder, matching: find.text('Home')), findsOneWidget);
    expect(find.descendant(of: navBarFinder, matching: find.text('Services')), findsOneWidget);
    expect(find.descendant(of: navBarFinder, matching: find.text('Membership')), findsOneWidget);
    expect(find.descendant(of: navBarFinder, matching: find.text('Book')), findsOneWidget);
    expect(find.descendant(of: navBarFinder, matching: find.text('Profile')), findsOneWidget);

    // Verify badge count '1' on Book tab
    expect(find.descendant(of: navBarFinder, matching: find.text('1')), findsOneWidget);

    // Tap Services tab
    await tester.tap(find.descendant(of: navBarFinder, matching: find.text('Services')));
    await tester.pumpAndSettle();

    // Tap Profile tab
    await tester.tap(find.descendant(of: navBarFinder, matching: find.text('Profile')));
    await tester.pumpAndSettle();
    expect(find.text('My Profile'), findsOneWidget);
  });

  testWidgets('MainNavigationScreen renders on small 360x640 screen without overflow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(720, 1280);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: MainNavigationScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(ModernBottomNavBar), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
  });

  test('google.png asset is bundled and readable', () async {
    final byteData = await rootBundle.load('assets/images/google.png');
    expect(byteData.lengthInBytes, greaterThan(0));
  });

  testWidgets('LoginScreen renders phone, password, and Log In button', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(RoundedPhoneInput), findsOneWidget);
    expect(find.byType(RoundedPasswordInput), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsOneWidget);

    // Tap Log In with empty inputs and verify validation
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();
    expect(find.text('Enter a valid 10-digit mobile number'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
  });

  testWidgets('OtpVerificationScreen renders elements matching design mockup', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: OtpVerificationScreen(phoneNumber: '+91 1234567890'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Enter OTP'), findsOneWidget);
    expect(find.text("We've sent a 6-digit verification code to"), findsOneWidget);
    expect(find.text('+91 1234567890'), findsOneWidget);
    expect(find.text('Edit'), findsOneWidget);
    expect(find.text("Didn't receive the code?"), findsOneWidget);
    expect(find.text('Resend Code'), findsOneWidget);
    expect(find.text('Verify OTP'), findsOneWidget);
    expect(find.text('By logging in I agree to the'), findsOneWidget);
    expect(find.text('Terms & Conditions'), findsOneWidget);
    expect(find.text('Privacy Policy'), findsOneWidget);
    expect(find.byType(TextFormField), findsNWidgets(6));
  });

  testWidgets('OtpVerificationScreen renders on small 360x640 screen without overflow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(720, 1280);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: OtpVerificationScreen(phoneNumber: '+91 1234567890'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Enter OTP'), findsOneWidget);
    expect(find.text('Verify OTP'), findsOneWidget);
  });

  testWidgets('ProfileSetupScreen renders rounded input sections and validates', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileSetupScreen(phoneNumber: '+91 1234567890'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Set Up Profile'), findsOneWidget);
    expect(find.byType(RoundedTextInput), findsNWidgets(3));
    expect(find.text('Current'), findsOneWidget);
    expect(find.text('Complete & Get Started'), findsOneWidget);

    // Tap Complete & Get Started with empty name and verify validation
    await tester.ensureVisible(find.text('Complete & Get Started'));
    await tester.tap(find.text('Complete & Get Started'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter your full name'), findsOneWidget);
  });

  testWidgets('ProfileSetupScreen renders on small 360x640 screen without overflow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(720, 1280);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileSetupScreen(phoneNumber: '+91 1234567890'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Set Up Profile'), findsOneWidget);
    expect(find.byType(RoundedTextInput), findsNWidgets(3));
  });

  testWidgets('ProfileScreen renders grouped sections matching mockup', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.75;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(
      const MaterialApp(
        home: ProfileScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('Manage your account and preferences'), findsOneWidget);
    expect(find.text('Personal Information'), findsOneWidget);
    expect(find.text('Saved Addresses'), findsOneWidget);
    expect(find.text('Emergency Contacts'), findsOneWidget);
    expect(find.text('BOOKINGS & SERVICES'), findsOneWidget);
    expect(find.text('My Bookings'), findsOneWidget);
    expect(find.text('Services'), findsOneWidget);
    expect(find.text('MEMBERSHIP & OFFERS'), findsOneWidget);
    expect(find.text('Membership Plans'), findsOneWidget);
    expect(find.text('Offers'), findsOneWidget);
    expect(find.text('SUPPORT & SECURITY'), findsOneWidget);
    expect(find.text('Help Center'), findsOneWidget);
    expect(find.text('Privacy & Security'), findsOneWidget);
    expect(find.text('Account Deletion'), findsOneWidget);
    expect(find.text('APP SETTINGS'), findsOneWidget);
    expect(find.text('Notifications'), findsOneWidget);
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Log Out'), findsOneWidget);
  });
}

