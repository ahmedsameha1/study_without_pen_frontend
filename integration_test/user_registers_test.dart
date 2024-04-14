import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:nonso/nonso.dart';
import 'package:study_without_pen_by_flutter/common/widget/app_widget.dart';
import 'package:study_without_pen_by_flutter/firebase_options.dart';
import 'package:http/http.dart' as http;

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  });

  group("User registers his account", () {
    tearDownAll(() async {
      await http.delete(Uri.parse(
          "http://10.0.2.2:9099/emulator/v1/projects/com-ahmedsameha1-peninbin/accounts"));
    });
    group("Android", () {
      group("English", () {
        testWidgets(
            "Entering invalid name in the name TextFormField on the Register widget",
            (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(App(FirebaseAuth.instance));
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          final registerButton = find.byType(ElevatedButton).at(0);
          await widgetTester.tap(registerButton);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          final nameTextFormFieldFinder = find.byType(TextFormField).at(0);
          final invalidNameTextFinder = find.descendant(
              of: nameTextFormFieldFinder,
              matching: find.text("Enter your name"));
          await widgetTester.enterText(nameTextFormFieldFinder, "");
          final aTextFormFieldFinder = find.byType(TextFormField).at(1);
          await widgetTester.tap(aTextFormFieldFinder);
          await widgetTester.pumpAndSettle();
          expect(invalidNameTextFinder, findsOneWidget);
        });

        testWidgets(
            "Entering invalid email in the email TextFormField on the Register widget",
            (WidgetTester widgetTester) async {
          await widgetTester.pumpWidget(App(FirebaseAuth.instance));
          await widgetTester.pumpAndSettle();
          expect(find.byType(AuthOptions), findsOneWidget);
          final registerButton = find.byType(ElevatedButton).at(0);
          await widgetTester.tap(registerButton);
          await widgetTester.pumpAndSettle();
          expect(find.byType(Register), findsOneWidget);
          final emailTextFormFieldFinder = find.byType(TextFormField).at(1);
          final invalidEmailTextFinder = find.descendant(
              of: emailTextFormFieldFinder,
              matching: find.text("This an invalid email"));
          await widgetTester.enterText(emailTextFormFieldFinder, "f");
          final aTextFormFieldFinder = find.byType(TextFormField).at(0);
          await widgetTester.tap(aTextFormFieldFinder);
          await widgetTester.pumpAndSettle();
          expect(invalidEmailTextFinder, findsOneWidget);
        });
      });
    });
  });
}
