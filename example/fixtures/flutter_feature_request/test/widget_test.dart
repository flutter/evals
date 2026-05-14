import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_feature_request/main.dart';

void main() {
  testWidgets('Counter starts at 0', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('0'), findsOneWidget);
  });

  testWidgets('Increment button increases counter', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('0'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });

  testWidgets('Reset button exists', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // The app should have a reset button with a refresh icon or "Reset" text.
    final resetButton = find.byTooltip('Reset');
    expect(resetButton, findsOneWidget,
        reason: 'Expected a button with tooltip "Reset"');
  });

  testWidgets('Reset button resets counter to 0', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    // Increment a few times.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);

    // Tap reset.
    await tester.tap(find.byTooltip('Reset'));
    await tester.pump();

    // Counter should be back to 0.
    expect(find.text('0'), findsOneWidget);
  });
}
