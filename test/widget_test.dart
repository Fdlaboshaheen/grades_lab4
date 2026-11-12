import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grades_lab4/main.dart';

void main() {
  testWidgets('average updates when a grade changes', (tester) async {
    await tester.pumpWidget(const GradesApp());
    expect(find.text('ממוצע: 66.3'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add).first); // נועה 92 -> 93
    await tester.pump();
    expect(find.text('ציון: 93'), findsOneWidget);
    expect(find.text('ממוצע: 66.5'), findsOneWidget);
  });
}
