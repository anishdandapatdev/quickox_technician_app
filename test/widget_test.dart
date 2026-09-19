import 'package:flutter_test/flutter_test.dart';
import 'package:quickox_technician_app/main.dart';

void main() {
  testWidgets('QuickoxApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const QuickoxApp());
    expect(find.byType(QuickoxApp), findsOneWidget);
  });
}
