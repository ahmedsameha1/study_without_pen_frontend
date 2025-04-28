import 'dart:async';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/cubit/create_field_cubit.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/create_field_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

import '../../../common/common_finders.dart';
import '../../../common/widget_testing_helper.dart';
import 'field_page_test.dart';

void main() {
  late Widget widgetInSkeleton;
  late Widget widgetProviderLocalization;
  late nonso.AuthBloc authBloc;
  String expectedCreateFieldString = "Create Field";
  String expectedFieldNameString = "Field Name";
  String expectedSelectColorString = "Select Color";
  String expectedOkString = "Ok";
  String expectedCancelString = "Cancel";
  String expectedInvalidNameString = "Must be between 1 and 64 characters";

  setUp(() {
    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenReturn(nonso.AuthState(
      applicationAuthState: nonso.ApplicationAuthState.signedIn,
    ));
    when(() => authBloc.signOut()).thenAnswer((_) => Completer<void>().future);
    widgetInSkeleton = createWidgetInASkeletonB(CreateFieldPage());
  });

  group("Engish Locale", () {
    Locale currentLocale = const Locale("en");

    setUp(() {
      widgetProviderLocalization = Localizations(
        locale: currentLocale,
        delegates: AppLocalizations.localizationsDelegates,
        child: widgetInSkeleton,
      );
    });

    testWidgets("Test the presence of the main widgets",
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetProviderLocalization);
      await tester.tap(find.widgetWithText(TextButton, "child"));
      await tester.pumpAndSettle();
      final createFieldPageFinder = find.byType(CreateFieldPage);
      expect(createFieldPageFinder, findsOneWidget);
      expect(
          find.descendant(
              of: createFieldPageFinder,
              matching: find.byType(BlocProvider<CreateFieldCubit>)),
          findsOneWidget);
      expect(
          find.descendant(
              of: find.byType(BlocProvider<CreateFieldCubit>),
              matching: scaffoldFinder),
          findsOneWidget);
      final appBarFinder =
          find.descendant(of: scaffoldFinder, matching: find.byType(AppBar));
      expect(appBarFinder, findsOneWidget);
      AppBar appBar = tester.widget<AppBar>(appBarFinder);
      Text title = appBar.title as Text;
      expect(title.data, expectedCreateFieldString);
      expect(
          find.descendant(
              of: scaffoldFinder, matching: find.byKey(Key("center"))),
          findsOneWidget);
      Scaffold scaffold = tester.widget(scaffoldFinder);
      SafeArea safeArea = scaffold.body as SafeArea;
      Center center = safeArea.child as Center;
      Card card = tester.widget(
        find.descendant(of: find.byWidget(center), matching: cardFinder),
      );
      expect(card.margin!.horizontal, 40);
      expect(card.margin!.vertical, 40);
      expect(
          find.descendant(
              of: find.byWidget(card), matching: singleChildScrollViewFinder),
          findsOneWidget);
      Padding padding = tester.widget(
        find.descendant(
            of: singleChildScrollViewFinder,
            matching: find.byKey(const Key("paddingAroundColumn"))),
      );
      expect(padding.padding.horizontal, 32);
      expect(padding.padding.vertical, 32);
      Column column = tester.widget(
        find.descendant(of: find.byWidget(padding), matching: columnFinder),
      );
      expect(column.mainAxisAlignment, MainAxisAlignment.center);
      expect(find.descendant(of: columnFinder, matching: formFinder),
          findsOneWidget);
      Form form = tester.widget(find.byType(Form));
      final TextField fieldNameTextField = tester.widget(find.descendant(
          of: find.byWidget(form),
          matching: find.byType(TextField))) as TextField;
      expect((fieldNameTextField.decoration!.label as Text).data,
          expectedFieldNameString);
      expect(fieldNameTextField.keyboardType, TextInputType.text);
      expect(fieldNameTextField.textInputAction, TextInputAction.next);
      SizedBox sizedBoxBetweenFormAndStack =
          tester.widget(find.byKey(Key("sizedBoxBetweenFormAndStack")));
      expect(sizedBoxBetweenFormAndStack.height!, 25);
      GestureDetector gestureDetector =
          tester.widget(find.byKey(Key("gestureDetector")));
      Finder stackFinder = find.descendant(
          of: find.byWidget(gestureDetector),
          matching: find.byKey(
            Key("stackForColorIndicator"),
          ));
      Stack stack = tester.widget(stackFinder);
      expect(stack.alignment, Alignment.center);
      ColorIndicator colorIndicator =
          tester.widget(find.byKey(Key("colorIndicator")));
      expect(colorIndicator.color, Colors.white);
      expect(colorIndicator.width, double.infinity);
      Text selectColorText =
          tester.widget(find.text(expectedSelectColorString));
      expect(selectColorText.data, expectedSelectColorString);
      TextStyle selectColorTextTextStyle = selectColorText.style!;
      expect(selectColorTextTextStyle.color, Colors.black);
      expect(
          checkWidgetsOrder(
              stack.children.toList(), [colorIndicator, selectColorText]),
          isTrue);
      AnimatedSize animatedSize = tester.widget(find.byType(AnimatedSize));
      expect(animatedSize.duration, const Duration(milliseconds: 500));
      expect(
          find.descendant(
              of: find.byWidget(animatedSize),
              matching: find.byType(ColorPicker)),
          findsNothing);
      SizedBox shrinkedSizedBox = tester.widget(
        find.descendant(
            of: find.byWidget(animatedSize), matching: find.byType(SizedBox)),
      );
      expect(tester.getSize(find.byWidget(shrinkedSizedBox)).width, 0);
      expect(tester.getSize(find.byWidget(shrinkedSizedBox)).height, 0);
      SizedBox sizedBoxBetweenStackAndButtons =
          tester.widget(find.byKey(Key("sizedBoxBetweenStackAndButtons")));
      expect(sizedBoxBetweenStackAndButtons.height, 25);
      Row rowOfButtons = tester.widget(find.byType(Row));
      expect(rowOfButtons.mainAxisAlignment, MainAxisAlignment.spaceEvenly);
      ElevatedButton okButton = tester.widget(find.byKey(Key("okButton")));
      expect((okButton.child as Text).data, expectedOkString);
      ElevatedButton cancelButton =
          tester.widget(find.byKey(Key("cancelButton")));
      expect((cancelButton.child as Text).data, expectedCancelString);
      expect(
          checkWidgetsOrder(rowOfButtons.children.toList(), [
            cancelButton,
            okButton,
          ]),
          isTrue);
      await tester.tap(find.byWidget(stack));
      await tester.pumpAndSettle();
      padding = tester.widget(
        find.descendant(
            of: singleChildScrollViewFinder,
            matching: find.byKey(const Key("paddingAroundColumn"))),
      );
      column = tester.widget(
        find.descendant(
            of: find.byWidget(padding), matching: find.byKey(Key("column"))),
      );
      form = tester.widget(find.byType(Form));
      sizedBoxBetweenFormAndStack =
          tester.widget(find.byKey(Key("sizedBoxBetweenFormAndStack")));
      gestureDetector = tester.widget(find.byKey(Key("gestureDetector")));
      animatedSize = tester.widget(find.byType(AnimatedSize));
      expect(find.byWidget(shrinkedSizedBox), findsNothing);
      final colorPickerFinder = find.descendant(
          of: find.byWidget(animatedSize), matching: find.byType(ColorPicker));
      expect(colorPickerFinder, findsOneWidget);
      sizedBoxBetweenStackAndButtons =
          tester.widget(find.byKey(Key("sizedBoxBetweenStackAndButtons")));
      rowOfButtons = tester.widget(find.byType(Row));
      expect(
          checkWidgetsOrder(column.children.toList(), [
            form,
            sizedBoxBetweenFormAndStack,
            gestureDetector,
            animatedSize,
            sizedBoxBetweenStackAndButtons,
            rowOfButtons,
          ]),
          isTrue);
      ColorPicker colorPicker = tester.widget(colorPickerFinder);
      Text selectColorTextOfColorPicker = colorPicker.heading as Text;
      BuildContext context =
          tester.element(find.byWidget(selectColorTextOfColorPicker));
      expect(selectColorTextOfColorPicker.style,
          Theme.of(context).textTheme.headlineSmall);
      expect(selectColorTextOfColorPicker.data, expectedSelectColorString);
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
      selectColorText = tester.widget(find.descendant(
          of: find.byType(Stack),
          matching: find.text(expectedSelectColorString)));
      expect(selectColorText.data, expectedSelectColorString);
      selectColorTextTextStyle = selectColorText.style!;
      expect(selectColorTextTextStyle.color, Colors.white);
      gestureDetector = tester.widget(find.byKey(Key("gestureDetector")));
      stackFinder = find.descendant(
          of: find.byWidget(gestureDetector),
          matching: find.byKey(
            Key("stackForColorIndicator"),
          ));
      await tester.tap(stackFinder);
      await tester.pumpAndSettle();
      padding = tester.widget(
        find.descendant(
            of: singleChildScrollViewFinder,
            matching: find.byKey(const Key("paddingAroundColumn"))),
      );
      column = tester.widget(
        find.descendant(
            of: find.byWidget(padding), matching: find.byKey(Key("column"))),
      );
      form = tester.widget(find.byType(Form));
      sizedBoxBetweenFormAndStack =
          tester.widget(find.byKey(Key("sizedBoxBetweenFormAndStack")));
      gestureDetector = tester.widget(find.byKey(Key("gestureDetector")));
      animatedSize = tester.widget(find.byType(AnimatedSize));
      shrinkedSizedBox = tester.widget(
        find.descendant(
            of: find.byWidget(animatedSize), matching: find.byType(SizedBox)),
      );
      expect(find.byWidget(shrinkedSizedBox), findsOneWidget);
      expect(colorPickerFinder, findsNothing);
      sizedBoxBetweenStackAndButtons =
          tester.widget(find.byKey(Key("sizedBoxBetweenStackAndButtons")));
      rowOfButtons = tester.widget(find.byType(Row));
      expect(
          checkWidgetsOrder(column.children.toList(), [
            form,
            sizedBoxBetweenFormAndStack,
            gestureDetector,
            animatedSize,
            sizedBoxBetweenStackAndButtons,
            rowOfButtons,
          ]),
          isTrue);
    });

    testWidgets("name text form field validation", (WidgetTester tester) async {
      await tester.pumpWidget(widgetProviderLocalization);
      await tester.tap(find.widgetWithText(TextButton, "child"));
      await tester.pumpAndSettle();
      ElevatedButton okElevatedButton =
          tester.widget(find.widgetWithText(ElevatedButton, expectedOkString));
      final nameValidationErrorTextFinder = find.descendant(
          of: textFormFieldFinder,
          matching: find.text(expectedInvalidNameString));
      expect(nameValidationErrorTextFinder, findsNothing);
      expect(okElevatedButton.enabled, isFalse);
      await tester.enterText(
          textFormFieldFinder, "r" * (Fields.MAXIMUM_LENGTH_OF_NAME + 1));
      await tester.pumpAndSettle();
      expect(nameValidationErrorTextFinder, findsOneWidget);
      okElevatedButton =
          tester.widget(find.widgetWithText(ElevatedButton, expectedOkString));
      expect(okElevatedButton.enabled, isFalse);
      await tester.enterText(
          textFormFieldFinder, "r" * (Fields.MAXIMUM_LENGTH_OF_NAME) + " ");
      await tester.pumpAndSettle();
      expect(nameValidationErrorTextFinder, findsNothing);
      okElevatedButton =
          tester.widget(find.widgetWithText(ElevatedButton, expectedOkString));
      expect(okElevatedButton.enabled, isTrue);
      await tester.enterText(textFormFieldFinder, "field name");
      await tester.pumpAndSettle();
      expect(nameValidationErrorTextFinder, findsNothing);
      okElevatedButton =
          tester.widget(find.widgetWithText(ElevatedButton, expectedOkString));
      expect(okElevatedButton.enabled, isTrue);
      await tester.enterText(textFormFieldFinder, " ");
      await tester.pumpAndSettle();
      expect(nameValidationErrorTextFinder, findsOneWidget);
      okElevatedButton =
          tester.widget(find.widgetWithText(ElevatedButton, expectedOkString));
      expect(okElevatedButton.enabled, isFalse);
      await tester.enterText(textFormFieldFinder, "");
      await tester.pumpAndSettle();
      expect(nameValidationErrorTextFinder, findsOneWidget);
      okElevatedButton =
          tester.widget(find.widgetWithText(ElevatedButton, expectedOkString));
      expect(okElevatedButton.enabled, isFalse);
    });

    testWidgets("Test clicking the cancel button exit the create field page",
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetProviderLocalization);
      await tester.tap(find.widgetWithText(TextButton, "child"));
      await tester.pumpAndSettle();
      expect(find.byType(CreateFieldPage), findsOneWidget);
      await tester
          .tap(find.widgetWithText(ElevatedButton, expectedCancelString));
      await tester.pumpAndSettle();
      expect(find.byType(CreateFieldPage), findsNothing);
    });
  });
}
