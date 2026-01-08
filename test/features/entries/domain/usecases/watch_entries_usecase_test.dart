import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/entries/data/repositories/entries_repository.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entries_page_data.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/usecases/watch_entries_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:uuid/uuid.dart';

class MockEntriesRepository extends Mock implements EntriesRepository {}

class MockFieldListsRepository extends Mock implements FieldListsRepository {}

void main() {
  DateTime fieldListDateTime = DateTime(2025);
  final fieldListId = const Uuid().v4();
  final entry1Id = const Uuid().v4();
  final entry2Id = const Uuid().v4();
  final entry3Id = const Uuid().v4();
  FieldListEntity fieldListEntity = FieldListEntity(
    id: fieldListId,
    fieldId: const Uuid().v4(),
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
  EntriesRepository entriesRepository = MockEntriesRepository();
  FieldListsRepository fieldListsRepository = MockFieldListsRepository();
  WatchEntriesUsecase watchEntriesUsecase = WatchEntriesUsecase(
    fieldListsRepository,
    entriesRepository,
  );
  test('call() throws what EntriesRepository.watch() throw', () {
    when(
      () => fieldListsRepository.watchFieldList(fieldListId),
    ).thenAnswer((_) => Stream.empty());
    when(
      () => entriesRepository.watch(fieldListId),
    ).thenThrow(SqliteException(1, 'sqlexception1'));
    expect(
      () => watchEntriesUsecase.call(fieldListId),
      throwsA(
        predicate(
          (e) =>
              e is SqliteException &&
              e.extendedResultCode == 1 &&
              e.message == 'sqlexception1',
        ),
      ),
    );
  });

  test('call() throws what FieldListsRepository.watchFieldList() throw', () {
    when(
      () => fieldListsRepository.watchFieldList(fieldListId),
    ).thenThrow(SqliteException(1, 'sqlexception1'));
    when(
      () => entriesRepository.watch(fieldListId),
    ).thenAnswer((_) => Stream.empty());
    expect(
      () => watchEntriesUsecase.call(fieldListId),
      throwsA(
        predicate(
          (e) =>
              e is SqliteException &&
              e.extendedResultCode == 1 &&
              e.message == 'sqlexception1',
        ),
      ),
    );
  });

  test(
    '''call() doesn't return a Stream of EntriesPageData if any of '''
    '''FieldListsRepository.watchFieldList() and EntriesRepository.watch() return an empty Stream''',
    () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenAnswer((_) => Stream.empty());
      when(
        () => entriesRepository.watch(fieldListId),
      ).thenAnswer((_) => Stream.value(entries));
      expect(watchEntriesUsecase.call(fieldListId), emitsInOrder([]));

      ///
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenAnswer((_) => Stream.value(fieldListEntity));
      when(
        () => entriesRepository.watch(fieldListId),
      ).thenAnswer((_) => Stream.empty());
      expect(watchEntriesUsecase.call(fieldListId), emitsInOrder([]));
    },
  );

  test(
    '''call() returns a Stream of EntriesPageData with what '''
    '''entriesRepository.watch() and fieldListsRepository.watchFieldList() return''',
    () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListId),
      ).thenAnswer((_) => Stream.fromIterable([fieldListEntity]));
      when(() => entriesRepository.watch(fieldListId)).thenAnswer(
        (_) => Stream.fromIterable([
          [entries[0]],
          [entries[0], entries[1]],
          [entries[1]],
        ]),
      );
      expect(
        watchEntriesUsecase.call(fieldListId),
        emitsInOrder([
          EntriesPageData(fieldList: fieldListEntity, entries: [entries[0]]),
          EntriesPageData(
            fieldList: fieldListEntity,
            entries: [entries[0], entries[1]],
          ),
          EntriesPageData(fieldList: fieldListEntity, entries: [entries[1]]),
        ]),
      );
    },
  );
}
