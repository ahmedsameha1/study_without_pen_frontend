import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';
import 'package:nonso/nonso.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/fields_page.dart';
import 'package:study_without_pen_by_flutter/firebase_options.dart';

import '../test/features/common/widget_testing_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group("User registers his account", () {
    setUpAll(() async {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    });

    tearDownAll(() async {
      await http.delete(Uri.parse(
          "http://10.0.2.2:9099/emulator/v1/projects/learn-gcp-380012/accounts"));
    });

    group("Android", () {
      group("English", () {
        final registerButtonFinder =
            find.widgetWithText(ElevatedButton, "Register");
        testWidgets(
            "Entering invalid name in the name TextFormField on the Register widget",
            (WidgetTester widgetTester) async {
          await runAppWhileHandlingFlutterError(widgetTester);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          ElevatedButton registerButton =
              widgetTester.widget<ElevatedButton>(registerButtonFinder);
          expect(registerButton.enabled, isFalse);
          final nameTextFormFieldFinder = find.byType(TextFormField).at(0);
          final invalidNameTextFinder = find.descendant(
              of: nameTextFormFieldFinder,
              matching: find.text("Enter your name"));
          await widgetTester.enterText(nameTextFormFieldFinder, " ");
          await widgetTester.pumpAndSettle();
          expect(invalidNameTextFinder, findsOneWidget);
          expect(registerButton.enabled, isFalse);
          await widgetTester.enterText(nameTextFormFieldFinder, "~");
          await widgetTester.pumpAndSettle();
          expect(invalidNameTextFinder, findsOneWidget);
          expect(registerButton.enabled, isFalse);
          await widgetTester.enterText(nameTextFormFieldFinder, "t");
          await widgetTester.pumpAndSettle();
          expect(invalidNameTextFinder, findsNothing);
          expect(registerButton.enabled, isFalse);
          await widgetTester.enterText(nameTextFormFieldFinder, "س");
          await widgetTester.pumpAndSettle();
          expect(invalidNameTextFinder, findsNothing);
          expect(registerButton.enabled, isFalse);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets(
            "Entering invalid email in the email TextFormField on the Register widget",
            (WidgetTester widgetTester) async {
          await runAppWhileHandlingFlutterError(widgetTester);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          ElevatedButton registerButton =
              widgetTester.widget<ElevatedButton>(registerButtonFinder);
          expect(registerButton.enabled, isFalse);
          final emailTextFormFieldFinder = find.byType(TextFormField).at(1);
          final invalidEmailTextFinder = find.descendant(
              of: emailTextFormFieldFinder,
              matching: find.text("This an invalid email."));
          await widgetTester.enterText(emailTextFormFieldFinder, "f");
          await widgetTester.pumpAndSettle();
          expect(invalidEmailTextFinder, findsOneWidget);
          expect(registerButton.enabled, isFalse);
          await widgetTester.enterText(emailTextFormFieldFinder, "f@");
          await widgetTester.pumpAndSettle();
          expect(invalidEmailTextFinder, findsOneWidget);
          expect(registerButton.enabled, isFalse);
          await widgetTester.enterText(
              emailTextFormFieldFinder, "test@test.com");
          await widgetTester.pumpAndSettle();
          expect(invalidEmailTextFinder, findsNothing);
          expect(registerButton.enabled, isFalse);
          await widgetTester.enterText(
              emailTextFormFieldFinder, "test@شبكة.com");
          await widgetTester.pumpAndSettle();
          expect(invalidEmailTextFinder, findsNothing);
          expect(registerButton.enabled, isFalse);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets(
            "Entering invalid password in the password TextFormField on the Register widget",
            (WidgetTester widgetTester) async {
          await runAppWhileHandlingFlutterError(widgetTester);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          ElevatedButton registerButton =
              widgetTester.widget<ElevatedButton>(registerButtonFinder);
          expect(registerButton.enabled, isFalse);
          final passwordTextFormFieldFinder = find.byType(TextFormField).at(2);
          final invalidPasswordTextFinder = find.descendant(
              of: passwordTextFormFieldFinder,
              matching:
                  find.text("Password needs to be at least 8 characters."));
          await widgetTester.enterText(passwordTextFormFieldFinder, "f");
          await widgetTester.pumpAndSettle();
          expect(invalidPasswordTextFinder, findsOneWidget);
          expect(registerButton.enabled, isFalse);
          await widgetTester.enterText(
              passwordTextFormFieldFinder, "f92hgvhwe[]");
          await widgetTester.pumpAndSettle();
          expect(invalidPasswordTextFinder, findsNothing);
          expect(registerButton.enabled, isFalse);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets(
            """Entering a password that doesn't match the password in the password TextFormField
               in the confirm password TextFormField on the Register widget""",
            (WidgetTester widgetTester) async {
          await runAppWhileHandlingFlutterError(widgetTester);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          ElevatedButton registerButton =
              widgetTester.widget<ElevatedButton>(registerButtonFinder);
          expect(registerButton.enabled, isFalse);
          final passwordTextFormFieldFinder = find.byType(TextFormField).at(2);
          final confirmPasswordTextFormFieldFinder =
              find.byType(TextFormField).at(3);
          final invalidConfirmPasswordTextFinder = find.descendant(
              of: confirmPasswordTextFormFieldFinder,
              matching: find.text("This doesn't match the given password."));
          await widgetTester.enterText(passwordTextFormFieldFinder, "56&*ptYn");
          await widgetTester.enterText(
              confirmPasswordTextFormFieldFinder, "ewh32eh3wq4tfg");
          await widgetTester.pumpAndSettle();
          expect(invalidConfirmPasswordTextFinder, findsOneWidget);
          expect(registerButton.enabled, isFalse);
          await widgetTester.enterText(
              confirmPasswordTextFormFieldFinder, "56&*ptYn");
          await widgetTester.pumpAndSettle();
          expect(invalidConfirmPasswordTextFinder, findsNothing);
          expect(registerButton.enabled, isFalse);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets("""Pressing the system back button exits the app:
            there is nothing in the input fields""",
            (WidgetTester widgetTester) async {
          await runAppWhileHandlingFlutterError(widgetTester);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          final dynamic widgetsAppState =
              widgetTester.state(find.byType(WidgetsApp));
          await widgetsAppState.didPopRoute();
          await widgetTester.pumpAndSettle();
          expect(exitCode, 0);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets("""Pressing the system back button exits the app:
            there some input in the input fields""",
            (WidgetTester widgetTester) async {
          await runAppWhileHandlingFlutterError(widgetTester);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          final nameTextFormFieldFinder = find.byType(TextFormField).at(0);
          final emailTextFormFieldFinder = find.byType(TextFormField).at(1);
          final passwordTextFormFieldFinder = find.byType(TextFormField).at(2);
          final confirmPasswordTextFormFieldFinder =
              find.byType(TextFormField).at(3);
          await widgetTester.enterText(nameTextFormFieldFinder, "foo");
          await widgetTester.enterText(
              emailTextFormFieldFinder, "test@test.com");
          await widgetTester.enterText(
              passwordTextFormFieldFinder, "fhwoefhq[w4]");
          await widgetTester.enterText(
              confirmPasswordTextFormFieldFinder, "fhwoefhq[w4]");
          final dynamic widgetsAppState =
              widgetTester.state(find.byType(WidgetsApp));
          await widgetsAppState.didPopRoute();
          await widgetTester.pumpAndSettle();
          expect(exitCode, 0);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets("""Pressing the cancel button returns
            the user to the AuthOptions page:
            there no input in the input fields""",
            (WidgetTester widgetTester) async {
          await runAppWhileHandlingFlutterError(widgetTester);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          final cancelButtonFinder =
              find.widgetWithText(ElevatedButton, "Cancel");
          await widgetTester.tap(cancelButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets("""Pressing the cancel button returns
            the user to the AuthOptions page:
            there some input in the input fields""",
            (WidgetTester widgetTester) async {
          await runAppWhileHandlingFlutterError(widgetTester);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          final nameTextFormFieldFinder = find.byType(TextFormField).at(0);
          final emailTextFormFieldFinder = find.byType(TextFormField).at(1);
          final passwordTextFormFieldFinder = find.byType(TextFormField).at(2);
          final confirmPasswordTextFormFieldFinder =
              find.byType(TextFormField).at(3);
          await widgetTester.enterText(nameTextFormFieldFinder, "foo");
          await widgetTester.enterText(
              emailTextFormFieldFinder, "test@test.com");
          await widgetTester.enterText(
              passwordTextFormFieldFinder, "fhwoefhq[w4]");
          await widgetTester.enterText(
              confirmPasswordTextFormFieldFinder, "fhwoefhq[w4]");
          final cancelButtonFinder =
              find.widgetWithText(ElevatedButton, "Cancel");
          await widgetTester.tap(cancelButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets("""Pressing the register button while
            there some input in the input fields: failure case""",
            (WidgetTester widgetTester) async {
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
              await runAppWhileHandlingFlutterError(widgetTester);
              await widgetTester.pumpAndSettle();
              expect(find.byType(AuthOptions), findsOneWidget);
              await widgetTester.tap(registerButtonFinder);
              await widgetTester.pumpAndSettle();
              expect(find.byType(Register), findsOneWidget);
              final nameTextFormFieldFinder = find.byType(TextFormField).at(0);
              final emailTextFormFieldFinder = find.byType(TextFormField).at(1);
              final passwordTextFormFieldFinder =
                  find.byType(TextFormField).at(2);
              final confirmPasswordTextFormFieldFinder =
                  find.byType(TextFormField).at(3);
              await widgetTester.enterText(nameTextFormFieldFinder, "foo");
              await widgetTester.enterText(
                  emailTextFormFieldFinder, "test@test.com");
              await widgetTester.enterText(
                  passwordTextFormFieldFinder, "fhwoefhq[w4]");
              await widgetTester.enterText(
                  confirmPasswordTextFormFieldFinder, "fhwoefhq[w4]");
              await widgetTester.pumpAndSettle();
              await widgetTester.tap(registerButtonFinder);
              await widgetTester.pump();
              expect(find.byType(CircularProgressIndicator), findsOneWidget);
              await widgetTester.pumpAndSettle(Durations.long1);
              final snackBarFinder = find.byType(SnackBar);
              final snakBarTextFinder = find.descendant(
                  of: snackBarFinder, matching: find.byType(Text));
              final failureText = widgetTester.widget<Text>(snakBarTextFinder);
              expect(failureText.data!.startsWith("Failure:"), isTrue);
              expect(snakBarTextFinder, findsOneWidget);
              expect(find.byType(Register), findsOneWidget);
            } else {
              fail("problem");
            }
          } else {
            fail("cannot create user ${response.statusCode}, ${response.body}");
          }
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets("""Pressing the register button while
            there some input in the input fields: success case
            then the user verify his email then refresh the account""",
            (WidgetTester widgetTester) async {
          await runAppWhileHandlingFlutterError(widgetTester);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          final nameTextFormFieldFinder = find.byType(TextFormField).at(0);
          final emailTextFormFieldFinder = find.byType(TextFormField).at(1);
          final passwordTextFormFieldFinder = find.byType(TextFormField).at(2);
          final confirmPasswordTextFormFieldFinder =
              find.byType(TextFormField).at(3);
          await widgetTester.enterText(nameTextFormFieldFinder, "foo");
          await widgetTester.enterText(
              emailTextFormFieldFinder, "test33@test.com");
          await widgetTester.enterText(
              passwordTextFormFieldFinder, "fhwoefhq[w4]");
          await widgetTester.enterText(
              confirmPasswordTextFormFieldFinder, "fhwoefhq[w4]");
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pump();
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          await widgetTester.pumpAndSettle(Durations.long1);
          final snackBarFinder = find.byType(SnackBar);
          final snakBarTextFinder = find.descendant(
              of: snackBarFinder,
              matching: find.text(
                  "Success: Check your email inbox to verify your email address."));
          expect(snackBarFinder, findsOneWidget);
          expect(snakBarTextFinder, findsOneWidget);
          expect(find.byType(Locked), findsOneWidget);
          var response = await http.get(Uri.parse(
              "http://10.0.2.2:9099/emulator/v1/projects/learn-gcp-380012/oobCodes"));
          if (response.statusCode == 200) {
            Map<String, dynamic> data = jsonDecode(response.body);
            List<dynamic> oobCodes = data["oobCodes"];
            response = await http.get(Uri.parse((data["oobCodes"]
                    [oobCodes.length - 1]["oobLink"])
                .replaceFirst("127.0.0.1", "10.0.2.2")));
            if (response.statusCode != 200) {
              fail("problem");
            }
          } else {
            fail("problem");
          }
          final refreshAccountButton =
              find.widgetWithText(ElevatedButton, "Refresh account");
          await widgetTester.tap(refreshAccountButton);
          await widgetTester.pumpAndSettle();
          expect(find.byType(FieldsPage), findsOneWidget);
          await FirebaseAuth.instance.signOut();
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets("""Pressing the register button while
            there some input in the input fields: success case
            then the user ask for resending email for verify 
            his email address""", (WidgetTester widgetTester) async {
          await runAppWhileHandlingFlutterError(widgetTester);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          final nameTextFormFieldFinder = find.byType(TextFormField).at(0);
          final emailTextFormFieldFinder = find.byType(TextFormField).at(1);
          final passwordTextFormFieldFinder = find.byType(TextFormField).at(2);
          final confirmPasswordTextFormFieldFinder =
              find.byType(TextFormField).at(3);
          await widgetTester.enterText(nameTextFormFieldFinder, "foo");
          await widgetTester.enterText(
              emailTextFormFieldFinder, "test34@test.com");
          await widgetTester.enterText(
              passwordTextFormFieldFinder, "mhwtefnq}w4]");
          await widgetTester.enterText(
              confirmPasswordTextFormFieldFinder, "mhwtefnq}w4]");
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pump();
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          await widgetTester.pumpAndSettle(Durations.long1);
          final snackBarFinder = find.byType(SnackBar);
          final snakBarTextFinder = find.descendant(
              of: snackBarFinder,
              matching: find.text(
                  "Success: Check your email inbox to verify your email address."));
          expect(snackBarFinder, findsOneWidget);
          expect(snakBarTextFinder, findsOneWidget);
          expect(find.byType(Locked), findsOneWidget);
          var response = await http.get(Uri.parse(
              "http://10.0.2.2:9099/emulator/v1/projects/learn-gcp-380012/oobCodes"));
          var oobCodesLengthBeforeResending = 0;
          if (response.statusCode == 200) {
            Map<String, dynamic> data = jsonDecode(response.body);
            List<dynamic> oobCodes = data["oobCodes"];
            oobCodesLengthBeforeResending = oobCodes.length;
            if (response.statusCode != 200) {
              fail("problem");
            }
          } else {
            fail("problem");
          }
          final resendVerificationEmailButton =
              find.widgetWithText(ElevatedButton, "Resend verification email");
          await widgetTester.tap(resendVerificationEmailButton);
          await widgetTester.pumpAndSettle();
          response = await http.get(Uri.parse(
              "http://10.0.2.2:9099/emulator/v1/projects/learn-gcp-380012/oobCodes"));
          var oobCodesLengthAfterResending = 0;
          if (response.statusCode == 200) {
            Map<String, dynamic> data = jsonDecode(response.body);
            List<dynamic> oobCodes = data["oobCodes"];
            oobCodesLengthAfterResending = oobCodes.length;
            if (response.statusCode != 200) {
              fail("problem");
            }
          } else {
            fail("problem");
          }
          expect(
              oobCodesLengthAfterResending, oobCodesLengthBeforeResending + 1);
          await FirebaseAuth.instance.signOut();
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));

        testWidgets("""Pressing the register button while
            there some input in the input fields: success case
            then the user signed out""", (WidgetTester widgetTester) async {
          await runAppWhileHandlingFlutterError(widgetTester);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          final nameTextFormFieldFinder = find.byType(TextFormField).at(0);
          final emailTextFormFieldFinder = find.byType(TextFormField).at(1);
          final passwordTextFormFieldFinder = find.byType(TextFormField).at(2);
          final confirmPasswordTextFormFieldFinder =
              find.byType(TextFormField).at(3);
          await widgetTester.enterText(nameTextFormFieldFinder, "foo");
          await widgetTester.enterText(
              emailTextFormFieldFinder, "test35@test.com");
          await widgetTester.enterText(
              passwordTextFormFieldFinder, "mhwtefnq}w4]");
          await widgetTester.enterText(
              confirmPasswordTextFormFieldFinder, "mhwtefnq}w4]");
          await widgetTester.pumpAndSettle();
          await widgetTester.tap(registerButtonFinder);
          await widgetTester.pump();
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
          await widgetTester.pumpAndSettle(Durations.long1);
          final snackBarFinder = find.byType(SnackBar);
          final snakBarTextFinder = find.descendant(
              of: snackBarFinder,
              matching: find.text(
                  "Success: Check your email inbox to verify your email address."));
          expect(snackBarFinder, findsOneWidget);
          expect(snakBarTextFinder, findsOneWidget);
          expect(find.byType(Locked), findsOneWidget);
          final signOutButton = find.widgetWithText(ElevatedButton, "Sign out");
          await widgetTester.tap(signOutButton);
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
        }, variant: TargetPlatformVariant.only(TargetPlatform.android));
      });
    });
  });
}
