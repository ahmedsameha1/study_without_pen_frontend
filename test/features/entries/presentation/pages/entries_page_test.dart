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
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/tab_data.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/pages/entries_page.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/pages/entry_card.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../common/common_finders.dart';
import '../../../common/widget_testing_helper.dart';

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
  FieldListEntity fieldListEntity = FieldListEntity(
    id: const Uuid().v4(),
    fieldId: const Uuid().v4(),
    name: 'field list name',
    creationAt: fieldListDateTime,
    lastModificationAt: fieldListDateTime,
  );
  List<EntryEntity> entries = [
    EntryEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      answer: 'answer1',
      question: 'question1',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
      askedCount: 10,
      wronglyAnsweredCount: 1,
    ),
    EntryEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      answer: 'answer2',
      question: 'question2',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
      askedCount: 10,
      wronglyAnsweredCount: 4,
    ),
    EntryEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      answer: 'answer3',
      question: 'question3',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
      askedCount: 10,
      wronglyAnsweredCount: 5,
    ),
    EntryEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      answer: 'answer4',
      question: 'question4',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
      askedCount: 10,
      wronglyAnsweredCount: 1,
    ),
    EntryEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      answer: 'answer5',
      question: 'question5',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
      askedCount: 10,
      wronglyAnsweredCount: 4,
    ),
    EntryEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      answer: 'answer6',
      question: 'question6',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
      askedCount: 10,
      wronglyAnsweredCount: 5,
    ),
  ];
  final entriesPageData = EntriesPageData(
    fieldList: fieldListEntity,
    entries: entries,
  );
  late WatchEntriesUsecase watchEntriesUsecase;
  group("English locale", () {
    String expectedErrorString = 'An error occurred while loading entries!';
    String expectedNoEntriesString = 'Currently, there are no entries!';
    String expectedMasteredString = 'Mastered';
    String expectedNeedsFocusString = 'Needs Focus';
    String expectedScoreString = 'Score';
    String expectedScoreDescriptionString =
        'entries ordered by score descendingly';

    Locale currentLocale = const Locale("en");

    group('EntriesPage', () {
      setUp(() {
        watchEntriesUsecase = MockWatchEntriesUsecase();
        when(
          () => watchEntriesUsecase.watchEntriesForScore(fieldListEntity.id!),
        ).thenAnswer((_) => Stream.value(entriesPageData));
      });

      testWidgets("Test the presence of EntriesPageView widget", (
        WidgetTester tester,
      ) async {
        await _createEntriesPageInASkeleton(
          tester,
          watchEntriesUsecase,
          fieldListEntity.id!,
          fieldListEntity.fieldId,
        );
        expect(
          find.descendant(
            of: find.byType(EntriesPage),
            matching: find.byType(EntriesPageView),
          ),
          findsOne,
        );
      });

      testWidgets(
        'Test calling watchEntriesUsecase.watchEntriesForScore() on initialization',
        (WidgetTester tester) async {
          await _createEntriesPageInASkeleton(
            tester,
            watchEntriesUsecase,
            fieldListEntity.id!,
            fieldListEntity.fieldId,
          );
          verify(
            () => watchEntriesUsecase.watchEntriesForScore(fieldListEntity.id!),
          ).called(1);
        },
      );
    });

    group('EntriesPageView', () {
      late EntriesBloc entriesBloc;
      late GoRouter goRouter;
      setUp(() {
        goRouter = MockGoRouter();
        entriesBloc = MockEntriesBloc();
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
            fieldListEntity.id!,
            fieldListEntity.fieldId,
          );
          expect(
            find.descendant(
              of: find.byType(EntriesPageView),
              matching: find.descendant(
                of: scaffoldFinder,
                matching: find.descendant(
                  of: safeAreaFinder,
                  matching: find.descendant(
                    of: centerFinder,
                    matching: circularProgressIndicatorFinder,
                  ),
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
                  of: safeAreaFinder,
                  matching: find.descendant(
                    of: centerFinder,
                    matching: find.text(expectedErrorString),
                  ),
                ),
              ),
            ),
            findsOne,
          );
        },
      );

      testWidgets(
        'Test the presence of the main widgets when there is no entries',
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
            fieldListEntity.id!,
            fieldListEntity.fieldId,
          );
          expect(
            find.descendant(
              of: find.byType(EntriesPageView),
              matching: find.descendant(
                of: scaffoldFinder,
                matching: find.descendant(
                  of: safeAreaFinder,
                  matching: find.descendant(
                    of: centerFinder,
                    matching: circularProgressIndicatorFinder,
                  ),
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
                  of: safeAreaFinder,
                  matching: find.descendant(
                    of: centerFinder,
                    matching: find.text(expectedNoEntriesString),
                  ),
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
        'Test the presence of the main widgets when there are entries',
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
              EntriesState(
                status: EntriesStatus.success,
                entriesPageData: EntriesPageData(
                  fieldList: fieldListEntity,
                  entries: entries,
                ),
                tabs: [
                  TabData(
                    name: scoreTabName,
                    description: scoreTabDescription,
                    status: TabDataStatus.ready,
                    entries: entries,
                  ),
                  TabData(
                    name: strugglingTabName,
                    description: strugglingTabDescription,
                    status: TabDataStatus.ready,
                    entries: entries,
                  ),
                  const TabData(
                    name: todayTabName,
                    description: todayTabDescription,
                  ),
                  const TabData(
                    name: unseenTabName,
                    description: unseenTabDescription,
                  ),
                  const TabData(
                    name: browseTabName,
                    description: browseTabDescription,
                  ),
                  const TabData(
                    status: TabDataStatus.ready,
                    name: searchTabName,
                    description: searchTabDescription,
                  ),
                ],
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
            fieldListEntity.id!,
            fieldListEntity.fieldId,
          );
          expect(
            find.descendant(
              of: find.byType(EntriesPageView),
              matching: find.descendant(
                of: scaffoldFinder,
                matching: find.descendant(
                  of: safeAreaFinder,
                  matching: find.descendant(
                    of: centerFinder,
                    matching: circularProgressIndicatorFinder,
                  ),
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
                matching: safeAreaFinder,
              ),
            ),
            findsNWidgets(2),
          );
          expect(
            find.descendant(
              of: safeAreaFinder,
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
              tester.element(find.byWidget(sliverOverlapAbsorber)),
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
          SliverPadding sliverPadding = tester.widget(
            find.descendant(
              of: find.byType(NestedScrollView),
              matching: find.byType(SliverPadding).at(0),
            ),
          );
          expect(sliverPadding.padding.horizontal, 30);
          expect(sliverPadding.padding.vertical, 15);
          SliverToBoxAdapter sliverToBoxAdapter = tester.widget(
            find.descendant(
              of: find.byWidget(sliverPadding),
              matching: find.byType(SliverToBoxAdapter),
            ),
          );
          Row mastryRow = tester.widget(
            find.descendant(
              of: find.byWidget(sliverToBoxAdapter),
              matching: rowFinder.at(1),
            ),
          );
          expect(mastryRow.mainAxisAlignment, MainAxisAlignment.center);
          Text masteryText = tester.widget(
            find.descendant(
              of: find.byWidget(mastryRow),
              matching: find.text(expectedMasteredString),
            ),
          );
          SizedBox masteredMasteryLineSizedBox = tester.widget(
            find.descendant(
              of: find.byWidget(mastryRow),
              matching: find.byKey(const Key('masteredMasteryLineSizedBox')),
            ),
          );
          expect(masteredMasteryLineSizedBox.width, 5);
          Container masteryLineContainer = tester.widget(
            find.descendant(
              of: find.byWidget(mastryRow),
              matching: find.descendant(
                of: find.byType(Expanded),
                matching: find.byType(Container),
              ),
            ),
          );
          expect(
            (masteryLineContainer.decoration! as BoxDecoration).borderRadius!
                as BorderRadius,
            BorderRadius.circular(5),
          );
          expect(
            ((masteryLineContainer.decoration! as BoxDecoration).border!
                    as Border)
                .left,
            BorderSide(
              color: Theme.of(
                tester.element(find.byWidget(masteryLineContainer)),
              ).colorScheme.onSurfaceVariant,
              width: 1,
            ),
          );
          expect(
            ((masteryLineContainer.decoration! as BoxDecoration).border!
                    as Border)
                .right,
            BorderSide(
              color: Theme.of(
                tester.element(find.byWidget(masteryLineContainer)),
              ).colorScheme.onSurfaceVariant,
              width: 1,
            ),
          );
          expect(
            ((masteryLineContainer.decoration! as BoxDecoration).border!
                    as Border)
                .top,
            BorderSide(
              color: Theme.of(
                tester.element(find.byWidget(masteryLineContainer)),
              ).colorScheme.onSurfaceVariant,
              width: 1,
            ),
          );
          expect(
            ((masteryLineContainer.decoration! as BoxDecoration).border!
                    as Border)
                .bottom,
            BorderSide(
              color: Theme.of(
                tester.element(find.byWidget(masteryLineContainer)),
              ).colorScheme.onSurfaceVariant,
              width: 1,
            ),
          );
          Expanded greenExpanded = tester.widget(
            find.descendant(
              of: find.byWidget(masteryLineContainer),
              matching: find.descendant(
                of: rowFinder,
                matching: expandedFinder.at(1),
              ),
            ),
          );
          expect(greenExpanded.flex, 2);
          SizedBox greenSizedBox = tester.widget(
            find.descendant(
              of: find.byWidget(greenExpanded),
              matching: sizedBoxFinder,
            ),
          );
          expect(greenSizedBox.height, 10);
          ColoredBox greenBox = tester.widget(
            find.descendant(
              of: find.byWidget(greenSizedBox),
              matching: find.byType(ColoredBox),
            ),
          );
          expect(greenBox.color, Colors.green);
          Expanded yellowExpanded = tester.widget(
            find.descendant(
              of: find.byWidget(masteryLineContainer),
              matching: find.descendant(
                of: rowFinder,
                matching: expandedFinder.at(2),
              ),
            ),
          );
          expect(yellowExpanded.flex, 2);
          SizedBox yellowSizedBox = tester.widget(
            find.descendant(
              of: find.byWidget(yellowExpanded),
              matching: sizedBoxFinder,
            ),
          );
          expect(yellowSizedBox.height, 10);
          ColoredBox yellowBox = tester.widget(
            find.descendant(
              of: find.byWidget(yellowSizedBox),
              matching: find.byType(ColoredBox),
            ),
          );
          expect(yellowBox.color, Colors.yellow);
          Expanded redExpanded = tester.widget(
            find.descendant(
              of: find.byWidget(masteryLineContainer),
              matching: find.descendant(
                of: rowFinder,
                matching: expandedFinder.at(3),
              ),
            ),
          );
          expect(redExpanded.flex, 2);
          SizedBox redSizedBox = tester.widget(
            find.descendant(
              of: find.byWidget(redExpanded),
              matching: sizedBoxFinder,
            ),
          );
          expect(redSizedBox.height, 10);
          ColoredBox redBox = tester.widget(
            find.descendant(
              of: find.byWidget(redSizedBox),
              matching: find.byType(ColoredBox),
            ),
          );
          expect(redBox.color, Colors.red.shade700);
          SizedBox masteryLineNeedsFocusSizedBox = tester.widget(
            find.descendant(
              of: find.byWidget(mastryRow),
              matching: find.byKey(const Key('masteryLineNeedsFocusSizedBox')),
            ),
          );
          expect(masteryLineNeedsFocusSizedBox.width, 5);
          Text needsFocusText = tester.widget(
            find.descendant(
              of: find.byWidget(mastryRow),
              matching: find.text(expectedNeedsFocusString),
            ),
          );
          checkWidgetsOrder(mastryRow.children, [
            masteryText,
            masteredMasteryLineSizedBox,
            greenExpanded,
            yellowExpanded,
            redExpanded,
            masteryLineNeedsFocusSizedBox,
            needsFocusText,
          ]);
          SliverPersistentHeader sliverPersistentHeader = tester.widget(
            find.descendant(
              of: find.byType(NestedScrollView),
              matching: find.byKey(const Key('sliverPersistentHeader')),
            ),
          );
          expect(sliverPersistentHeader.pinned, isTrue);
          Container sliverPersistentHeaderContainer = tester.widget(
            find.descendant(
              of: find.byWidget(sliverPersistentHeader),
              matching: find.byType(Container),
            ),
          );
          expect(
            sliverPersistentHeaderContainer.color,
            Theme.of(
              tester.element(find.byWidget(sliverPersistentHeaderContainer)),
            ).scaffoldBackgroundColor,
          );
          expect(sliverPersistentHeaderContainer.alignment, Alignment.center);
          TabBar tabBar = tester.widget(
            find.descendant(
              of: find.byWidget(sliverPersistentHeaderContainer),
              matching: find.byType(TabBar),
            ),
          );
          expect(tabBar.isScrollable, isTrue);
          expect((tabBar.tabs[0] as Text).data, expectedScoreString);
          SliverPadding descriptionSliverPadding = tester.widget(
            find.byKey(const Key('descriptionSliverPadding')),
          );
          expect(descriptionSliverPadding.padding.horizontal, 10);
          expect(descriptionSliverPadding.padding.vertical, 10);
          Text scoreDescriptionText = tester.widget(
            find.descendant(
              of: find.byWidget(descriptionSliverPadding),
              matching: find.descendant(
                of: find.byType(SliverToBoxAdapter),
                matching: find.descendant(
                  of: centerFinder,
                  matching: find.text(
                    '${entries.length}/${entries.length} $expectedScoreDescriptionString',
                  ),
                ),
              ),
            ),
          );
          expect(
            scoreDescriptionText.style,
            Theme.of(tester.element(find.byWidget(scoreDescriptionText)))
                .textTheme
                .bodySmall!
                .copyWith(
                  color: Theme.of(
                    tester.element(find.byWidget(scoreDescriptionText)),
                  ).hintColor,
                )
                .copyWith(
                  backgroundColor: Theme.of(
                    tester.element(find.byWidget(scoreDescriptionText)),
                  ).colorScheme.onSecondary,
                ),
          );
          final sliverList = tester.widget(find.byType(SliverList));
          expect(
            find.descendant(
              of: find.byWidget(sliverList),
              matching: find.byType(EntryCard),
            ),
            findsWidgets,
          );
          expect(sliverList.key, const PageStorageKey('score'));
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
          fieldListEntity.id!,
          fieldListEntity.fieldId,
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
            '$fieldListsPath${fieldListEntity.fieldId}$entriesPath${fieldListEntity.id!}$createEntry',
          ),
        ).called(1);
      });
    });
  });
}
