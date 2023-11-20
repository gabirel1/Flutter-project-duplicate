// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/Elements/bottom_navigation_bar.dart';

void main() {
  testWidgets('MyBottomNavigationBar test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MyBottomNavigationBar(),
      ),
    );
    expect(find.byType(MyBottomNavigationBar), findsOneWidget);
    // list all widgets inside
    expect(find.byType(Icon), findsNWidgets(3));
    // check if first is 'Home'
    expect(find.text('Home'), findsOneWidget);
    // check if second is 'Basket'
    expect(find.text('Basket'), findsOneWidget);
    // check if third is 'Profile'
    expect(find.text('Profile'), findsOneWidget);
  });
}
