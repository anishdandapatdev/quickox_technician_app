import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quickox_technician_app/features/navigation/main_navigation_screen.dart';
import 'package:quickox_technician_app/features/navigation/widgets/modern_bottom_nav_bar.dart';
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
}

