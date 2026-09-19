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
