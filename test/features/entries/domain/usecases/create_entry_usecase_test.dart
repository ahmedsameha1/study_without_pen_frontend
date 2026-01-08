import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/entries/data/repositories/entries_repository.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/usecases/create_entry_usecase.dart';
import 'package:uuid/uuid.dart';

import 'watch_entries_usecase_test.dart';

void main() {
  EntriesRepository entriesRepository = MockEntriesRepository();
  CreateEntryUsecase createEntryUsecase = CreateEntryUsecase(entriesRepository);
  final fieldListId = const Uuid().v4();
  final answer = 'answer';
  final question = 'question';
  final order = 12;
  final rank = 2;
  DateTime creationAt = DateTime(2020, 1, 1);

  test('call() throws AssertionError when there is a validation error', () {
    expect(
      () => createEntryUsecase.call(
        fieldListId: fieldListId,
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

  test('call() throws what FieldRepository.create() throw', () {
    when(
      () => entriesRepository.create(
        EntryEntity(
          fieldListId: fieldListId,
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
          fieldListId: fieldListId,
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
          fieldListId: fieldListId,
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
          fieldListId: fieldListId,
          answer: answer,
          question: question,
          rank: rank,
          order: order,
        ),
        completion(1),
      );
    });
  });
}
