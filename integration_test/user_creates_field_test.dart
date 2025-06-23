import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nonso/nonso.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/create_field_page.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/field_page.dart';
import 'package:study_without_pen_by_flutter/firebase_options.dart';
import 'package:http/http.dart' as http;

import '../test/features/common/common_finders.dart';
import '../test/features/common/widget_testing_helper.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  var validEmail = "test-sign-in@test.com";

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
          "email": validEmail,
          "password": "gweruigwiba",
          "returnSecureToken": true
        }));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      final response1 = await http.post(
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
      final response2 = await http.post(
          Uri.parse(
              "http://10.0.2.2:9099/identitytoolkit.googleapis.com/v1/accounts:update?key=${DefaultFirebaseOptions.currentPlatform.apiKey}"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Charset': 'utf-8'
          },
          body: jsonEncode(<String, dynamic>{
            "idToken": data["idToken"],
            "displayName": "John Doe",
            "returnSecureToken": true,
          }));
      if (response1.statusCode == 200 && response2.statusCode == 200) {
        response = await http.get(Uri.parse(
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
      } else {
        fail("problem");
      }
    } else {
      fail("problem");
    }
  });

  tearDownAll(() async {
    final response = await http.delete(Uri.parse(
        "http://10.0.2.2:9099/emulator/v1/projects/learn-gcp-380012/accounts"));
    if (response.statusCode != 200) {
      fail("problem");
    }
    await FirebaseAuth.instance.signOut();
  });

  group("Android", () {
    group("English", () {
      final signInButtonFinder = find.widgetWithText(ElevatedButton, "Sign in");

      testWidgets("""Signin in then the FieldPage opens then press the 
            floating action button then the CreateFieldPage opens
            then click the system back button the FieldPage return back
            """, (WidgetTester tester) async {
        await runAppWhileHandlingFlutterError(tester);
        await tester.pumpAndSettle();
        expect(find.byType(AuthOptions), findsOneWidget);
        await tester.tap(signInButtonFinder);
        await tester.pumpAndSettle();
        expect(find.byType(Password), findsOneWidget);
        final emailTextFormFieldFinder = find.byType(TextFormField).at(0);
        final passwordTextFormFieldFinder = find.byType(TextFormField).at(1);
        await tester.enterText(emailTextFormFieldFinder, validEmail);
        await tester.enterText(passwordTextFormFieldFinder, "gweruigwiba");
        await tester.pumpAndSettle();
        await tester.tap(signInButtonFinder);
        await tester.pumpAndSettle();
        expect(find.byType(FieldPage), findsOneWidget);
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        expect(find.byType(CreateFieldPage), findsOneWidget);
        NavigatorState navigatorState = tester.state(find.byType(Navigator));
        navigatorState.pop();
        await tester.pumpAndSettle();
        expect(find.byType(CreateFieldPage), findsNothing);
        expect(find.byType(FieldPage), findsOneWidget);
        await FirebaseAuth.instance.signOut();
      }, variant: TargetPlatformVariant.only(TargetPlatform.android));

      testWidgets("""Signin in then the FieldPage opens then press the 
            floating action button then the CreateFieldPage opens
            then click the cancel button the FieldPage return back
            """, (WidgetTester tester) async {
        await runAppWhileHandlingFlutterError(tester);
        await tester.pumpAndSettle();
        expect(find.byType(AuthOptions), findsOneWidget);
        await tester.tap(signInButtonFinder);
        await tester.pumpAndSettle();
        expect(find.byType(Password), findsOneWidget);
        final emailTextFormFieldFinder = find.byType(TextFormField).at(0);
        final passwordTextFormFieldFinder = find.byType(TextFormField).at(1);
        await tester.enterText(emailTextFormFieldFinder, validEmail);
        await tester.enterText(passwordTextFormFieldFinder, "gweruigwiba");
        await tester.pumpAndSettle();
        await tester.tap(signInButtonFinder);
        await tester.pumpAndSettle();
        expect(find.byType(FieldPage), findsOneWidget);
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        expect(find.byType(CreateFieldPage), findsOneWidget);
        await tester.tap(find.widgetWithText(ElevatedButton, "Cancel"));
        await tester.pumpAndSettle();
        expect(find.byType(CreateFieldPage), findsNothing);
        expect(find.byType(FieldPage), findsOneWidget);
        await FirebaseAuth.instance.signOut();
      }, variant: TargetPlatformVariant.only(TargetPlatform.android));

      testWidgets("""Signin in then the FieldPage opens then press the 
            floating action button then the CreateFieldPage opens
            test the validation of the name TextFormField
            """, (WidgetTester tester) async {
        String expectedInvalidNameString =
            "Field name must be between 1 and 64 characters";
        String expectedOkString = "Ok";
        await runAppWhileHandlingFlutterError(tester);
        await tester.pumpAndSettle();
        expect(find.byType(AuthOptions), findsOneWidget);
        await tester.tap(signInButtonFinder);
        await tester.pumpAndSettle();
        expect(find.byType(Password), findsOneWidget);
        final emailTextFormFieldFinder = find.byType(TextFormField).at(0);
        final passwordTextFormFieldFinder = find.byType(TextFormField).at(1);
        await tester.enterText(emailTextFormFieldFinder, validEmail);
        await tester.enterText(passwordTextFormFieldFinder, "gweruigwiba");
        await tester.pumpAndSettle();
        await tester.tap(signInButtonFinder);
        await tester.pumpAndSettle();
        expect(find.byType(FieldPage), findsOneWidget);
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        expect(find.byType(CreateFieldPage), findsOneWidget);
        ElevatedButton okElevatedButton = tester
            .widget(find.widgetWithText(ElevatedButton, expectedOkString));
        final nameValidationErrorTextFinder = find.descendant(
            of: textFormFieldFinder,
            matching: find.text(expectedInvalidNameString));
        expect(nameValidationErrorTextFinder, findsNothing);
        expect(okElevatedButton.enabled, isFalse);
        await tester.enterText(
            textFormFieldFinder, "r" * (Fields.MAXIMUM_LENGTH_OF_NAME + 1));
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsOneWidget);
        okElevatedButton = tester
            .widget(find.widgetWithText(ElevatedButton, expectedOkString));
        expect(okElevatedButton.enabled, isFalse);
        await tester.enterText(
            textFormFieldFinder, "r" * (Fields.MAXIMUM_LENGTH_OF_NAME) + " ");
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsNothing);
        okElevatedButton = tester
            .widget(find.widgetWithText(ElevatedButton, expectedOkString));
        expect(okElevatedButton.enabled, isTrue);
        await tester.enterText(textFormFieldFinder, "field name");
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsNothing);
        okElevatedButton = tester
            .widget(find.widgetWithText(ElevatedButton, expectedOkString));
        expect(okElevatedButton.enabled, isTrue);
        await tester.enterText(textFormFieldFinder, " ");
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsOneWidget);
        okElevatedButton = tester
            .widget(find.widgetWithText(ElevatedButton, expectedOkString));
        expect(okElevatedButton.enabled, isFalse);
        await tester.enterText(textFormFieldFinder, "");
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsOneWidget);
        okElevatedButton = tester
            .widget(find.widgetWithText(ElevatedButton, expectedOkString));
        expect(okElevatedButton.enabled, isFalse);
        await FirebaseAuth.instance.signOut();
      }, variant: TargetPlatformVariant.only(TargetPlatform.android));

      testWidgets("""Signin in then the FieldPage opens then press the 
            floating action button then the CreateFieldPage opens
            then enter field name in the textfield
            then click the color indicator then pick a color and the
            color of the color indicator changes to the picked color
            then click on the ok button show a snack bar with creation
            message then go back to FieldPage
            """, (WidgetTester tester) async {
        String expectedOkString = "Ok";
        await runAppWhileHandlingFlutterError(tester);
        await tester.pumpAndSettle();
        expect(find.byType(AuthOptions), findsOneWidget);
        await tester.tap(signInButtonFinder);
        await tester.pumpAndSettle();
        expect(find.byType(Password), findsOneWidget);
        final emailTextFormFieldFinder = find.byType(TextFormField).at(0);
        final passwordTextFormFieldFinder = find.byType(TextFormField).at(1);
        await tester.enterText(emailTextFormFieldFinder, validEmail);
        await tester.enterText(passwordTextFormFieldFinder, "gweruigwiba");
        await tester.pumpAndSettle();
        await tester.tap(signInButtonFinder);
        await tester.pump();
        expect(
            find.descendant(
                of: centerFinder, matching: circularProgressIndicatorFinder),
            findsOne);
        await tester.pumpAndSettle();
        expect(find.byType(SnackBar), findsOne);
        SnackBar snackBar = tester.widget(snackBarFinder);
        expect((snackBar.content as Text).data, 'Welcome John Doe!');
        await tester.pumpAndSettle();
        expect(find.byType(FieldPage), findsOneWidget);
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        expect(find.byType(CreateFieldPage), findsOneWidget);
        await tester.enterText(textFormFieldFinder, 'field name');
        ColorIndicator colorIndicator =
            tester.widget(find.byType(ColorIndicator));
        expect(colorIndicator.color, Colors.white);
        await tester.tap(find.widgetWithText(Stack, "Select Color"));
        await tester.pumpAndSettle();
        ColorWheelPicker colorWheelPicker =
            tester.widget(find.byType(ColorWheelPicker));
        expect(colorWheelPicker.color, Colors.white);
        final Offset colorWheelPickerCenter =
            tester.getCenter(find.byWidget(colorWheelPicker));
        await tester.timedDragFrom(
            colorWheelPickerCenter, const Offset(50, 20), Durations.short1);
        await tester.pumpAndSettle();
        colorIndicator = tester.widget(find.byKey(Key("colorIndicator")));
        expect(colorIndicator.color, const Color(0xff520404));
        await tester.ensureVisible(
            find.widgetWithText(ElevatedButton, expectedOkString));
        await tester.tap(find.widgetWithText(ElevatedButton, expectedOkString));
        await tester.pump();
        expect(
            find.descendant(
                of: centerFinder, matching: circularProgressIndicatorFinder),
            findsOne);
        await tester.pumpAndSettle();
        expect(find.byType(SnackBar), findsOne);
        snackBar = tester.widget(snackBarFinder);
        expect((snackBar.content as Text).data, 'Created');
        expect(find.byType(CreateFieldPage), findsNothing);
        expect(find.byType(FieldPage), findsOne);
        expect(
            find.descendant(
                of: find.byType(FieldPage),
                matching: find.byType(MasonryGridView)),
            findsOne);
        Card aCard = tester.widget<Card>(find.descendant(
            of: find.byType(MasonryGridView), matching: find.byType(Card)));
        expect(aCard.color, Color(0xff520404));
        expect(
            find.descendant(
                of: find.byWidget(aCard), matching: find.text("field name")),
            findsOne);
        await FirebaseAuth.instance.signOut();
      }, variant: TargetPlatformVariant.only(TargetPlatform.android));

      testWidgets("""Signin in then the FieldPage opens then press the 
            floating action button then the CreateFieldPage opens
            then enter field name in the textfield
            then click the color indicator then pick a color and the
            color of the color indicator changes to the picked color
            then click on the ok button show a snack bar with creation
            message then go again to the CreateFieldPage again
            then the same field name then click on the ok button
            and a snack bar should show with error and stay
            in the CreateFieldPage
            """, (WidgetTester tester) async {
        String fieldName = 'field name2';
        String expectedOkString = "Ok";
        await runAppWhileHandlingFlutterError(tester);
        await tester.pumpAndSettle();
        expect(find.byType(AuthOptions), findsOneWidget);
        await tester.tap(signInButtonFinder);
        await tester.pumpAndSettle();
        expect(find.byType(Password), findsOneWidget);
        final emailTextFormFieldFinder = find.byType(TextFormField).at(0);
        final passwordTextFormFieldFinder = find.byType(TextFormField).at(1);
        await tester.enterText(emailTextFormFieldFinder, validEmail);
        await tester.enterText(passwordTextFormFieldFinder, "gweruigwiba");
        await tester.pumpAndSettle();
        await tester.tap(signInButtonFinder);
        await tester.pump();
        expect(
            find.descendant(
                of: centerFinder, matching: circularProgressIndicatorFinder),
            findsOne);
        await tester.pumpAndSettle();
        expect(find.byType(SnackBar), findsOne);
        SnackBar snackBar = tester.widget(snackBarFinder);
        expect((snackBar.content as Text).data, 'Welcome John Doe!');
        await tester.pumpAndSettle();
        expect(find.byType(FieldPage), findsOneWidget);
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        expect(find.byType(CreateFieldPage), findsOneWidget);
        await tester.enterText(textFormFieldFinder, fieldName);
        ColorIndicator colorIndicator =
            tester.widget(find.byType(ColorIndicator));
        expect(colorIndicator.color, Colors.white);
        await tester.tap(find.widgetWithText(Stack, "Select Color"));
        await tester.pumpAndSettle();
        ColorWheelPicker colorWheelPicker =
            tester.widget(find.byType(ColorWheelPicker));
        expect(colorWheelPicker.color, Colors.white);
        final Offset colorWheelPickerCenter =
            tester.getCenter(find.byWidget(colorWheelPicker));
        await tester.timedDragFrom(
            colorWheelPickerCenter, const Offset(50, 20), Durations.short1);
        await tester.pumpAndSettle();
        colorIndicator = tester.widget(find.byKey(Key("colorIndicator")));
        expect(colorIndicator.color, const Color(0xff520404));
        await tester.ensureVisible(
            find.widgetWithText(ElevatedButton, expectedOkString));
        await tester.tap(find.widgetWithText(ElevatedButton, expectedOkString));
        await tester.pump();
        expect(
            find.descendant(
                of: centerFinder, matching: circularProgressIndicatorFinder),
            findsOne);
        await tester.pumpAndSettle();
        expect(find.byType(SnackBar), findsOne);
        snackBar = tester.widget(snackBarFinder);
        expect((snackBar.content as Text).data, 'Created');
        expect(find.byType(CreateFieldPage), findsNothing);
        expect(find.byType(FieldPage), findsOne);
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        expect(find.byType(CreateFieldPage), findsOneWidget);
        await tester.enterText(textFormFieldFinder, fieldName);
        await tester.ensureVisible(
            find.widgetWithText(ElevatedButton, expectedOkString));
        await tester.tap(find.widgetWithText(ElevatedButton, expectedOkString));
        await tester.pump();
        tester.runAsync(() async {
          await Future.delayed(Durations.short1);
          expect(
              find.descendant(
                  of: centerFinder, matching: circularProgressIndicatorFinder),
              findsOne);
          await tester.pumpAndSettle();
          expect(find.byType(SnackBar), findsOne);
          snackBar = tester.widget(snackBarFinder);
          expect((snackBar.content as Text).data, 'Error while creation');
          expect(find.byType(CreateFieldPage), findsOne);
        });
        await FirebaseAuth.instance.signOut();
      }, variant: TargetPlatformVariant.only(TargetPlatform.android));
    });
  });
}
