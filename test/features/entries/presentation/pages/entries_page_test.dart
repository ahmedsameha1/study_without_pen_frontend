import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/common/router_config.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entries_page_data.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/usecases/watch_entries_usecase.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/entries_bloc.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/entries_state.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/pages/entries_page.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../common/common_finders.dart';

class MockWatchEntriesUsecase extends Mock implements WatchEntriesUsecase {}

class MockEntriesBloc extends Mock implements EntriesBloc {}

class MockGoRouter extends Mock implements GoRouter {}

Future<void> _createEntriesPageInASkeleton(
  WidgetTester tester,
  WatchEntriesUsecase watchEntriesUsecase,
  String fieldListId,
  String fieldId,
) async {
  return tester.pumpWidget(
    RepositoryProvider.value(
      value: watchEntriesUsecase,
      child: MaterialApp(
        home: EntriesPage(fieldId: fieldId, fieldListId: fieldListId),
      ),
    ),
  );
}

Future<void> _createEntriesPageViewInASkeleton(
  WidgetTester tester,
  Locale locale,
  GoRouter goRouter,
  // Todo Consider removing this
  WatchEntriesUsecase watchEntriesUsecase,
  EntriesBloc entriesBloc,
  String fieldListId,
  String fieldId,
) {
  return tester.pumpWidget(
    RepositoryProvider.value(
      value: watchEntriesUsecase,
      child: MaterialApp(
        localizationsDelegates: [AppLocalizations.delegate],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: InheritedGoRouter(
          goRouter: goRouter,
          child: BlocProvider.value(
            value: entriesBloc,
            child: EntriesPageView(fieldId: fieldId, fieldListId: fieldListId),
          ),
        ),
      ),
    ),
  );
}

