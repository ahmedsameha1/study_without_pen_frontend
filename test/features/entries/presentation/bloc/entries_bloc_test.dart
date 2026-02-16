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
      askedCount: 4,
      wronglyAnsweredCount: 1,
      rank: Rank.important,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
      askedCount: 4,
      wronglyAnsweredCount: 1,
      rank: Rank.normal,
    ),
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
      askedCount: 4,
      wronglyAnsweredCount: 1,
      rank: Rank.vital,
    ),
  ];
  final List<EntryEntity> scoreEntries = [
    EntryEntity(
      id: entry3Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
      askedCount: 4,
      wronglyAnsweredCount: 1,
      rank: Rank.vital,
    ),
    EntryEntity(
      id: entry1Id,
      fieldListId: fieldListId,
      answer: 'answer1',
      question: 'question',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
      askedCount: 4,
      wronglyAnsweredCount: 1,
      rank: Rank.important,
    ),
    EntryEntity(
      id: entry2Id,
      fieldListId: fieldListId,
      answer: 'answer',
      question: 'question',
      creationAt: fieldListDateTime,
      lastModificationAt: fieldListDateTime,
      askedCount: 4,
      wronglyAnsweredCount: 1,
      rank: Rank.normal,
    ),
  ];
  EntriesPageData entriesPageData = EntriesPageData(
    fieldList: fieldListEntity,
    entries: entries,
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
    ).thenAnswer((_) => Stream.value(entriesPageData));
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
        entriesPageData: entriesPageData,
        currentTabIndex: 0,
        tabs: [
          const TabData(
            status: TabDataStatus.loading,
            name: scoreTabName,
            description: scoreTabDescription,
          ),
        ],
      ),
      EntriesState(
        status: EntriesStatus.success,
        entriesPageData: entriesPageData,
        currentTabIndex: 0,
        tabs: [
          TabData(
            status: TabDataStatus.ready,
            outdated: false,
            name: scoreTabName,
            description: scoreTabDescription,
            entries: scoreEntries,
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
