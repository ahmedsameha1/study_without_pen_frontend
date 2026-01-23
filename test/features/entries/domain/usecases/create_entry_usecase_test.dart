import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/entries/data/repositories/entries_repository.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/usecases/create_entry_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:uuid/uuid.dart';

class MockEntriesRepository extends Mock implements EntriesRepository {}

class MockFieldListsRepository extends Mock implements FieldListsRepository {}

void main() {
  EntriesRepository entriesRepository = MockEntriesRepository();
  FieldListsRepository fieldListsRepository = MockFieldListsRepository();
  CreateEntryUsecase createEntryUsecase = CreateEntryUsecase(
    fieldListsRepository,
    entriesRepository,
  );
  final answer = 'answer';
  final question = 'question';
  final order = 12;
  final rank = 2;
  DateTime creationAt = DateTime(2020, 1, 1);
  FieldListEntity fieldListEntity = FieldListEntity(
    id: const Uuid().v4(),
    fieldId: const Uuid().v4(),
    name: 'fieldListName',
    creationAt: creationAt.subtract(Duration(days: 2)),
    lastModificationAt: creationAt.subtract(Duration(days: 1)),
  );

  test('call() throws AssertionError when there is a validation error', () {
    expect(
      () => createEntryUsecase.call(
        fieldListId: fieldListEntity.id!,
        answer: '',
        question: question,
        rank: rank,
        order: order,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message == 'answer must be between 1 and 2000 characters',
        ),
      ),
    );
  });

  test('call() throws what EntriesRepository.create() throw', () {
    when(
      () => entriesRepository.create(
        EntryEntity(
          fieldListId: fieldListEntity.id!,
          answer: answer,
          question: question,
          rank: rank,
          order: order,
          creationAt: creationAt,
          lastModificationAt: creationAt,
        ),
      ),
    ).thenThrow(SqliteException(1, 'sqlexception'));
    withClock(Clock.fixed(creationAt), () async {
      expect(
        () => createEntryUsecase.call(
          fieldListId: fieldListEntity.id!,
          answer: answer,
          question: question,
          rank: rank,
          order: order,
        ),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception',
          ),
        ),
      );
    });
  });

  test('call() success', () {
    when(
      () => entriesRepository.create(
        EntryEntity(
          fieldListId: fieldListEntity.id!,
          answer: answer,
          question: question,
          rank: rank,
          order: order,
          creationAt: creationAt,
          lastModificationAt: creationAt,
        ),
      ),
    ).thenAnswer((_) => Future.value(1));
    withClock(Clock.fixed(creationAt), () async {
      expectLater(
        createEntryUsecase.call(
          fieldListId: fieldListEntity.id!,
          answer: answer,
          question: question,
          rank: rank,
          order: order,
        ),
        completion(1),
      );
    });
  });

  test(
    'watchFieldList() throws what FieldListsRepository.watchFieldList throw',
    () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListEntity.id!),
      ).thenThrow(SqliteException(1, 'sqlexception'));
      expect(
        () => createEntryUsecase.watchFieldList(fieldListEntity.id!),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception',
          ),
        ),
      );
    },
  );

  test(
    'watchFieldList() returns what FieldListsRepository.watchFieldList() return',
    () {
      when(
        () => fieldListsRepository.watchFieldList(fieldListEntity.id!),
      ).thenAnswer((_) => Stream.value(fieldListEntity));
      expect(
        createEntryUsecase.watchFieldList(fieldListEntity.id!),
        emitsInOrder([fieldListEntity]),
      );
    },
  );
}
