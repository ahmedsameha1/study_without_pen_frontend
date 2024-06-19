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
    });

    tearDownAll(() async {
      await http.delete(Uri.parse(
          "http://10.0.2.2:9099/emulator/v1/projects/com-ahmedsameha1-peninbin/accounts"));
      await FirebaseAuth.instance.signOut();
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

        testWidgets("""Pressing the sign in button while
            there some input in the input fields: failure case""",
            (WidgetTester widgetTester) async {
          await app.main();
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(signInButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Password), findsOneWidget);
          final emailTextFormFieldFinder = find.byType(TextFormField).at(0);
          final passwordTextFormFieldFinder = find.byType(TextFormField).at(1);
          await widgetTester.enterText(emailTextFormFieldFinder, "foo@foo.com");
          await widgetTester.enterText(
              passwordTextFormFieldFinder, "fhwoefhq[w4]");
          await widgetTester.tap(signInButtonFinder);
          await widgetTester.pumpAndSettle();
          final snackBarFinder = find.byType(SnackBar);
          final snakBarTextFinder = find.descendant(
              of: snackBarFinder,
              matching: find.text("Failure: user-not-found"));
          expect(snackBarFinder, findsOneWidget);
          expect(snakBarTextFinder, findsOneWidget);
          expect(find.byType(Password), findsOneWidget);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets("""Pressing the sign in button while
            there some input in the input fields: successful case""",
            (WidgetTester widgetTester) async {
          var validEmail = "test-sign-in@test.com";
          var response = await http.post(
              Uri.parse(
                  "http://10.0.2.2:9099/identitytoolkit.googleapis.com/v1/accounts:signUp?key=${DefaultFirebaseOptions.currentPlatform.apiKey}"),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Charset': 'utf-8'
              },
              body: jsonEncode(<String, dynamic>{
                "email": validEmail,
                "password": "gweruigwiba",
                "returnSecureToken": true
              }));
          if (response.statusCode == 200) {
            Map<String, dynamic> data = jsonDecode(response.body);
            response = await http.post(
                Uri.parse(
                    "http://10.0.2.2:9099/identitytoolkit.googleapis.com/v1/accounts:sendOobCode?key=${DefaultFirebaseOptions.currentPlatform.apiKey}"),
                headers: <String, String>{
                  'Content-Type': 'application/json; charset=UTF-8',
                  'Charset': 'utf-8'
                },
                body: jsonEncode(<String, dynamic>{
                  "requestType": "VERIFY_EMAIL",
                  "idToken": data["idToken"]
                }));
            if (response.statusCode == 200) {
              response = await http.get(Uri.parse(
                  "http://10.0.2.2:9099/emulator/v1/projects/com-ahmedsameha1-peninbin/oobCodes"));
              if (response.statusCode == 200) {
                print(response.body);
                Map<String, dynamic> data = jsonDecode(response.body);
                List<dynamic> oobCodes = data["oobCodes"];
                response = await http.get(Uri.parse((data["oobCodes"]
                        [oobCodes.length - 1]["oobLink"])
                    .replaceFirst("127.0.0.1", "10.0.2.2")));
                if (response.statusCode == 200) {
                  await app.main();
                  await widgetTester.pumpAndSettle();
                  expect(find.byType(AuthOptions), findsOneWidget);
                  await widgetTester.tap(signInButtonFinder);
                  await widgetTester.pumpAndSettle();
                  expect(find.byType(Password), findsOneWidget);
                  final emailTextFormFieldFinder =
                      find.byType(TextFormField).at(0);
                  final passwordTextFormFieldFinder =
                      find.byType(TextFormField).at(1);
                  await widgetTester.enterText(
                      emailTextFormFieldFinder, validEmail);
                  await widgetTester.enterText(
                      passwordTextFormFieldFinder, "gweruigwiba");
                  await widgetTester.tap(signInButtonFinder);
                  await widgetTester.pumpAndSettle();
                  expect(find.byKey(Key("hi")), findsOneWidget);
                } else {
                  fail("problem");
                }
              } else {
                fail("problem");
              }
            } else {
              fail("problem");
            }
          } else {
            fail("failed while creating a user account");
          }
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));
      });
    });
  });
}
