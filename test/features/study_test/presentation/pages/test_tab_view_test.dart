import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/common/theme.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/pages/test_tab_view.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../common/common_finders.dart';
import '../../../common/widget_testing_helper.dart';

void main() {
  group('English locale', () {
    Locale currentLocale = const Locale('en');
    String expectedEnterYourAnswerString = 'Enter your answer';
    String expectedCheckString = 'Check';
    const count = 23;
    EntryEntity entry = EntryEntity(
      fieldListId: const Uuid().v4(),
      answer: 'answer',
      question: 'question',
      creationAt: DateTime(2025),
      lastModificationAt: DateTime(2025),
    );
    testWidgets('Test the precense of the main widgets', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [AppLocalizations.delegate],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          theme: AppTheme.theme,
          home: Scaffold(
            body: TestTabView(entry: entry, count: count),
          ),
        ),
      );
      Scrollbar scrollbar = tester.widget(
        find.descendant(
          of: find.byType(TestTabView),
          matching: find.descendant(
            of: centerFinder,
            matching: find.byType(Scrollbar),
          ),
        ),
      );
      expect(scrollbar.interactive, true);
      expect(scrollbar.thumbVisibility, true);
      expect(scrollbar.thickness, 15);
      Padding padding = tester.widget(
        find.descendant(
          of: find.byWidget(scrollbar),
          matching: find.byKey(Key('tabPadding')),
        ),
      );
      expect(padding.padding.horizontal, 60);
      expect(padding.padding.vertical, 30);
      Column column = tester.widget(
        find.descendant(
          of: find.byWidget(padding),
          matching: find.descendant(
            of: singleChildScrollViewFinder,
            matching: columnFinder,
          ),
        ),
      );
      SizedBox questionSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(column),
          matching: find.byKey(const Key('questionSizedBox')),
        ),
      );
      expect(questionSizedBox.height, 200);
      expect(questionSizedBox.width, double.infinity);
      DecoratedBox questionDecoratedBox = tester.widget(
        find.descendant(
          of: find.byWidget(questionSizedBox),
          matching: find.byType(DecoratedBox),
        ),
      );
      const OutlineInputBorder outlineInputBorder = OutlineInputBorder();
      expect(
        questionDecoratedBox.decoration,
        BoxDecoration(
          border: Border.all(
            color: outlineInputBorder.borderSide.color,
            width: outlineInputBorder.borderSide.width,
          ),
          borderRadius: outlineInputBorder.borderRadius,
        ),
      );
      SingleChildScrollView questionSingleChildScrollView = tester.widget(
        find.descendant(
          of: find.byWidget(questionDecoratedBox),
          matching: singleChildScrollViewFinder,
        ),
      );
      expect(questionSingleChildScrollView.padding!.horizontal, 20);
      expect(questionSingleChildScrollView.padding!.vertical, 20);
      ConstrainedBox questionConstrainedBox = tester.widget(
        find.descendant(
          of: find.byWidget(questionSingleChildScrollView),
          matching: find.byType(ConstrainedBox),
        ),
      );
      expect(questionConstrainedBox.constraints.minHeight, 180);
      Text questionText = tester.widget(
        find.descendant(
          of: find.byWidget(questionConstrainedBox),
          matching: find.descendant(
            of: centerFinder,
            matching: find.byType(Text),
          ),
        ),
      );
      expect(questionText.data, entry.question);
      expect(
        questionText.style,
        Theme.of(
          tester.element(find.byWidget(questionText)),
        ).textTheme.bodyLarge,
      );
      expect(questionText.textAlign, TextAlign.center);
      SizedBox questionUserAnswerSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(column),
          matching: find.byKey(const Key('questionUserAnswerSizedBox')),
        ),
      );
      expect(questionUserAnswerSizedBox.height, 20);
      SizedBox userAnswerSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(column),
          matching: find.byKey(const Key('userAnswerSizedBox')),
        ),
      );
      expect(userAnswerSizedBox.height, 200);
      TextFormField userAnswerTextFormField = tester.widget(
        find.descendant(
          of: find.byWidget(userAnswerSizedBox),
          matching: find.byType(TextFormField),
        ),
      );
      TextField userAnswerTextField = tester.widget(
        find.descendant(
          of: find.byWidget(userAnswerTextFormField),
          matching: find.byType(TextField),
        ),
      );
      expect(
        userAnswerTextField.style,
        Theme.of(
          tester.element(find.byWidget(userAnswerTextField)),
        ).textTheme.bodyLarge,
      );
      expect(userAnswerTextField.expands, true);
      expect(userAnswerTextField.maxLines, isNull);
      expect(userAnswerTextField.textAlign, TextAlign.center);
      expect(userAnswerTextField.keyboardType, TextInputType.multiline);
      expect(userAnswerTextField.autofocus, true);
      expect(userAnswerTextField.autocorrect, false);
      expect(userAnswerTextField.enableSuggestions, false);
      expect(userAnswerTextField.textInputAction, TextInputAction.newline);
      InputDecoration inputDecoration = userAnswerTextField.decoration!;
      expect(inputDecoration.hintText, expectedEnterYourAnswerString);
      expect(inputDecoration.filled, true);
      expect(inputDecoration.border, OutlineInputBorder(gapPadding: 0));
      expect(
        inputDecoration.contentPadding,
        const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
      );
      SizedBox userAnswerCheckButtonSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(column),
          matching: find.byKey(const Key('userAnswerCheckButtonSizedBox')),
        ),
      );
      expect(userAnswerCheckButtonSizedBox.height, 20);
      FilledButton checkButton = tester.widget(
        find.descendant(
          of: find.byWidget(column),
          matching: find.byType(FilledButton),
        ),
      );
      Row innerRow = tester.widget(
        find.descendant(
          of: find.byWidget(checkButton),
          matching: find.descendant(
            of: rowFinder,
            matching: find.descendant(of: expandedFinder, matching: rowFinder),
          ),
        ),
      );
      expect(innerRow.mainAxisAlignment, MainAxisAlignment.center);
      expect(innerRow.children.length, 1);
      expect((innerRow.children[0] as Text).data, expectedCheckString);
      expect(
        find.descendant(
          of: find.byWidget(checkButton),
          matching: find.descendant(
            of: rowFinder,
            matching: find.text('$count'),
          ),
        ),
        findsOne,
      );
      checkWidgetsOrder(column.children, [
        questionSizedBox,
        questionUserAnswerSizedBox,
        userAnswerSizedBox,
        userAnswerCheckButtonSizedBox,
        checkButton,
      ]);
    });
  });
}
