import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/common/widgets/pick_color.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

import '../../features/common/common_finders.dart';
import '../../features/common/widget_testing_helper.dart';

class CallBack extends Mock {
  void call(Color color);
}

void main() {
  group('English locale', () {
    String expectedSelectColorString = "Select Color";
    int color = Colors.white.toARGB32();
    testWidgets('Test the precense of the main widgets', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [AppLocalizations.delegate],
          supportedLocales: AppLocalizations.supportedLocales,
          home: PickColor(color: color, callback: (_) {}),
        ),
      );
      expect(find.byType(PickColor), findsOne);
      expect(
        find.descendant(of: find.byType(PickColor), matching: columnFinder),
        findsOne,
      );
      GestureDetector gestureDetector = tester.widget(
        find.descendant(
          of: columnFinder,
          matching: find.byKey(Key("gestureDetector")),
        ),
      );
      Finder stackFinder = find.descendant(
        of: find.byWidget(gestureDetector),
        matching: find.byKey(Key("stackForColorIndicator")),
      );
      Stack stack = tester.widget(stackFinder);
      expect(stack.alignment, Alignment.center);
      ColorIndicator colorIndicator = tester.widget(
        find.byKey(Key("colorIndicator")),
      );
      expect(colorIndicator.color, Colors.white);
      expect(colorIndicator.width, double.infinity);
      Text selectColorText = tester.widget(
        find.text(expectedSelectColorString),
      );
      expect(selectColorText.data, expectedSelectColorString);
      TextStyle selectColorTextTextStyle = selectColorText.style!;
      expect(selectColorTextTextStyle.color, Colors.black);
      expect(
        checkWidgetsOrder(stack.children.toList(), [
          colorIndicator,
          selectColorText,
        ]),
        isTrue,
      );
      AnimatedSize animatedSize = tester.widget(find.byType(AnimatedSize));
      expect(animatedSize.duration, const Duration(milliseconds: 500));
      expect(
        find.descendant(
          of: find.byWidget(animatedSize),
          matching: find.byType(ColorPicker),
        ),
        findsNothing,
      );
      SizedBox shrinkedSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(animatedSize),
          matching: find.byKey(const Key('shrinkedSizedBox')),
        ),
      );
      expect(tester.getSize(find.byWidget(shrinkedSizedBox)).width, 0);
      expect(tester.getSize(find.byWidget(shrinkedSizedBox)).height, 0);
    });

    testWidgets('Clicking the select color stack show/hide the ColorPicker', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [AppLocalizations.delegate],
          supportedLocales: AppLocalizations.supportedLocales,
          home: PickColor(color: color, callback: (_) {}),
        ),
      );
      await tester.tap(find.byKey(Key("stackForColorIndicator")));
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byType(AnimatedSize),
          matching: find.byType(ColorPicker),
        ),
        findsOne,
      );
      expect(
        find.descendant(
          of: find.byType(AnimatedSize),
          matching: find.byKey(const Key('shrinkedSizedBox')),
        ),
        findsNothing,
      );
      await tester.tap(find.byKey(Key("stackForColorIndicator")));
      await tester.pumpAndSettle();
      expect(
        find.descendant(
          of: find.byType(AnimatedSize),
          matching: find.byType(ColorPicker),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byType(AnimatedSize),
          matching: find.byKey(const Key('shrinkedSizedBox')),
        ),
        findsOne,
      );
    });

    testWidgets('selecting a color', (WidgetTester tester) async {
      final CallBack callBack = CallBack();
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: [AppLocalizations.delegate],
          supportedLocales: AppLocalizations.supportedLocales,
          home: PickColor(color: color, callback: callBack.call),
        ),
      );
      await tester.tap(find.byKey(Key("stackForColorIndicator")));
      await tester.pumpAndSettle();
      ColorPicker colorPicker = tester.widget(
        find.descendant(
          of: find.byType(AnimatedSize),
          matching: find.byType(ColorPicker),
        ),
      );
      Text selectColorTextOfColorPicker = colorPicker.heading as Text;
      BuildContext context = tester.element(
        find.byWidget(selectColorTextOfColorPicker),
      );
      expect(
        selectColorTextOfColorPicker.style,
        Theme.of(context).textTheme.headlineSmall,
      );
      expect(selectColorTextOfColorPicker.data, expectedSelectColorString);
      ColorWheelPicker colorWheelPicker = tester.widget(
        find.byType(ColorWheelPicker),
      );
      expect(colorWheelPicker.color, Colors.white);
      final Offset colorWheelPickerCenter = tester.getCenter(
        find.byWidget(colorWheelPicker),
      );
      await tester.timedDragFrom(
        colorWheelPickerCenter,
        const Offset(50, 20),
        Durations.short1,
      );
      await tester.pumpAndSettle();
      ColorIndicator colorIndicator = tester.widget(
        find.byKey(Key("colorIndicator")),
      );
      colorIndicator = tester.widget(find.byKey(Key("colorIndicator")));
      expect(colorIndicator.color, const Color(0xff520404));
      Text selectColorText = tester.widget(
        find.descendant(
          of: find.byType(Stack),
          matching: find.text(expectedSelectColorString),
        ),
      );
      TextStyle selectColorTextTextStyle = selectColorText.style!;
      selectColorTextTextStyle = selectColorText.style!;
      expect(selectColorTextTextStyle.color, Colors.white);
      verify(() => callBack.call(const Color(0xff520404))).called(1);
    });
  });
}
