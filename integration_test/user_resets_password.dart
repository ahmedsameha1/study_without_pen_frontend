import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nonso/nonso.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/field_page.dart';
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
          "http://10.0.2.2:9099/emulator/v1/projects/learn-gcp-380012/accounts"));
      await FirebaseAuth.instance.signOut();
    });

    group("Android", () {
      group("English", () {
        final signInButtonFinder =
            find.widgetWithText(ElevatedButton, "Sign in");
        final forgotPasswordButtonFinder =
            find.widgetWithText(ElevatedButton, "Forgot password?");
        //This test fails
        //I think because the firebase emulator doesn't send error when using invalid email
        testWidgets("""Pressing the sign in button while
            there some input in the input fields: successful case
            :email verified
            then the user signs out
            then the user presses the sign in button
            then the user provide an invalid email
            then a snack bar with the error code is displayed""",
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
                  "http://10.0.2.2:9099/emulator/v1/projects/learn-gcp-380012/oobCodes"));
              if (response.statusCode == 200) {
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
                  var emailTextFormFieldFinder =
                      find.byType(TextFormField).at(0);
                  final passwordTextFormFieldFinder =
                      find.byType(TextFormField).at(1);
                  await widgetTester.enterText(
                      emailTextFormFieldFinder, validEmail);
                  await widgetTester.enterText(
                      passwordTextFormFieldFinder, "gweruigwiba");
                  await widgetTester.pumpAndSettle();
                  await widgetTester.tap(signInButtonFinder);
                  await widgetTester.pumpAndSettle();
                  expect(find.byType(FieldPage), findsOneWidget);
                  await widgetTester.tap(find.byKey(Key("logoutIconButton")));
                  await widgetTester.pumpAndSettle();
                  expect(find.byType(AuthOptions), findsOneWidget);
                  await widgetTester.tap(signInButtonFinder);
                  await widgetTester.pumpAndSettle();
                  expect(find.byType(Password), findsOneWidget);
                  emailTextFormFieldFinder = find.byType(TextFormField).at(0);
                  await widgetTester.enterText(
                      emailTextFormFieldFinder, "test10@t");
                  await widgetTester.tap(forgotPasswordButtonFinder);
                  await widgetTester.pumpAndSettle();
                  final snackBarFinder = find.byType(SnackBar);
                  final snakBarTextFinder = find.descendant(
                      of: snackBarFinder, matching: find.text("invalid-email"));
                  expect(snackBarFinder, findsOneWidget);
                  expect(snakBarTextFinder, findsOneWidget);
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

        //This test fails
        //I think because the firebase emulator, because I have tested it manually!!
        testWidgets("""Pressing the sign in button while
            there some input in the input fields: successful case
            :email verified
            then the user signs out
            then the user presses the sign in button
            then the user provide an valid email
            then a snack bar that directs user to check his email inbox is displayed""",
            (WidgetTester widgetTester) async {
          var validEmail = "test-sign-in2@test.com";
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
                  "http://10.0.2.2:9099/emulator/v1/projects/learn-gcp-380012/oobCodes"));
              if (response.statusCode == 200) {
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
                  var emailTextFormFieldFinder =
                      find.byType(TextFormField).at(0);
                  final passwordTextFormFieldFinder =
                      find.byType(TextFormField).at(1);
                  await widgetTester.enterText(
                      emailTextFormFieldFinder, validEmail);
                  await widgetTester.enterText(
                      passwordTextFormFieldFinder, "gweruigwiba");
                  await widgetTester.pumpAndSettle();
                  await widgetTester.tap(signInButtonFinder);
                  await widgetTester.pumpAndSettle();
                  expect(find.byType(FieldPage), findsOneWidget);
                  await widgetTester.tap(find.byKey(Key("logoutIconButton")));
                  await widgetTester.pumpAndSettle();
                  expect(find.byType(AuthOptions), findsOneWidget);
                  await widgetTester.tap(signInButtonFinder);
                  await widgetTester.pumpAndSettle();
                  expect(find.byType(Password), findsOneWidget);
                  emailTextFormFieldFinder = find.byType(TextFormField).at(0);
                  await widgetTester.enterText(
                      emailTextFormFieldFinder, validEmail);
                  await widgetTester.tap(forgotPasswordButtonFinder);
                  await widgetTester.pumpAndSettle();
                  final snackBarFinder = find.byType(SnackBar);
                  final snakBarTextFinder = find.descendant(
                      of: snackBarFinder, matching: find.text("Check your email inbox to get the reset code"));
                  expect(snackBarFinder, findsOneWidget);
                  expect(snakBarTextFinder, findsOneWidget);
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
