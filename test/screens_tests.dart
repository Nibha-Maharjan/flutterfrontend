import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/login_screen.dart';
import '../lib/register_screen.dart';
import '../lib/home_page.dart';
import '../lib/patient_list_screen.dart';

void main() {
  //Test for Login page
  testWidgets('Test LoginScreen', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(MaterialApp(
      home: LoginScreen(),
    ));

    // Verify that the login button is present
    expect(find.text('Login'), findsOneWidget);
  });
  //Test for register page
  testWidgets('Test RegisterScreen', (WidgetTester tester) async {
    // Build the RegisterScreen widget
    await tester.pumpWidget(MaterialApp(
      home: RegisterScreen(),
    ));

    // Verify that the "Register" button is present
    expect(find.text('Email'), findsOneWidget);
  });
  //Test for homepage
  testWidgets('Test HomePage', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
        home: HomePage(token: 'testToken', userEmail: 'test@example.com')));
    expect(find.text('Welcome to Centen Hospital App'), findsOneWidget);
  });
}
