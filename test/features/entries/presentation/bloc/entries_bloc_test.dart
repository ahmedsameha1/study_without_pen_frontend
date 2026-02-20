import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
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
  final List<EntryEntity> browseEntries1 = entries1;
  final List<EntryEntity> browseEntries3 = [
    entries3[3],
    entries3[2],
    entries3[1],
    entries3[0],
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
  WatchEntriesUsecase watchEntriesUsecase = MockWatchEntriesUsecase();

  setUpAll(() {
    registerFallbackValue(FakeEntry());
    registerFallbackValue(FakeEntriesPageData());
  });

  EntriesBloc buildBloc() => EntriesBloc(watchEntriesUsecase);
  test('Bloc has a correct initial state', () {
    expect(EntriesBloc(watchEntriesUsecase).state, const EntriesState());
  });

  blocTest<EntriesBloc, EntriesState>(
    '''
    When EntriesSubscriptionRequested event is added
    watchEntriesUsecase.call() is called
    ''',
    build: buildBloc,
    act: (bloc) => bloc.add(EntriesSubscriptionRequested(fieldListId)),
    verify: (_) {
      verify(() => watchEntriesUsecase.call(fieldListId)).called(1);
    },
  );

  blocTest<EntriesBloc, EntriesState>(
    'emits state '
    'when watchEntriesUsecase.call stream emits EntriesPageData',
    setUp: () {
      when(
        () => watchEntriesUsecase.call(fieldListEntity.id!),
      ).thenAnswer((_) => Stream.value(entriesPageData1));
    },
    build: buildBloc,
    act: (bloc) => bloc.add(EntriesSubscriptionRequested(fieldListId)),
    wait: const Duration(milliseconds: 1),
    expect: () => [
      const EntriesState(status: EntriesStatus.loading),
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData1,
        currentTabIndex: EntriesBloc.scoreTabIndex,
        tabs: [
          const TabData(
            status: TabDataStatus.loading,
            name: scoreTabName,
            description: scoreTabDescription,
          ),
          const TabData(
            status: TabDataStatus.loading,
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          const TabData(
            status: TabDataStatus.loading,
            name: todayTabName,
            description: todayTabDescription,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: unseenTabName,
            description: unseenTabDescription,
            entries: [],
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: browseTabName,
            description: browseTabDescription,
            entries: [],
          ),
        ],
      ),
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData1,
        currentTabIndex: EntriesBloc.scoreTabIndex,
        tabs: [
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: scoreTabName,
            description: scoreTabDescription,
            entries: scoreEntries1,
          ),
          const TabData(
            status: TabDataStatus.loading,
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          const TabData(
            status: TabDataStatus.loading,
            name: todayTabName,
            description: todayTabDescription,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: unseenTabName,
            description: unseenTabDescription,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: browseTabName,
            description: browseTabDescription,
            entries: [],
          ),
        ],
      ),
    ],
  );

  blocTest<EntriesBloc, EntriesState>(
    'emits state '
    'when watchEntriesUsecase.call stream emits new EntriesPageData '
    'after the first',
    seed: () => EntriesState(
      status: EntriesStatus.success,
      entriesPageData: entriesPageData1,
      currentTabIndex: EntriesBloc.todayTabIndex,
      tabs: [
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: scoreTabName,
          description: scoreTabDescription,
          entries: unseenEntries1,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: strugglingTabName,
          description: strugglingTabDescription,
          entries: strugglingEntries1,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: todayTabName,
          description: todayTabDescription,
          entries: browseEntries1,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: unseenTabName,
          description: unseenTabDescription,
          entries: scoreEntries1,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: browseTabName,
          description: browseTabDescription,
          entries: todayEntries1,
        ),
      ],
    ),
    build: buildBloc,
    act: (bloc) {
      bloc
        ..add(NewData(entriesPageData2))
        ..add(PrepareTab(EntriesBloc.todayTabIndex, aDateTime));
    },
    wait: const Duration(milliseconds: 1),
    expect: () => [
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData2,
        currentTabIndex: EntriesBloc.todayTabIndex,
        tabs: [
          const TabData(
            status: TabDataStatus.loading,
            name: scoreTabName,
            description: scoreTabDescription,
          ),
          const TabData(
            status: TabDataStatus.loading,
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          const TabData(
            status: TabDataStatus.loading,
            name: todayTabName,
            description: todayTabDescription,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: unseenTabName,
            description: unseenTabDescription,
            entries: [],
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: browseTabName,
            description: browseTabDescription,
            entries: [],
          ),
        ],
      ),
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData2,
        currentTabIndex: EntriesBloc.todayTabIndex,
        tabs: [
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: scoreTabName,
            description: scoreTabDescription,
            entries: [],
          ),
          const TabData(
            status: TabDataStatus.loading,
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: todayTabName,
            description: todayTabDescription,
            entries: todayEntries2,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: unseenTabName,
            description: unseenTabDescription,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: browseTabName,
            description: browseTabDescription,
            entries: [],
          ),
        ],
      ),
    ],
  );

  blocTest<EntriesBloc, EntriesState>(
    '''
    When PrepareTab(0) event is added and
    the already prepared entries for the score tab with an updated tabIndex
    is emmitted
    ''',
    build: buildBloc,
    seed: () => EntriesState(
      status: EntriesStatus.success,
      entriesPageData: entriesPageData1,
      currentTabIndex: EntriesBloc.unseenTabIndex,
      tabs: [
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: scoreTabName,
          description: scoreTabDescription,
          entries: scoreEntries1,
        ),
        const TabData(
          status: TabDataStatus.loading,
          name: strugglingTabName,
          description: strugglingTabDescription,
        ),
        const TabData(
          status: TabDataStatus.loading,
          name: todayTabName,
          description: todayTabDescription,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: unseenTabName,
          description: unseenTabDescription,
          entries: unseenEntries1,
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: browseTabName,
          description: browseTabDescription,
          entries: [],
        ),
      ],
    ),
    act: (bloc) => bloc.add(PrepareTab(EntriesBloc.scoreTabIndex, aDateTime)),
    expect: () => [
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData1,
        currentTabIndex: EntriesBloc.scoreTabIndex,
        tabs: [
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: scoreTabName,
            description: scoreTabDescription,
            entries: scoreEntries1,
          ),
          const TabData(
            status: TabDataStatus.loading,
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          const TabData(
            status: TabDataStatus.loading,
            name: todayTabName,
            description: todayTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: unseenTabName,
            description: unseenTabDescription,
            entries: unseenEntries1,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: browseTabName,
            description: browseTabDescription,
            entries: [],
          ),
        ],
      ),
    ],
  );

  blocTest<EntriesBloc, EntriesState>(
    '''
    When PrepareTab(1) event is added
    the entries is prepared for the struggling tab and 
    an updated state is emmitted
    ''',
    build: buildBloc,
    seed: () => EntriesState(
      status: EntriesStatus.success,
      entriesPageData: entriesPageData1,
      currentTabIndex: EntriesBloc.scoreTabIndex,
      tabs: [
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: scoreTabName,
          description: scoreTabDescription,
          entries: scoreEntries1,
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: strugglingTabName,
          description: strugglingTabDescription,
          entries: [],
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: todayTabName,
          description: todayTabDescription,
          entries: [],
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: unseenTabName,
          description: unseenTabDescription,
          entries: [],
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: browseTabName,
          description: browseTabDescription,
          entries: [],
        ),
      ],
    ),
    act: (bloc) =>
        bloc.add(PrepareTab(EntriesBloc.strugglingTabIndex, aDateTime)),
    wait: const Duration(milliseconds: 1),
    expect: () => [
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData1,
        currentTabIndex: EntriesBloc.strugglingTabIndex,
        tabs: [
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: scoreTabName,
            description: scoreTabDescription,
            entries: scoreEntries1,
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: strugglingEntries1,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: todayTabName,
            description: todayTabDescription,
            entries: [],
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: unseenTabName,
            description: unseenTabDescription,
            entries: [],
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: browseTabName,
            description: browseTabDescription,
            entries: [],
          ),
        ],
      ),
    ],
  );

  blocTest<EntriesBloc, EntriesState>(
    '''
    When PrepareTab(1) event is added and
    the already prepared entries for the struggling tab with an updated tabIndex
    is emmitted
    ''',
    build: buildBloc,
    seed: () => EntriesState(
      status: EntriesStatus.success,
      entriesPageData: entriesPageData1,
      currentTabIndex: EntriesBloc.unseenTabIndex,
      tabs: [
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: scoreTabName,
          description: scoreTabDescription,
          entries: scoreEntries1,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: strugglingTabName,
          description: strugglingTabDescription,
          entries: strugglingEntries1,
        ),
        const TabData(
          status: TabDataStatus.loading,
          name: todayTabName,
          description: todayTabDescription,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: unseenTabName,
          description: unseenTabDescription,
          entries: unseenEntries1,
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: browseTabName,
          description: browseTabDescription,
          entries: [],
        ),
      ],
    ),
    act: (bloc) =>
        bloc.add(PrepareTab(EntriesBloc.strugglingTabIndex, aDateTime)),
    expect: () => [
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData1,
        currentTabIndex: EntriesBloc.strugglingTabIndex,
        tabs: [
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: scoreTabName,
            description: scoreTabDescription,
            entries: scoreEntries1,
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: strugglingEntries1,
          ),
          const TabData(
            status: TabDataStatus.loading,
            name: todayTabName,
            description: todayTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: unseenTabName,
            description: unseenTabDescription,
            entries: unseenEntries1,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: browseTabName,
            description: browseTabDescription,
            entries: [],
          ),
        ],
      ),
    ],
  );

  blocTest<EntriesBloc, EntriesState>(
    '''
    When PrepareTab(2) event is added
    the entries is prepared for the today tab and 
    an updated state is emmitted
    ''',
    setUp: () {
      watchEntriesUsecase = MockWatchEntriesUsecase();
      when(
        () => watchEntriesUsecase.call(fieldListEntity.id!),
      ).thenAnswer((_) => Stream.value(entriesPageData2));
    },
    build: buildBloc,
    seed: () => EntriesState(
      status: EntriesStatus.success,
      entriesPageData: entriesPageData2,
      currentTabIndex: EntriesBloc.scoreTabIndex,
      tabs: [
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: scoreTabName,
          description: scoreTabDescription,
          entries: scoreEntries2,
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: strugglingTabName,
          description: strugglingTabDescription,
          entries: [],
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: todayTabName,
          description: todayTabDescription,
          entries: [],
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: unseenTabName,
          description: unseenTabDescription,
          entries: [],
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: browseTabName,
          description: browseTabDescription,
          entries: [],
        ),
      ],
    ),
    act: (bloc) => bloc.add(PrepareTab(EntriesBloc.todayTabIndex, aDateTime)),
    wait: const Duration(milliseconds: 1),
    expect: () => [
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData2,
        currentTabIndex: EntriesBloc.todayTabIndex,
        tabs: [
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: scoreTabName,
            description: scoreTabDescription,
            entries: scoreEntries2,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: [],
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: todayTabName,
            description: todayTabDescription,
            entries: todayEntries2,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: unseenTabName,
            description: unseenTabDescription,
            entries: [],
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: browseTabName,
            description: browseTabDescription,
            entries: [],
          ),
        ],
      ),
    ],
  );

  blocTest<EntriesBloc, EntriesState>(
    '''
    When PrepareTab(2) event is added and
    the already prepared entries for the today tab with an updated tabIndex
    is emmitted
    ''',
    build: buildBloc,
    seed: () => EntriesState(
      status: EntriesStatus.success,
      entriesPageData: entriesPageData1,
      currentTabIndex: EntriesBloc.unseenTabIndex,
      tabs: [
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: scoreTabName,
          description: scoreTabDescription,
          entries: scoreEntries1,
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: strugglingTabName,
          description: strugglingTabDescription,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: todayTabName,
          description: todayTabDescription,
          entries: todayEntries1,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: unseenTabName,
          description: unseenTabDescription,
          entries: unseenEntries1,
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: browseTabName,
          description: browseTabDescription,
          entries: [],
        ),
      ],
    ),
    act: (bloc) => bloc.add(PrepareTab(EntriesBloc.todayTabIndex, aDateTime)),
    expect: () => [
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData1,
        currentTabIndex: EntriesBloc.todayTabIndex,
        tabs: [
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: scoreTabName,
            description: scoreTabDescription,
            entries: scoreEntries1,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: todayTabName,
            description: todayTabDescription,
            entries: todayEntries1,
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: unseenTabName,
            description: unseenTabDescription,
            entries: unseenEntries1,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: browseTabName,
            description: browseTabDescription,
            entries: [],
          ),
        ],
      ),
    ],
  );

  blocTest<EntriesBloc, EntriesState>(
    '''
    When PrepareTab(3) event is added
    the entries is prepared for the today tab and 
    an updated state is emmitted
    ''',
    setUp: () {
      watchEntriesUsecase = MockWatchEntriesUsecase();
      when(
        () => watchEntriesUsecase.call(fieldListEntity.id!),
      ).thenAnswer((_) => Stream.value(entriesPageData3));
    },
    build: buildBloc,
    seed: () => EntriesState(
      status: EntriesStatus.success,
      entriesPageData: entriesPageData3,
      currentTabIndex: EntriesBloc.scoreTabIndex,
      tabs: [
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: scoreTabName,
          description: scoreTabDescription,
          entries: scoreEntries3,
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: strugglingTabName,
          description: strugglingTabDescription,
          entries: [],
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: todayTabName,
          description: todayTabDescription,
          entries: [],
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: unseenTabName,
          description: unseenTabDescription,
          entries: [],
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: browseTabName,
          description: browseTabDescription,
          entries: [],
        ),
      ],
    ),
    act: (bloc) => bloc.add(PrepareTab(EntriesBloc.unseenTabIndex, aDateTime)),
    wait: const Duration(milliseconds: 1),
    expect: () => [
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.unseenTabIndex,
        tabs: [
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: scoreTabName,
            description: scoreTabDescription,
            entries: scoreEntries3,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: [],
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: todayTabName,
            description: todayTabDescription,
            entries: [],
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: unseenTabName,
            description: unseenTabDescription,
            entries: unseenEntries3,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: browseTabName,
            description: browseTabDescription,
            entries: [],
          ),
        ],
      ),
    ],
  );

  blocTest<EntriesBloc, EntriesState>(
    '''
    When PrepareTab(3) event is added and
    the already prepared entries for the unseen tab with an updated tabIndex
    is emmitted
    ''',
    build: buildBloc,
    seed: () => EntriesState(
      status: EntriesStatus.success,
      entriesPageData: entriesPageData1,
      currentTabIndex: EntriesBloc.todayTabIndex,
      tabs: [
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: scoreTabName,
          description: scoreTabDescription,
          entries: scoreEntries1,
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: strugglingTabName,
          description: strugglingTabDescription,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: todayTabName,
          description: todayTabDescription,
          entries: todayEntries1,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: unseenTabName,
          description: unseenTabDescription,
          entries: unseenEntries1,
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: browseTabName,
          description: browseTabDescription,
          entries: [],
        ),
      ],
    ),
    act: (bloc) => bloc.add(PrepareTab(EntriesBloc.unseenTabIndex, aDateTime)),
    expect: () => [
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData1,
        currentTabIndex: EntriesBloc.unseenTabIndex,
        tabs: [
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: scoreTabName,
            description: scoreTabDescription,
            entries: scoreEntries1,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: todayTabName,
            description: todayTabDescription,
            entries: todayEntries1,
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: unseenTabName,
            description: unseenTabDescription,
            entries: unseenEntries1,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: browseTabName,
            description: browseTabDescription,
            entries: [],
          ),
        ],
      ),
    ],
  );

  blocTest<EntriesBloc, EntriesState>(
    '''
    When PrepareTab(4) event is added
    the entries is prepared for the today tab and 
    an updated state is emmitted
    ''',
    setUp: () {
      watchEntriesUsecase = MockWatchEntriesUsecase();
      when(
        () => watchEntriesUsecase.call(fieldListEntity.id!),
      ).thenAnswer((_) => Stream.value(entriesPageData3));
    },
    build: buildBloc,
    seed: () => EntriesState(
      status: EntriesStatus.success,
      entriesPageData: entriesPageData3,
      currentTabIndex: EntriesBloc.scoreTabIndex,
      tabs: [
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: scoreTabName,
          description: scoreTabDescription,
          entries: scoreEntries3,
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: strugglingTabName,
          description: strugglingTabDescription,
          entries: [],
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: todayTabName,
          description: todayTabDescription,
          entries: [],
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: unseenTabName,
          description: unseenTabDescription,
          entries: [],
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: browseTabName,
          description: browseTabDescription,
          entries: [],
        ),
      ],
    ),
    act: (bloc) => bloc.add(PrepareTab(EntriesBloc.browseTabIndex, aDateTime)),
    wait: const Duration(milliseconds: 1),
    expect: () => [
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData3,
        currentTabIndex: EntriesBloc.browseTabIndex,
        tabs: [
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: scoreTabName,
            description: scoreTabDescription,
            entries: scoreEntries3,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: [],
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: todayTabName,
            description: todayTabDescription,
            entries: [],
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: unseenTabName,
            description: unseenTabDescription,
            entries: [],
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: browseTabName,
            description: browseTabDescription,
            entries: browseEntries3,
          ),
        ],
      ),
    ],
  );

  blocTest<EntriesBloc, EntriesState>(
    '''
    When PrepareTab(4) event is added and
    the already prepared entries for the browse tab with an updated tabIndex
    is emmitted
    ''',
    build: buildBloc,
    seed: () => EntriesState(
      status: EntriesStatus.success,
      entriesPageData: entriesPageData1,
      currentTabIndex: EntriesBloc.todayTabIndex,
      tabs: [
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: scoreTabName,
          description: scoreTabDescription,
          entries: scoreEntries1,
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: strugglingTabName,
          description: strugglingTabDescription,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: todayTabName,
          description: todayTabDescription,
          entries: todayEntries1,
        ),
        const TabData(
          status: TabDataStatus.loading,
          outdated: true,
          name: unseenTabName,
          description: unseenTabDescription,
        ),
        TabData(
          status: TabDataStatus.ready,
          outdated: false,
          name: browseTabName,
          description: browseTabDescription,
          entries: browseEntries1,
        ),
      ],
    ),
    act: (bloc) => bloc.add(PrepareTab(EntriesBloc.browseTabIndex, aDateTime)),
    expect: () => [
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData1,
        currentTabIndex: EntriesBloc.browseTabIndex,
        tabs: [
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: scoreTabName,
            description: scoreTabDescription,
            entries: scoreEntries1,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: strugglingTabName,
            description: strugglingTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: todayTabName,
            description: todayTabDescription,
            entries: todayEntries1,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: unseenTabName,
            description: unseenTabDescription,
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: browseTabName,
            description: browseTabDescription,
            entries: browseEntries1,
          ),
        ],
      ),
    ],
  );

  blocTest<EntriesBloc, EntriesState>(
    'emits state with failure status '
    'when watchEntriesUsecase.call stream emits an error',
    build: buildBloc,
    setUp: () {
      when(
        () => watchEntriesUsecase.call(fieldListId),
      ).thenAnswer((_) => Stream.error(Exception('oops!')));
    },
    act: (bloc) => bloc.add(EntriesSubscriptionRequested(fieldListId)),
    expect: () => const [
      EntriesState(status: EntriesStatus.loading),
      EntriesState(status: EntriesStatus.failure),
    ],
  );

  blocTest<EntriesBloc, EntriesState>(
    'emits state with failure status '
    'when watchEntriesUsecase.call throws an exception',
    build: buildBloc,
    setUp: () {
      when(
        () => watchEntriesUsecase.call(fieldListId),
      ).thenThrow((_) => SqliteException(1, 'sqlexception'));
    },
    act: (bloc) => bloc.add(EntriesSubscriptionRequested(fieldListId)),
    expect: () => const [
      EntriesState(status: EntriesStatus.loading),
      EntriesState(status: EntriesStatus.failure),
    ],
  );
}
