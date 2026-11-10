import 'package:flutter_test/flutter_test.dart';
import 'package:jcoco_management_app/main.dart';

void main() {
  testWidgets('JCOCO Management App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const JCocoManagementApp());
    expect(find.text('J.COCO'), findsOneWidget);
  });
}
