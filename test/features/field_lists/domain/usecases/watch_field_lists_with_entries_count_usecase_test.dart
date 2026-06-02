import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_lists_page_data.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/watch_field_lists_with_entries_count_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';

import '../../../fields/domain/usecases/watch_field_usecase_test.dart';

class MockFieldListsRepository extends Mock implements FieldListsRepository {}

void main() {
  FieldListsRepository fieldListsRepository = MockFieldListsRepository();
  FieldsRepository fieldsRepository = MockFieldsRepository();
  WatchFieldListsWithEntriesCountUsecase
  watchFieldListsWithEntriesCountUsecase =
      WatchFieldListsWithEntriesCountUsecase(
        fieldsRepository,
        fieldListsRepository,
      );
  String fieldId = 'wthowow4tg3tg';
  DateTime creationAt1 = DateTime(2020, 1, 1);
  DateTime creationAt2 = DateTime(2021, 1, 1);
  final fieldEntity = FieldEntity(
    fieldId,
    "woeghwiouegfwo",
    "field name1",
    creationAt1,
    creationAt2,
    0,
    0xff520404,
  );
  final fieldListEntity1 = FieldListEntity(
    id: "woeghghefgwoegho",
    fieldId: fieldId,
    name: "field list name1",
    creationAt: creationAt1,
    lastModificationAt: creationAt2,
  );
  final fieldListEntity2 = FieldListEntity(
    id: "woeghhefgweho",
    fieldId: fieldId,
    name: "field list name2",
    creationAt: creationAt1,
    lastModificationAt: creationAt2,
  );
  test(
    'call() throws what FieldListsRepository.watchWithEntriesCountByFieldId() throw 1',
    () {
      when(
        () => fieldsRepository.watchField(fieldId),
      ).thenAnswer((_) => Stream.empty());
      when(
        () => fieldListsRepository.watchWithEntriesCountByFieldId(fieldId),
      ).thenThrow(
        SqliteException(extendedResultCode: 1, message: 'sqlexception1'),
      );
      expect(
        () => watchFieldListsWithEntriesCountUsecase.call(fieldId),
        throwsA(
          predicate(
            (e) =>
                e is SqliteException &&
                e.extendedResultCode == 1 &&
                e.message == 'sqlexception1',
          ),
        ),
      );
    },
  );

  test(
    'call() throws what FieldListsRepository.watchWithEntriesCountByFieldId() throw 2',
    () {
      when(
        () => fieldsRepository.watchField(fieldId),
      ).thenAnswer((_) => Stream.empty());
      when(
        () => fieldListsRepository.watchWithEntriesCountByFieldId(fieldId),
      ).thenAnswer((_) => Stream.error('Not Found'));
      expect(
        watchFieldListsWithEntriesCountUsecase.call(fieldId),
        emitsError(predicate((e) => e is String && e == 'Not Found')),
      );
    },
  );

  test('call() throws what FieldsRepository.watchField() throw 1', () {
    when(() => fieldsRepository.watchField(fieldId)).thenThrow(
      SqliteException(extendedResultCode: 2, message: 'sqlexception2'),
    );
    when(
      () => fieldListsRepository.watchWithEntriesCountByFieldId(fieldId),
    ).thenAnswer((_) => Stream.empty());
    expect(
      () => watchFieldListsWithEntriesCountUsecase.call(fieldId),
      throwsA(
        predicate(
          (e) =>
              e is SqliteException &&
              e.extendedResultCode == 2 &&
              e.message == 'sqlexception2',
        ),
      ),
    );
  });

  test('call() throws what FieldsRepository.watchField() throw 2', () {
    when(
      () => fieldsRepository.watchField(fieldId),
    ).thenAnswer((_) => Stream.error('Not Found'));
    when(
      () => fieldListsRepository.watchWithEntriesCountByFieldId(fieldId),
    ).thenAnswer((_) => Stream.empty());
    expect(
      watchFieldListsWithEntriesCountUsecase.call(fieldId),
      emitsError(predicate((e) => e is String && e == 'Not Found')),
    );
  });

  test(
    '''call() doesn't return a Stream of FieldListsPageData if any of '''
    '''FieldListsRepository.watchWithEntriesCountByFieldId() and FieldsRepository.watchField() return an empty Stream''',
    () {
      when(
        () => fieldsRepository.watchField(fieldId),
      ).thenAnswer((_) => Stream.empty());
      when(
        () => fieldListsRepository.watchWithEntriesCountByFieldId(fieldId),
      ).thenAnswer((_) => Stream.value([(fieldListEntity1, 3)]));
      expect(
        watchFieldListsWithEntriesCountUsecase.call(fieldId),
        emitsInOrder([]),
      );

      ///
      when(
        () => fieldsRepository.watchField(fieldId),
      ).thenAnswer((_) => Stream.value(fieldEntity));
      when(
        () => fieldListsRepository.watchWithEntriesCountByFieldId(fieldId),
      ).thenAnswer((_) => Stream.empty());
      expect(
        watchFieldListsWithEntriesCountUsecase.call(fieldId),
        emitsInOrder([]),
      );
    },
  );

  test(
    '''call() returns a Stream of FieldListsPageData with what '''
    '''FieldListsRepository.watchWithEntriesCountByFieldId() and FieldsRepository.watchField() return''',
    () {
      when(
        () => fieldListsRepository.watchWithEntriesCountByFieldId(fieldId),
      ).thenAnswer(
        (_) => Stream.fromIterable([
          [(fieldListEntity1, 3)],
          [(fieldListEntity1, 3), (fieldListEntity2, 2)],
          [(fieldListEntity2, 2)],
        ]),
      );
      when(
        () => fieldsRepository.watchField(fieldId),
      ).thenAnswer((_) => Stream.fromIterable([fieldEntity]));
      expect(
        watchFieldListsWithEntriesCountUsecase.call(fieldId),
        emitsInOrder([
          FieldListsPageData(
            field: fieldEntity,
            fieldListsWithEntriesCount: [(fieldListEntity1, 3)],
          ),
          FieldListsPageData(
            field: fieldEntity,
            fieldListsWithEntriesCount: [
              (fieldListEntity1, 3),
              (fieldListEntity2, 2),
            ],
          ),
          FieldListsPageData(
            field: fieldEntity,
            fieldListsWithEntriesCount: [(fieldListEntity2, 2)],
          ),
        ]),
      );
    },
  );
}
