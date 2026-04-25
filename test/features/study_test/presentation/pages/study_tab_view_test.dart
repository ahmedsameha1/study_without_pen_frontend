import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/common/theme.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_bloc.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_event.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_state.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/pages/study_tab_view.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../common/common_finders.dart';
import '../../../common/widget_testing_helper.dart';

class MockStudyTestBloc extends Mock implements StudyTestBloc {}

Widget _createInASkeleton(Locale currentLocale, StudyTestBloc studyTestBloc) =>
    MaterialApp(
      localizationsDelegates: const [AppLocalizations.delegate],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: currentLocale,
      theme: AppTheme.theme,
      home: Scaffold(
        body: BlocProvider.value(
          value: studyTestBloc,
          child: Builder(builder: (context) => const StudyTabView()),
        ),
      ),
    );

void main() {
  group('English locale', () {
    Locale currentLocale = const Locale('en');
    String expectedEnterYourAnswerString = 'Enter your answer';
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
    final counts = [(12, 45, 0), (3, 33, 0), (8, 18, 0)];

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
          counts: counts,
        ),
      );
      await tester.pumpWidget(_createInASkeleton(currentLocale, studyTestBloc));
      Scrollbar scrollbar = tester.widget(
        find.descendant(
          of: find.byType(StudyTabView),
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
            matching: find.byType(Column),
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
      SizedBox questionAnswerSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(column),
          matching: find.byKey(const Key('questionAnswerSizedBox')),
        ),
      );
      expect(questionAnswerSizedBox.height, 20);
      SizedBox answerSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(column),
          matching: find.byKey(const Key('answerSizedBox')),
        ),
      );
      expect(answerSizedBox.height, 200);
      expect(answerSizedBox.width, double.infinity);
      DecoratedBox answerDecoratedBox = tester.widget(
        find.descendant(
          of: find.byWidget(answerSizedBox),
          matching: find.byType(DecoratedBox),
        ),
      );
      expect(
        answerDecoratedBox.decoration,
        BoxDecoration(
          border: Border.all(
            color: outlineInputBorder.borderSide.color,
            width: outlineInputBorder.borderSide.width,
          ),
          borderRadius: outlineInputBorder.borderRadius,
        ),
      );
      SingleChildScrollView answerSingleChildScrollView = tester.widget(
        find.descendant(
          of: find.byWidget(answerDecoratedBox),
          matching: singleChildScrollViewFinder,
        ),
      );
      expect(answerSingleChildScrollView.padding!.horizontal, 20);
      expect(answerSingleChildScrollView.padding!.vertical, 20);
      ConstrainedBox answerConstrainedBox = tester.widget(
        find.descendant(
          of: find.byWidget(answerSingleChildScrollView),
          matching: find.byType(ConstrainedBox),
        ),
      );
      expect(answerConstrainedBox.constraints.minHeight, 180);
      Text answerText = tester.widget(
        find.descendant(
          of: find.byWidget(answerConstrainedBox),
          matching: find.descendant(
            of: centerFinder,
            matching: find.byType(Text),
          ),
        ),
      );
      expect(answerText.data, entries[1].answer);
      expect(
        answerText.style,
        Theme.of(tester.element(find.byWidget(answerText))).textTheme.bodyLarge,
      );
      expect(answerText.textAlign, TextAlign.center);
      SizedBox answerUserAnswerSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(column),
          matching: find.byKey(const Key('answerUserAnswerSizedBox')),
        ),
      );
      expect(answerUserAnswerSizedBox.height, 20);
      SizedBox userAnswerSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(column),
          matching: find.byKey(const Key('userAnswerSizedBox')),
        ),
      );
      expect(userAnswerSizedBox.height, 200);
      Stack stack = tester.widget(
        find.descendant(
          of: find.byWidget(userAnswerSizedBox),
          matching: find.byType(Stack),
        ),
      );
      TextFormField userAnswerTextFormField = tester.widget(
        find.descendant(
          of: find.byWidget(stack),
          matching: textFormFieldFinder,
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
      Padding countPadding = tester.widget(
        find.descendant(
          of: find.byWidget(userAnswerSizedBox),
          matching: find.descendant(
            of: find.byWidget(stack),
            matching: find.byType(Padding),
          ),
        ),
      );
      expect(countPadding.padding.horizontal, 6);
      expect(countPadding.padding.vertical, 3);
      Text countText = tester.widget(
        find.descendant(
          of: find.byWidget(countPadding),
          matching: find.text('${counts[1].$1}'),
        ),
      );
      expect(
        countText.style,
        TextStyle(
          color: Theme.of(
            tester.element(find.byWidget(countText)),
          ).colorScheme.secondary,
        ),
      );
      checkWidgetsOrder(stack.children, [
        userAnswerTextFormField,
        countPadding,
      ]);
      checkWidgetsOrder(column.children, [
        questionSizedBox,
        questionAnswerSizedBox,
        answerSizedBox,
        answerUserAnswerSizedBox,
        userAnswerSizedBox,
      ]);
    });

    testWidgets(
      'when user answer changed CheckUserAnswer event is added to bloc',
      (WidgetTester tester) async {
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
          _createInASkeleton(currentLocale, studyTestBloc),
        );
        await tester.enterText(textFormFieldFinder, 'an');
        verify(() => studyTestBloc.add(CheckUserAnswer('an')));
      },
    );
  });
}
