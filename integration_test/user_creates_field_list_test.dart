import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:integration_test/integration_test.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/create_field_list_page.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/field_lists_page.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/fields_page.dart';
import 'package:study_without_pen_by_flutter/firebase_options.dart';

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

  tearDown(() async => await FirebaseAuth.instance.signOut());

  tearDownAll(() async {
    final response = await http.delete(Uri.parse(
        "http://10.0.2.2:9099/emulator/v1/projects/learn-gcp-380012/accounts"));
    if (response.statusCode != 200) {
      fail("problem");
    }
  });

  group("Android", () {
    group("English", () {
      final signInButtonFinder = find.widgetWithText(ElevatedButton, "Sign in");

      testWidgets("""Signin in then the FieldsPage opens then press the 
            floating action button then the CreateFieldPage opens
            then enter field name in the textfield
            then click the color indicator then pick a color and the
            color of the color indicator changes to the picked color
            then click on the ok button show a snack bar with creation
            message then go back to FieldsPage
            """, (WidgetTester tester) async {
        String expectedOkString = "Ok";
        await runAppWhileHandlingFlutterError(tester);
        await tester.pumpAndSettle();
        await tester.tap(signInButtonFinder);
        await tester.pumpAndSettle();
        final emailTextFormFieldFinder = find.byType(TextFormField).at(0);
        final passwordTextFormFieldFinder = find.byType(TextFormField).at(1);
        await tester.enterText(emailTextFormFieldFinder, validEmail);
        await tester.enterText(passwordTextFormFieldFinder, "gweruigwiba");
        await tester.pumpAndSettle();
        await tester.tap(signInButtonFinder);
        await tester.pump();
        await tester.pumpAndSettle();
        await tester.pumpAndSettle();
        expect(find.byType(FieldsPage), findsOneWidget);
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        await tester.enterText(textFormFieldFinder, 'field name');
        await tester.tap(find.widgetWithText(Stack, "Select Color"));
        await tester.pumpAndSettle();
        ColorWheelPicker colorWheelPicker =
            tester.widget(find.byType(ColorWheelPicker));
        final Offset colorWheelPickerCenter =
            tester.getCenter(find.byWidget(colorWheelPicker));
        await tester.timedDragFrom(
            colorWheelPickerCenter, const Offset(50, 20), Durations.short1);
        await tester.pumpAndSettle();
        await tester.ensureVisible(
            find.widgetWithText(ElevatedButton, expectedOkString));
        await tester.tap(find.widgetWithText(ElevatedButton, expectedOkString));
        await tester.pump();
        await tester.pumpAndSettle();
        Card aCard = tester.widget<Card>(find.descendant(
            of: find.byType(MasonryGridView), matching: find.byType(Card)));
        expect(
            find.descendant(
                of: find.byWidget(aCard), matching: find.text("field name")),
            findsOne);
        await tester.tap(find.byWidget(aCard));
        await tester.pump();
        await tester.pumpAndSettle();
        expect(find.byType(FieldListsPage), findsOne);
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        expect(find.byType(CreateFieldListPage), findsOne);
      }, variant: TargetPlatformVariant.only(TargetPlatform.android));
    });
  });
}
