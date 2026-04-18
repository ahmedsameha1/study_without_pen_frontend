import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/common/theme.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_bloc.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_event.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_state.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/pages/test_tab_view.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../common/common_finders.dart';
import '../../../common/widget_testing_helper.dart';

class MockStudyTestBloc extends Mock implements StudyTestBloc {}

Widget _createInASkeleton(
  Locale currentLocale,
  StudyTestBloc studyTestBloc,
  List<EntryEntity> entries,
  int count,
) => MaterialApp(
  localizationsDelegates: const [AppLocalizations.delegate],
  supportedLocales: AppLocalizations.supportedLocales,
  locale: currentLocale,
  theme: AppTheme.theme,
  home: Scaffold(
    body: BlocProvider.value(
      value: studyTestBloc,
      child: Builder(
        builder: (context) {
          return TestTabView(entry: entries[1], count: count);
        },
      ),
    ),
  ),
);

void main() {
  group('English locale', () {
    Locale currentLocale = const Locale('en');
    String expectedEnterYourAnswerString = 'Enter your answer';
    String expectedCheckString = 'Check';
    DateTime creationAt = DateTime(2024);
    FieldListEntity fieldListEntity = FieldListEntity(
      id: const Uuid().v4(),
      fieldId: const Uuid().v4(),
      name: 'name',
      creationAt: creationAt,
      lastModificationAt: creationAt,
    );

    List<EntryEntity> entries = [
      EntryEntity(
        id: const Uuid().v4(),
        fieldListId: const Uuid().v4(),
        answer: 'answer1',
        question: 'question1',
        creationAt: DateTime(2025).subtract(const Duration(days: 4)),
        lastModificationAt: DateTime(2025).subtract(const Duration(days: 3)),
      ),
      EntryEntity(
        fieldListId: const Uuid().v4(),
        answer: 'answer',
        question: 'question',
        creationAt: DateTime(2025),
        lastModificationAt: DateTime(2025),
      ),
      EntryEntity(
        id: const Uuid().v4(),
        fieldListId: const Uuid().v4(),
        answer: 'answer3',
        question: 'question3',
        creationAt: DateTime(2025).subtract(const Duration(days: 6)),
        lastModificationAt: DateTime(2025).subtract(const Duration(days: 5)),
      ),
    ];
    const count = 23;
    late StudyTestBloc studyTestBloc;
    setUp(() {
      studyTestBloc = MockStudyTestBloc();
    });
    testWidgets('Test the precense of the main widgets', (
      WidgetTester tester,
    ) async {
      whenListen<StudyTestState>(
        studyTestBloc,
        Stream.fromIterable([]),
        initialState: StudyTestState(
          fieldList: fieldListEntity,
          entries: entries,
          currentEntryIndex: 1,
          counts: [(12, 45, 0), (3, 33, 0), (8, 18, 0)],
        ),
      );
      await tester.pumpWidget(
        _createInASkeleton(currentLocale, studyTestBloc, entries, count),
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
      expect(questionText.data, entries[1].question);
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

    testWidgets('Test the precense of the main widgets', (
      WidgetTester tester,
    ) async {
      whenListen<StudyTestState>(
        studyTestBloc,
        Stream.fromIterable([]),
        initialState: StudyTestState(
          fieldList: fieldListEntity,
          entries: entries,
          currentEntryIndex: 1,
          counts: [(12, 45, 0), (3, 33, 0), (8, 18, 0)],
        ),
      );
      await tester.pumpWidget(
        _createInASkeleton(currentLocale, studyTestBloc, entries, count),
      );
      await tester.enterText(textFormFieldFinder, 'an');
      await tester.tap(find.byType(FilledButton));
      verify(() => studyTestBloc.add(CheckUserAnswer('an')));
    });
  });
}
