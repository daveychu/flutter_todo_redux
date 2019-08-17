import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_redux/main.dart';

void main() {
  testWidgets('smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(new MyApp());

    var text = 'Do push up';
    expect(find.text(text), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    var editableText = find.byType(TextField);
    await tester.enterText(editableText, text);
    await tester.tap(find.byType(RaisedButton));
    await tester.pumpAndSettle();

    expect(find.text(text), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(find.text(text), findsNothing);
  });
}
