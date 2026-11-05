
import 'package:flutter_test/flutter_test.dart';
import 'package:plantiq/main.dart';

void main() {
  testWidgets('PLANTIQ loads the dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(const PlantIQApp());
    await tester.pump();
    expect(find.text('PLANTIQ'), findsWidgets);
    expect(find.text('Your Plant Collection'), findsOneWidget);
    expect(find.text('Monstera Deliciosa'), findsWidgets);
  });
}
