import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_bloc.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_event.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_state.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/pages/study_test_page.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/pages/study_test_page_view_content.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../common/common_finders.dart';

class MockStudyTestBloc extends Mock implements StudyTestBloc {}

void main() {
  group('English locale', () {
    Locale currentLocale = const Locale('en');
    String expectedTestString = 'Test';
    String expectedStudyString = 'Study';
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
        id: const Uuid().v4(),
        fieldListId: const Uuid().v4(),
        answer: 'answer2',
        question: 'question2',
        creationAt: DateTime(2025).subtract(const Duration(days: 2)),
        lastModificationAt: DateTime(2025).subtract(const Duration(days: 1)),
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

    group('StudyTestPage', () {
      testWidgets('Test the presence of StudyTestPageView widget', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(home: StudyTestPage(state: StudyTestState())),
        );
        expect(
          find.descendant(
            of: find.byType(StudyTestPage),
            matching: find.byType(StudyTestPageView),
          ),
          findsOne,
        );
      });
    });

    group('StudyTestPageView', () {
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
            entries: entries,
            currentEntryIndex: 1,
            counts: [(12, 45, 1), (3, 33, 0), (8, 18, 1)],
          ),
        );
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: const [AppLocalizations.delegate],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: currentLocale,
            home: BlocProvider.value(
              value: studyTestBloc,
              child: const StudyTestPageView(),
            ),
          ),
        );
        PageView pageView = tester.widget(
          find.descendant(
            of: find.byType(StudyTestPageView),
            matching: find.descendant(
              of: scaffoldFinder,
              matching: find.descendant(
                of: safeAreaFinder,
                matching: find.byType(PageView).at(1),
              ),
            ),
          ),
        );
        expect(
          find.descendant(
            of: find.byType(PageView),
            matching: find.byType(StudyTestPageViewContent),
          ),
          findsOne,
        );
        expect(find.text(entries[1].question), findsOne);
        expect(find.text(entries[1].answer), findsOne);
        expect(find.text('3'), findsOne);
        await tester.tap(find.text(expectedTestString));
        await tester.pumpAndSettle();
        expect(find.text('33'), findsOne);
        await tester.drag(find.text(entries[1].question), const Offset(800, 0));
        await tester.pumpAndSettle();
        expect(find.text(entries[0].question), findsOne);
        expect(find.text(entries[0].answer), findsNothing);
        expect(find.text('45'), findsOne);
        await tester.tap(find.text(expectedStudyString));
        await tester.pumpAndSettle();
        expect(find.text(entries[0].question), findsOne);
        expect(find.text(entries[0].answer), findsOne);
        expect(find.text('12'), findsOne);
      });

      testWidgets('a ChangeEntry event is added when swipe the page', (
        WidgetTester tester,
      ) async {
        whenListen<StudyTestState>(
          studyTestBloc,
          Stream.fromIterable([]),
          initialState: StudyTestState(
            entries: entries,
            currentEntryIndex: 1,
            counts: [(12, 45, 0), (3, 33, 0), (8, 18, 0)],
          ),
        );
        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: const [AppLocalizations.delegate],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: currentLocale,
            home: BlocProvider.value(
              value: studyTestBloc,
              child: const StudyTestPageView(),
            ),
          ),
        );
        await tester.drag(find.text(entries[1].question), const Offset(800, 0));
        await tester.pumpAndSettle();
        verify(() => studyTestBloc.add(ChangeEntry(0))).called(1);
      });
    });
  });
}
