import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
}
