import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nonso/nonso.dart';
import 'package:study_without_pen_by_flutter/firebase_options.dart';
import 'package:http/http.dart' as http;
import 'package:study_without_pen_by_flutter/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("User signs in using his account", () {
    setUpAll(() async {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      var response = await http.post(
          Uri.parse(
              "http://10.0.2.2:9099/identitytoolkit.googleapis.com/v1/accounts:signUp?key=${DefaultFirebaseOptions.currentPlatform.apiKey}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Charset': 'utf-8'
          },
          body: jsonEncode(<String, dynamic>{
            "email": "test@test.com",
            "password": "gweruigwiba",
            "returnSecureToken": true
          }));
      if (response.statusCode != 200) {
        fail("failed while creating a user account");
      }
    });

    tearDownAll(() async {
      await http.delete(Uri.parse(
          "http://10.0.2.2:9099/emulator/v1/projects/com-ahmedsameha1-peninbin/accounts"));
    });
    group("Android", () {
      group("English", () {
        final signInButtonFinder =
            find.widgetWithText(ElevatedButton, "Sign in");
        testWidgets(
            "Entering invalid email in the email TextFormField on the Password widget",
            (WidgetTester widgetTester) async {
          await app.main();
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(signInButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Password), findsOneWidget);
          final emailTextFormFieldFinder = find.byType(TextFormField).at(0);
          final invalidEmailTextFinder = find.descendant(
              of: emailTextFormFieldFinder,
              matching: find.text("This an invalid email"));
          await widgetTester.enterText(emailTextFormFieldFinder, "f");
          await widgetTester.pumpAndSettle();
          expect(invalidEmailTextFinder, findsOneWidget);
          await widgetTester.enterText(emailTextFormFieldFinder, "f@");
          await widgetTester.pumpAndSettle();
          expect(invalidEmailTextFinder, findsOneWidget);
          await widgetTester.enterText(
              emailTextFormFieldFinder, "test@test.com");
          await widgetTester.pumpAndSettle();
          expect(invalidEmailTextFinder, findsNothing);
          await widgetTester.enterText(
              emailTextFormFieldFinder, "test@شبكة.com");
          await widgetTester.pumpAndSettle();
          expect(invalidEmailTextFinder, findsNothing);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets(
            "Entering invalid password in the password TextFormField on the Password widget",
            (WidgetTester widgetTester) async {
          await app.main();
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(signInButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Password), findsOneWidget);
          final passwordTextFormFieldFinder = find.byType(TextFormField).at(1);
          final invalidEmailTextFinder = find.descendant(
              of: passwordTextFormFieldFinder,
              matching:
                  find.text("Password needs to be at least 8 characters"));
          await widgetTester.enterText(passwordTextFormFieldFinder, "f");
          await widgetTester.pumpAndSettle();
          expect(invalidEmailTextFinder, findsOneWidget);
          await widgetTester.enterText(
              passwordTextFormFieldFinder, "test@شبكة.com");
          await widgetTester.pumpAndSettle();
          expect(invalidEmailTextFinder, findsNothing);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets("""Pressing the system back button exits the app""",
            (WidgetTester widgetTester) async {
          await app.main();
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(signInButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Password), findsOneWidget);
          final dynamic widgetsAppState =
              widgetTester.state(find.byType(WidgetsApp));
          await widgetsAppState.didPopRoute();
          await widgetTester.pumpAndSettle();
          expect(exitCode, 0);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets("""Pressing the cancel button returns
            the user to the AuthOptions page""",
            (WidgetTester widgetTester) async {
          await app.main();
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(signInButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Password), findsOneWidget);
          final cancelButtonFinder =
              find.widgetWithText(ElevatedButton, "Cancel");
          await widgetTester.tap(cancelButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

      });
    });
  });
}