void main() {
  DateTime fieldListDateTime = DateTime(2025);
  final fieldId = const Uuid().v4();
  final fieldListId = const Uuid().v4();
  final entry1Id = const Uuid().v4();
  final entry2Id = const Uuid().v4();
  final entry3Id = const Uuid().v4();
  FieldListEntity fieldListEntity = FieldListEntity(
    id: fieldListId,
    fieldId: fieldId,
    name: 'field list name',
    creationAt: fieldListDateTime,
    lastModificationAt: fieldListDateTime,
  );
  List<EntryEntity> entries = [
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'question',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
    ),
  ];
  final entriesPageData = EntriesPageData(
    fieldList: fieldListEntity,
    entries: entries,
  );
  late WatchEntriesUsecase watchEntriesUsecase;
  group("English locale", () {
    String expectedErrorString = 'An error occurred while loading entries!';
    String expectedNoEntriesString = "Currently, there are no entries!";

    Locale currentLocale = const Locale("en");

    group('EntriesPage', () {
      setUp(() {
        watchEntriesUsecase = MockWatchEntriesUsecase();
        when(
          () => watchEntriesUsecase.call(fieldListId),
        ).thenAnswer((_) => Stream.value(entriesPageData));
      });

      testWidgets("Test the presence of EntriesPageView widget", (
        WidgetTester tester,
      ) async {
        await _createEntriesPageInASkeleton(
          tester,
          watchEntriesUsecase,
          fieldListId,
          fieldId,
        );
        expect(
          find.descendant(
            of: find.byType(EntriesPage),
            matching: find.byType(EntriesPageView),
          ),
          findsOne,
        );
      });

      testWidgets('Test calling watchEntriesUsecase.call() on initialization', (
        WidgetTester tester,
      ) async {
        await _createEntriesPageInASkeleton(
          tester,
          watchEntriesUsecase,
          fieldListId,
          fieldId,
        );
        verify(() => watchEntriesUsecase.call(fieldListId)).called(1);
      });
    });

    group('EntriesPageView', () {
      late EntriesBloc entriesBloc;
      late GoRouter goRouter;
      setUp(() {
        goRouter = MockGoRouter();
        entriesBloc = MockEntriesBloc();
        watchEntriesUsecase = MockWatchEntriesUsecase();
        when(
          () => entriesBloc.state,
        ).thenReturn(EntriesState(status: EntriesStatus.initial));
        /*
        when(
          () => watchEntriesUsecase.call(fieldListId),
        ).thenAnswer((_) => Stream.value(entriesPageData));
        */
      });

      testWidgets(
        'Test the precense of the main widgets when the status is failure',
        (WidgetTester tester) async {
          whenListen<EntriesState>(
            entriesBloc,
            Stream.fromIterable([
              const EntriesState(status: EntriesStatus.loading),
              const EntriesState(status: EntriesStatus.failure),
            ]),
            initialState: const EntriesState(status: EntriesStatus.initial),
          );
          await _createEntriesPageViewInASkeleton(
            tester,
            currentLocale,
            goRouter,
            watchEntriesUsecase,
            entriesBloc,
            fieldListId,
            fieldId,
          );
          expect(
            find.descendant(
              of: find.byType(EntriesPageView),
              matching: find.descendant(
                of: scaffoldFinder,
                matching: find.descendant(
                  of: centerFinder,
                  matching: circularProgressIndicatorFinder,
                ),
              ),
            ),
            findsOne,
          );
          await tester.pump();
          expect(
            find.descendant(
              of: find.byType(EntriesPageView),
              matching: find.descendant(
                of: scaffoldFinder,
                matching: find.descendant(
                  of: centerFinder,
                  matching: find.text(expectedErrorString),
                ),
              ),
            ),
            findsOne,
          );
        },
      );
      testWidgets(
        "Test the presence of the main widgets when there is no fieldlists",
        (WidgetTester tester) async {
          whenListen<EntriesState>(
            entriesBloc,
            Stream.fromIterable([
              const EntriesState(status: EntriesStatus.loading),
              EntriesState(
                status: EntriesStatus.success,
                entriesPageData: EntriesPageData(
                  fieldList: fieldListEntity,
                  entries: [],
                ),
              ),
            ]),
            initialState: const EntriesState(status: EntriesStatus.initial),
          );
          await _createEntriesPageViewInASkeleton(
            tester,
            currentLocale,
            goRouter,
            watchEntriesUsecase,
            entriesBloc,
            fieldListId,
            fieldId,
          );
          expect(
            find.descendant(
              of: find.byType(EntriesPageView),
              matching: find.descendant(
                of: scaffoldFinder,
                matching: find.descendant(
                  of: centerFinder,
                  matching: circularProgressIndicatorFinder,
                ),
              ),
            ),
            findsOne,
          );
          await tester.pump();
          expect(
            find.descendant(
              of: find.byType(EntriesPageView),
              matching: find.descendant(
                of: scaffoldFinder,
                matching: find.descendant(
                  of: centerFinder,
                  matching: find.text(expectedNoEntriesString),
                ),
              ),
            ),
            findsOne,
          );
          expect(appBarFinder, findsOne);
          AppBar appBar = tester.widget<AppBar>(appBarFinder);
          expect((appBar.title as Text).data, fieldListEntity.name);
          FloatingActionButton floatingActionButton = tester.widget(
            find.descendant(
              of: scaffoldFinder,
              matching: find.byType(FloatingActionButton),
            ),
          );
          Icon addIcon = floatingActionButton.child as Icon;
          expect(addIcon.icon, Icons.add);
        },
      );

      testWidgets(
        'Test the presence of the main widgets when there is no fieldlists',
        (WidgetTester tester) async {
          whenListen<EntriesState>(
            entriesBloc,
            Stream.fromIterable([
              const EntriesState(status: EntriesStatus.loading),
              EntriesState(
                status: EntriesStatus.success,
                entriesPageData: EntriesPageData(
                  fieldList: fieldListEntity,
                  entries: entries,
                ),
              ),
            ]),
            initialState: const EntriesState(status: EntriesStatus.initial),
          );
          await _createEntriesPageViewInASkeleton(
            tester,
            currentLocale,
            goRouter,
            watchEntriesUsecase,
            entriesBloc,
            fieldListId,
            fieldId,
          );
          expect(
            find.descendant(
              of: find.byType(EntriesPageView),
              matching: find.descendant(
                of: scaffoldFinder,
                matching: find.descendant(
                  of: centerFinder,
                  matching: circularProgressIndicatorFinder,
                ),
              ),
            ),
            findsOne,
          );
          await tester.pump();
          DefaultTabController defaultTabController = tester.widget(
            find.descendant(
              of: find.byType(EntriesPageView),
              matching: find.byType(DefaultTabController),
            ),
          );
          expect(defaultTabController.length, 5);
          expect(
            find.descendant(
              of: find.byWidget(defaultTabController),
              matching: find.byType(NestedScrollView),
            ),
            findsOne,
          );
          SliverOverlapAbsorber sliverOverlapAbsorber = tester.widget(
            find.descendant(
              of: find.byType(NestedScrollView),
              matching: find.byType(SliverOverlapAbsorber),
            ),
          );
          expect(
            sliverOverlapAbsorber.handle,
            NestedScrollView.sliverOverlapAbsorberHandleFor(
              tester.firstElement(find.byWidget(sliverOverlapAbsorber)),
            ),
          );
          SliverAppBar sliverAppBar = tester.widget(
            find.descendant(
              of: find.byWidget(sliverOverlapAbsorber),
              matching: find.byType(SliverAppBar),
            ),
          );
          expect(sliverAppBar.floating, isTrue);
          expect((sliverAppBar.title! as Text).data, fieldListEntity.name);
          expect(
            find.descendant(
              of: find.byWidget(sliverAppBar),
              matching: find.byIcon(Icons.search),
            ),
            findsOne,
          );
        },
      );

      testWidgets('Clicking the floatingActionButton go to CreateEntryPage', (
        WidgetTester tester,
      ) async {
        whenListen<EntriesState>(
          entriesBloc,
          Stream.fromIterable([
            const EntriesState(status: EntriesStatus.loading),
            EntriesState(
              status: EntriesStatus.success,
              entriesPageData: EntriesPageData(
                fieldList: fieldListEntity,
                entries: [],
              ),
            ),
          ]),
          initialState: const EntriesState(status: EntriesStatus.initial),
        );
        await _createEntriesPageViewInASkeleton(
          tester,
          currentLocale,
          goRouter,
          watchEntriesUsecase,
          entriesBloc,
          fieldListId,
          fieldId,
        );
        expect(
          find.descendant(
            of: find.byType(EntriesPageView),
            matching: find.descendant(
              of: scaffoldFinder,
              matching: find.descendant(
                of: centerFinder,
                matching: circularProgressIndicatorFinder,
              ),
            ),
          ),
          findsOne,
        );
        await tester.pump();
        await tester.pumpAndSettle();
        await tester.tap(floatingActionButtonFinder);
        verify(
          () => goRouter.go(
            '$fieldListsPath$fieldId$entriesPath$fieldListId$createEntry',
          ),
        ).called(1);
      });
    });
  });
}
