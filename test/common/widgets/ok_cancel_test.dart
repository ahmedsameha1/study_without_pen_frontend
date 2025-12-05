import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/common/widgets/ok_cancel.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

import '../../features/common/widget_testing_helper.dart';

class CallBack extends Mock {
  void call();
}

void main() {
  group('English locale', () {
    String expectedOkString = "Ok";
    String expectedCancelString = "Cancel";
    CallBack okCallback = CallBack();
    CallBack cancelCallback = CallBack();
    testWidgets('Test the precense of the main widgets',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: OkCancel(
            valid: false,
            usecaseValidationTest: false,
            okCallback: okCallback.call,
            cancelCallback: cancelCallback.call),
      ));
      Row row = tester.widget(
        find.descendant(of: find.byType(OkCancel), matching: find.byType(Row)),
      );
      expect(row.mainAxisAlignment, MainAxisAlignment.spaceEvenly);
      ElevatedButton okButton = tester.widget(find.byKey(Key("okButton")));
      expect((okButton.child as Text).data, expectedOkString);
      ElevatedButton cancelButton =
          tester.widget(find.byKey(Key("cancelButton")));
      expect((cancelButton.child as Text).data, expectedCancelString);
      expect(
          checkWidgetsOrder(row.children.toList(), [
            cancelButton,
            okButton,
          ]),
          isTrue);
    });

    testWidgets(
        'Clicking ok button calls its callback when valid is true and usecaseValidationTest is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: OkCancel(
            valid: true,
            usecaseValidationTest: true,
            okCallback: okCallback.call,
            cancelCallback: cancelCallback.call),
      ));
      await tester.tap(find.byKey(const Key('okButton')));
      verify(() => okCallback.call()).called(1);
    });

    testWidgets(
        'Clicking ok button calls its callback when valid is true and usecaseValidationTest is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: OkCancel(
            valid: true,
            usecaseValidationTest: false,
            okCallback: okCallback.call,
            cancelCallback: cancelCallback.call),
      ));
      await tester.tap(find.byKey(const Key('okButton')));
      verify(() => okCallback.call()).called(1);
    });

    testWidgets(
        'Clicking ok button calls its callback when valid is false and usecaseValidationTest is true',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: OkCancel(
            valid: false,
            usecaseValidationTest: true,
            okCallback: okCallback.call,
            cancelCallback: cancelCallback.call),
      ));
      await tester.tap(find.byKey(const Key('okButton')));
      verify(() => okCallback.call()).called(1);
    });

    testWidgets(
        'Clicking ok button does NOT call its callback when valid is false and usecaseValidationTest is false',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: OkCancel(
            valid: false,
            usecaseValidationTest: false,
            okCallback: okCallback.call,
            cancelCallback: cancelCallback.call),
      ));
      await tester.tap(find.byKey(const Key('okButton')));
      verifyNever(() => okCallback.call());
    });

    testWidgets('Clicking cancel button calls its callback',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: OkCancel(
            valid: false,
            usecaseValidationTest: false,
            okCallback: okCallback.call,
            cancelCallback: cancelCallback.call),
      ));
      await tester.tap(find.byKey(const Key('cancelButton')));
      verify(() => cancelCallback.call()).called(1);
    });
  });
}
