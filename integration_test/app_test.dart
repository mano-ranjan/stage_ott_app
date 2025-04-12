import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:stage_ott/main.dart';
import 'package:stage_ott/widgets/movie_card.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full app flow test', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Test search
    await tester.enterText(find.byType(TextField), 'batman');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verify results
    expect(find.byType(MovieCard), findsWidgets);

    // Test favorite
    await tester.tap(find.byIcon(Icons.favorite_border).first);
    await tester.pumpAndSettle();

    // Verify favorite
    expect(find.byIcon(Icons.favorite), findsWidgets);

    // Test detail screen
    await tester.tap(find.byType(MovieCard).first);
    await tester.pumpAndSettle();

    // Verify details
    expect(find.text('Plot:'), findsOneWidget);

    // Test back navigation
    await tester.pageBack();
    await tester.pumpAndSettle();
  });
}
