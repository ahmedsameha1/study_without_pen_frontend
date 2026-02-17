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
      question: 'question',
      creationAt: aDateTime,
      lastModificationAt: aDateTime,
      askedCount: 4,
      wronglyAnsweredCount: 3,
      rank: Rank.important,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime,
      lastModificationAt: aDateTime,
      askedCount: 4,
      wronglyAnsweredCount: 2,
      rank: Rank.normal,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
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
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: aDateTime,
      lastModificationAt: aDateTime,
      askedCount: 0,
      wronglyAnsweredCount: 0,
      rank: Rank.vital,
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
    ),
  ];
  final List<EntryEntity> scoreEntries = [
    entries1[2],
    entries1[0],
    entries1[1],
  ];
  final List<EntryEntity> strugglingEntries = [entries1[2], entries1[0]];
  final List<EntryEntity> todayEntries = [entries2[1], entries2[2]];
  final List<EntryEntity> unseenEntries = [entries3[3], entries3[0]];
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
  late WatchEntriesUsecase watchEntriesUsecase;

  setUpAll(() {
    registerFallbackValue(FakeEntry());
    registerFallbackValue(FakeEntriesPageData());
  });

  setUp(() {
    watchEntriesUsecase = MockWatchEntriesUsecase();
    when(
      () => watchEntriesUsecase.call(fieldListEntity.id!),
    ).thenAnswer((_) => Stream.value(entriesPageData1));
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
    'when watchEntriesUsecase.call stream emits FieldListsPageData',
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
            entries: scoreEntries,
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
          entries: scoreEntries,
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
            entries: scoreEntries,
          ),
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: strugglingTabName,
            description: strugglingTabDescription,
            entries: strugglingEntries,
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
          entries: scoreEntries,
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
            entries: scoreEntries,
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
            entries: todayEntries,
          ),
          const TabData(
            status: TabDataStatus.loading,
            outdated: true,
            name: unseenTabName,
            description: unseenTabDescription,
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
          entries: scoreEntries,
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
            entries: scoreEntries,
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
            entries: unseenEntries,
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
