import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entries_page_data.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/usecases/watch_entries_usecase.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/entries_bloc.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/entries_event.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/entries_state.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/tab_data.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:uuid/uuid.dart';

class MockWatchEntriesUsecase extends Mock implements WatchEntriesUsecase {}

class FakeEntry extends Fake implements EntryEntity {}

class FakeEntriesPageData extends Fake implements EntriesPageData {}

void main() {
  DateTime aDateTime = DateTime.utc(2025);
  final fieldId = const Uuid().v4();
  final fieldListId = const Uuid().v4();
  final entry1Id = const Uuid().v4();
  final entry2Id = const Uuid().v4();
  final entry3Id = const Uuid().v4();
  final entry4Id = const Uuid().v4();
  FieldListEntity fieldListEntity = FieldListEntity(
    id: fieldListId,
    fieldId: fieldId,
    name: 'field list name',
    creationAt: aDateTime,
    lastModificationAt: aDateTime,
  );
  List<EntryEntity> entries1 = [
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'aquestion',
      creationAt: aDateTime.add(const Duration(hours: 2)),
      lastModificationAt: aDateTime.add(const Duration(hours: 2)),
      askedCount: 4,
      wronglyAnsweredCount: 3,
      rank: Rank.important,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'bquestion',
      creationAt: aDateTime.add(const Duration(hours: 1)),
      lastModificationAt: aDateTime.add(const Duration(hours: 1)),
      askedCount: 4,
      wronglyAnsweredCount: 2,
      rank: Rank.normal,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'cquestion',
      creationAt: aDateTime,
      lastModificationAt: aDateTime,
      askedCount: 4,
      wronglyAnsweredCount: 4,
      rank: Rank.vital,
    ),
  ];
  List<EntryEntity> entries2 = [
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'question',
      creationAt: DateTime.utc(2026),
      lastModificationAt: DateTime.utc(2026),
      askedCount: 4,
      wronglyAnsweredCount: 3,
      rank: Rank.important,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime.add(const Duration(hours: 4)),
      lastModificationAt: aDateTime.add(const Duration(hours: 4)),
      askedCount: 4,
      wronglyAnsweredCount: 2,
      rank: Rank.normal,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime.add(const Duration(hours: 2)),
      lastModificationAt: aDateTime.add(const Duration(hours: 2)),
      askedCount: 4,
      wronglyAnsweredCount: 4,
      rank: Rank.vital,
    ),
  ];
  List<EntryEntity> entries3 = [
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'question',
      creationAt: aDateTime.subtract(const Duration(days: 3)),
      lastModificationAt: aDateTime.subtract(const Duration(days: 3)),
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.important,
      order: 1,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime.subtract(const Duration(days: 2)),
      lastModificationAt: aDateTime.subtract(const Duration(days: 2)),
      askedCount: 4,
      wronglyAnsweredCount: 2,
      rank: Rank.normal,
      order: 1,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'aQuestion',
      creationAt: aDateTime,
      lastModificationAt: aDateTime,
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
      order: 1,
    ),
    EntryEntity(
      id: entry4Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime.subtract(const Duration(days: 2)),
      lastModificationAt: aDateTime.subtract(const Duration(days: 2)),
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
      order: 0,
    ),
  ];
  List<EntryEntity> entries4 = [
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'question',
      creationAt: DateTime(2024, 2, 1),
      lastModificationAt: DateTime(2024, 2, 1),
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.important,
      order: 1,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime.subtract(const Duration(days: 2)),
      lastModificationAt: aDateTime.subtract(const Duration(days: 2)),
      askedCount: 4,
      wronglyAnsweredCount: 2,
      rank: Rank.normal,
      order: 1,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'aQuestion',
      creationAt: aDateTime,
      lastModificationAt: aDateTime,
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
      order: 1,
    ),
    EntryEntity(
      id: entry4Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: DateTime(2024, 3, 1),
      lastModificationAt: DateTime(2024, 3, 1),
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
      order: 0,
    ),
  ];
  List<EntryEntity> entries5 = [
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'question',
      creationAt: DateTime(2024, 2, 1),
      lastModificationAt: DateTime(2024, 2, 1),
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.important,
      order: 1,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime.subtract(const Duration(days: 2)),
      lastModificationAt: aDateTime.subtract(const Duration(days: 2)),
      askedCount: 4,
      wronglyAnsweredCount: 2,
      rank: Rank.normal,
      order: 2,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'aQuestion',
      creationAt: aDateTime,
      lastModificationAt: aDateTime,
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
      order: 2,
    ),
    EntryEntity(
      id: entry4Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: DateTime(2024, 3, 1),
      lastModificationAt: DateTime(2024, 3, 1),
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
      order: 3,
    ),
  ];
  final List<EntryEntity> scoreEntries1 = [
    entries1[2],
    entries1[0],
    entries1[1],
  ];
  final List<EntryEntity> scoreEntries2 = scoreEntries1;
  final List<EntryEntity> scoreEntries3 = [
    entries3[1],
    entries3[2],
    entries3[3],
    entries3[0],
  ];
  final List<EntryEntity> strugglingEntries1 = [entries1[2], entries1[0]];
  final List<EntryEntity> todayEntries1 = entries1;
  final List<EntryEntity> todayEntries2 = [entries2[1], entries2[2]];
  final List<EntryEntity> unseenEntries1 = [];
  final List<EntryEntity> unseenEntries3 = [entries3[3], entries3[0]];
  final List<EntryEntity> unseenEntries4 = [entries4[3], entries4[0]];
  final List<EntryEntity> browseEntries1 = entries1;
  final List<EntryEntity> browseEntries3 = [
    entries3[3],
    entries3[2],
    entries3[1],
    entries3[0],
  ];
  final List<EntryEntity> browseEntries5 = [
    entries5[0],
    entries5[2],
    entries5[1],
    entries5[3],
  ];
  EntriesPageData entriesPageData1 = EntriesPageData(
    fieldList: fieldListEntity,
    entries: entries1,
  );
  EntriesPageData entriesPageData2 = EntriesPageData(
    fieldList: fieldListEntity,
    entries: entries2,
  );
  EntriesPageData entriesPageData3 = EntriesPageData(
    fieldList: fieldListEntity,
    entries: entries3,
  );
  EntriesPageData entriesPageData4 = EntriesPageData(
    fieldList: fieldListEntity,
    entries: entries4,
  );
  EntriesPageData entriesPageData5 = EntriesPageData(
    fieldList: fieldListEntity,
    entries: entries5,
  );
  late WatchEntriesUsecase watchEntriesUsecase;

  setUpAll(() {
    registerFallbackValue(FakeEntry());
    registerFallbackValue(FakeEntriesPageData());
  });

  setUp(() {
    watchEntriesUsecase = MockWatchEntriesUsecase();
    when(
      () => watchEntriesUsecase.watchEntriesForScore(fieldListEntity.id!),
    ).thenAnswer((_) => Stream.value(entriesPageData1));
  });
  EntriesBloc buildBloc() => EntriesBloc(watchEntriesUsecase);
  test('Bloc has a correct initial state', () {
    expect(EntriesBloc(watchEntriesUsecase).state, const EntriesState());
  });
  group('EntriesSubscriptionRequested event', () {
    blocTest<EntriesBloc, EntriesState>(
      '''
    When EntriesSubscriptionRequested event is added
    watchEntriesUsecase.call() is called
    ''',
      build: buildBloc,
      act: (bloc) => bloc.add(EntriesSubscriptionRequested(fieldListId)),
      verify: (_) {
        verify(
          () => watchEntriesUsecase.watchEntriesForScore(fieldListId),
        ).called(1);
      },
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit [loading, success] with categorized tabs when entries are successfully fetched',
      build: buildBloc,
      act: (bloc) =>
          bloc.add(EntriesSubscriptionRequested(fieldListEntity.id!)),
      expect: () => [
        const EntriesState(status: EntriesStatus.loading),
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData1,
          tabs: [
            TabData(
              status: TabDataStatus.ready,
              name: scoreTabName,
              description: scoreTabDescription,
              entries: entriesPageData1.entries,
            ),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
      ],
    );

    StreamController<EntriesPageData> streamController1 = StreamController();
    StreamController<EntriesPageData> streamController2 = StreamController();
    blocTest<EntriesBloc, EntriesState>(
      'fffffff',
      setUp: () {
        watchEntriesUsecase = MockWatchEntriesUsecase();
        when(
          () => watchEntriesUsecase.watchEntriesForScore(fieldListId),
        ).thenAnswer((_) => streamController1.stream);
        when(
          () => watchEntriesUsecase.watchEntriesForToday(fieldListId),
        ).thenAnswer((_) => streamController2.stream);
      },
      build: buildBloc,
      act: (bloc) async {
        bloc.add(EntriesSubscriptionRequested(fieldListEntity.id!));
        streamController1.add(entriesPageData1);
        await Future.delayed(Duration.zero);
        bloc.add(PrepareTodayTab());
        streamController1.add(entriesPageData2);
        await Future.delayed(Duration.zero);
        streamController2.add(entriesPageData2);
        await Future.delayed(Duration.zero);
        streamController1.add(entriesPageData3);
        await Future.delayed(Duration.zero);
        streamController2.add(entriesPageData3);
        await Future.delayed(Duration.zero);
      },
      expect: () => [
        const EntriesState(status: EntriesStatus.loading),
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData1,
          tabs: [
            TabData(
              status: TabDataStatus.ready,
              name: scoreTabName,
              description: scoreTabDescription,
              entries: entriesPageData1.entries,
            ),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData1,
          currentTabIndex: EntriesBloc.todayTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData2,
          currentTabIndex: EntriesBloc.todayTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData2,
          currentTabIndex: EntriesBloc.todayTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            TabData(
              status: TabDataStatus.ready,
              name: todayTabName,
              description: todayTabDescription,
              entries: entriesPageData2.entries,
            ),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.todayTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            TabData(
              status: TabDataStatus.ready,
              name: todayTabName,
              description: todayTabDescription,
              entries: entriesPageData2.entries,
            ),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.todayTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            TabData(
              status: TabDataStatus.ready,
              name: todayTabName,
              description: todayTabDescription,
              entries: entriesPageData3.entries,
            ),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit [loading, failure] when watching entries encounters an error in the stream',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForScore(fieldListId),
        ).thenAnswer((_) => Stream.error(Exception('oops!')));
      },
      build: buildBloc,
      act: (bloc) =>
          bloc.add(EntriesSubscriptionRequested(fieldListEntity.id!)),
      expect: () => [
        const EntriesState(status: EntriesStatus.loading),
        const EntriesState(status: EntriesStatus.failure),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit [loading, failure] when watching entries encounters an error by throwing exception',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForScore(fieldListId),
        ).thenThrow((_) => Exception('oops!'));
      },
      build: buildBloc,
      act: (bloc) =>
          bloc.add(EntriesSubscriptionRequested(fieldListEntity.id!)),
      expect: () => [
        const EntriesState(status: EntriesStatus.loading),
        const EntriesState(status: EntriesStatus.failure),
      ],
    );
  });

  group('PrepareScoreTab event', () {
    blocTest<EntriesBloc, EntriesState>(
      'should emit success with categorized tabs when entries are successfully fetched '
      'when there is undefault current state',
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData2,
        currentTabIndex: EntriesBloc.todayTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          const TabData(
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            name: todayTabName,
            description: todayTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareScoreTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData2,
          currentTabIndex: EntriesBloc.scoreTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData2,
          currentTabIndex: EntriesBloc.scoreTabIndex,
          tabs: [
            TabData(
              status: TabDataStatus.ready,
              name: scoreTabName,
              description: scoreTabDescription,
              entries: entriesPageData1.entries,
            ),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when entriesPageData is null',
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareScoreTab()),
      expect: () => [const EntriesState(status: EntriesStatus.failure)],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when watching entries encounters an error in the stream',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForScore(fieldListId),
        ).thenAnswer((_) => Stream.error(Exception('oops!')));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData2,
        currentTabIndex: EntriesBloc.todayTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          const TabData(
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            name: todayTabName,
            description: todayTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareScoreTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData2,
          currentTabIndex: EntriesBloc.scoreTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        const EntriesState(status: EntriesStatus.failure),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when watching entries encounters an error by throwing exception',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForScore(fieldListId),
        ).thenThrow((_) => Exception('oops!'));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData2,
        currentTabIndex: EntriesBloc.todayTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          const TabData(
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            name: todayTabName,
            description: todayTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareScoreTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData2,
          currentTabIndex: EntriesBloc.scoreTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        const EntriesState(status: EntriesStatus.failure),
      ],
    );
  });

  group('PrepareStrugglingTab event', () {
    blocTest<EntriesBloc, EntriesState>(
      'should emit success with categorized tabs when entries are successfully fetched '
      'when there is undefault current state',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForStruggling(fieldListId),
        ).thenAnswer((_) => Stream.value(entriesPageData1));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.todayTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          const TabData(
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            name: todayTabName,
            description: todayTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareStrugglingTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.strugglingTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.strugglingTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            TabData(
              status: TabDataStatus.ready,
              name: strugglingTabName,
              description: strugglingTabDescription,
              entries: entriesPageData1.entries,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when entriesPageData is null',
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareStrugglingTab()),
      expect: () => [
        const EntriesState(
          status: EntriesStatus.failure,
          currentTabIndex: EntriesBloc.strugglingTabIndex,
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when watching entries encounters an error in the stream',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForStruggling(fieldListId),
        ).thenAnswer((_) => Stream.error(Exception('oops!')));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.todayTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          const TabData(
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            name: todayTabName,
            description: todayTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareStrugglingTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.strugglingTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        const EntriesState(
          status: EntriesStatus.failure,
          currentTabIndex: EntriesBloc.strugglingTabIndex,
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when watching entries encounters an error by throwing exception',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForStruggling(fieldListId),
        ).thenThrow((_) => Exception('oops!'));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.todayTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          const TabData(
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            name: todayTabName,
            description: todayTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareStrugglingTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.strugglingTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        const EntriesState(
          status: EntriesStatus.failure,
          currentTabIndex: EntriesBloc.strugglingTabIndex,
        ),
      ],
    );
  });

  group('PrepareTodayTab event', () {
    blocTest<EntriesBloc, EntriesState>(
      'should emit success with categorized tabs when entries are successfully fetched '
      'when there is undefault current state',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForToday(fieldListId),
        ).thenAnswer((_) => Stream.value(entriesPageData1));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.strugglingTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          TabData(
            status: TabDataStatus.ready,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: todayTabName, description: todayTabDescription),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareTodayTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.todayTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.todayTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            TabData(
              status: TabDataStatus.ready,
              name: todayTabName,
              description: todayTabDescription,
              entries: entriesPageData1.entries,
            ),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when entriesPageData is null',
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareTodayTab()),
      expect: () => [
        const EntriesState(
          status: EntriesStatus.failure,
          currentTabIndex: EntriesBloc.todayTabIndex,
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when watching entries encounters an error in the stream',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForToday(fieldListId),
        ).thenAnswer((_) => Stream.error(Exception('oops!')));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.strugglingTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          TabData(
            status: TabDataStatus.ready,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: todayTabName, description: todayTabDescription),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareTodayTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.todayTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        const EntriesState(
          status: EntriesStatus.failure,
          currentTabIndex: EntriesBloc.todayTabIndex,
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when watching entries encounters an error by throwing exception',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForToday(fieldListId),
        ).thenThrow((_) => Exception('oops!'));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.strugglingTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          TabData(
            status: TabDataStatus.ready,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: todayTabName, description: todayTabDescription),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareTodayTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.todayTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        const EntriesState(
          status: EntriesStatus.failure,
          currentTabIndex: EntriesBloc.todayTabIndex,
        ),
      ],
    );
  });

  group('PrepareUnseenTab event', () {
    blocTest<EntriesBloc, EntriesState>(
      'should emit success with categorized tabs when entries are successfully fetched '
      'when there is undefault current state',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForUnseen(fieldListId),
        ).thenAnswer((_) => Stream.value(entriesPageData1));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.strugglingTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          TabData(
            status: TabDataStatus.ready,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: todayTabName, description: todayTabDescription),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareUnseenTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.unseenTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.unseenTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            TabData(
              status: TabDataStatus.ready,
              name: unseenTabName,
              description: unseenTabDescription,
              entries: entriesPageData1.entries,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when entriesPageData is null',
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareUnseenTab()),
      expect: () => [
        const EntriesState(
          status: EntriesStatus.failure,
          currentTabIndex: EntriesBloc.unseenTabIndex,
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when watching entries encounters an error in the stream',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForUnseen(fieldListId),
        ).thenAnswer((_) => Stream.error(Exception('oops!')));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.strugglingTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          TabData(
            status: TabDataStatus.ready,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: todayTabName, description: todayTabDescription),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareUnseenTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.unseenTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        const EntriesState(
          status: EntriesStatus.failure,
          currentTabIndex: EntriesBloc.unseenTabIndex,
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when watching entries encounters an error by throwing exception',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForUnseen(fieldListId),
        ).thenThrow((_) => Exception('oops!'));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.strugglingTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          TabData(
            status: TabDataStatus.ready,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: todayTabName, description: todayTabDescription),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareUnseenTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.unseenTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        const EntriesState(
          status: EntriesStatus.failure,
          currentTabIndex: EntriesBloc.unseenTabIndex,
        ),
      ],
    );
  });

  group('PrepareBrowseTab event', () {
    blocTest<EntriesBloc, EntriesState>(
      'should emit success with categorized tabs when entries are successfully fetched '
      'when there is undefault current state',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForBrowse(fieldListId),
        ).thenAnswer((_) => Stream.value(entriesPageData1));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.strugglingTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          TabData(
            status: TabDataStatus.ready,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: todayTabName, description: todayTabDescription),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareBrowseTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.browseTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.browseTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            TabData(
              status: TabDataStatus.ready,
              name: browseTabName,
              description: browseTabDescription,
              entries: entriesPageData1.entries,
            ),
          ],
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when entriesPageData is null',
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareBrowseTab()),
      expect: () => [
        const EntriesState(
          status: EntriesStatus.failure,
          currentTabIndex: EntriesBloc.browseTabIndex,
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when watching entries encounters an error in the stream',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForBrowse(fieldListId),
        ).thenAnswer((_) => Stream.error(Exception('oops!')));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.strugglingTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          TabData(
            status: TabDataStatus.ready,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: todayTabName, description: todayTabDescription),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareBrowseTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.browseTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        const EntriesState(
          status: EntriesStatus.failure,
          currentTabIndex: EntriesBloc.browseTabIndex,
        ),
      ],
    );

    blocTest<EntriesBloc, EntriesState>(
      'should emit failure when watching entries encounters an error by throwing exception',
      setUp: () {
        when(
          () => watchEntriesUsecase.watchEntriesForBrowse(fieldListId),
        ).thenThrow((_) => Exception('oops!'));
      },
      seed: () => EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.strugglingTabIndex,
        tabs: [
          const TabData(name: scoreTabName, description: scoreTabDescription),
          TabData(
            status: TabDataStatus.ready,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: entriesPageData2.entries,
          ),
          const TabData(name: todayTabName, description: todayTabDescription),
          const TabData(name: unseenTabName, description: unseenTabDescription),
          const TabData(name: browseTabName, description: browseTabDescription),
        ],
      ),
      build: buildBloc,
      act: (bloc) => bloc.add(PrepareBrowseTab()),
      expect: () => [
        EntriesState(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData3,
          currentTabIndex: EntriesBloc.browseTabIndex,
          tabs: [
            const TabData(name: scoreTabName, description: scoreTabDescription),
            const TabData(
              name: strugglingTabName,
              description: strugglingTabDescription,
            ),
            const TabData(name: todayTabName, description: todayTabDescription),
            const TabData(
              name: unseenTabName,
              description: unseenTabDescription,
            ),
            const TabData(
              name: browseTabName,
              description: browseTabDescription,
            ),
          ],
        ),
        const EntriesState(
          status: EntriesStatus.failure,
          currentTabIndex: EntriesBloc.browseTabIndex,
        ),
      ],
    );
  });
}
