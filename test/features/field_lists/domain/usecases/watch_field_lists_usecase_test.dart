import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_lists_page_data.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/watch_field_lists_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';

import '../../../fields/domain/usecases/watch_field_usecase_test.dart';

class MockFieldListsRepository extends Mock implements FieldListsRepository {}

void main() {
  FieldListsRepository fieldListsRepository = MockFieldListsRepository();
  FieldsRepository fieldsRepository = MockFieldsRepository();
  WatchFieldListsUsecase watchFieldListsUsecase =
      WatchFieldListsUsecase(fieldsRepository, fieldListsRepository);
  String fieldId = 'wthowow4tg3tg';
  DateTime creationAt1 = DateTime(2020, 1, 1);
  DateTime creationAt2 = DateTime(2021, 1, 1);
  final fieldEntity = FieldEntity(fieldId, "woeghwiouegfwo", "field name1",
      creationAt1, creationAt2, 0, 0xff520404);
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
  test('call() throws what FieldListsRepository.watch() throw', () {
    when(() => fieldsRepository.watchField(fieldId))
        .thenAnswer((_) => Stream.empty());
    when(() => fieldListsRepository.watch(fieldId))
        .thenThrow(SqliteException(1, 'sqlexception1'));
    expect(
        () => watchFieldListsUsecase.call(fieldId),
        throwsA(predicate((e) =>
            e is SqliteException &&
            e.extendedResultCode == 1 &&
            e.message == 'sqlexception1')));
  });

  test('call() throws what FieldsRepository.watch() throw', () {
    when(() => fieldsRepository.watchField(fieldId))
        .thenThrow(SqliteException(2, 'sqlexception2'));
    when(() => fieldListsRepository.watch(fieldId))
        .thenAnswer((_) => Stream.empty());
    expect(
        () => watchFieldListsUsecase.call(fieldId),
        throwsA(predicate((e) =>
            e is SqliteException &&
            e.extendedResultCode == 2 &&
            e.message == 'sqlexception2')));
  });

  test(
      '''call() doesn't return a Stream of FieldListsPageData if any of '''
      '''FieldListsRepository.watch() and FieldsRepository.watch() return an empty Stream''',
      () {
    when(() => fieldsRepository.watchField(fieldId))
        .thenAnswer((_) => Stream.empty());
    when(() => fieldListsRepository.watch(fieldId))
        .thenAnswer((_) => Stream.value([fieldListEntity1]));
    expect(watchFieldListsUsecase.call(fieldId), emitsInOrder([]));

    ///
    when(() => fieldsRepository.watchField(fieldId))
        .thenAnswer((_) => Stream.value(fieldEntity));
    when(() => fieldListsRepository.watch(fieldId))
        .thenAnswer((_) => Stream.empty());
    expect(watchFieldListsUsecase.call(fieldId), emitsInOrder([]));
  });

  test(
      '''call() returns a Stream of FieldListsPageData with what '''
      '''FieldListsRepository.watch() and FieldsRepository.watch() return''',
      () {
    when(() => fieldListsRepository.watch(fieldId))
        .thenAnswer((_) => Stream.fromIterable([
              [fieldListEntity1],
              [fieldListEntity1, fieldListEntity2],
              [fieldListEntity2],
            ]));
    when(() => fieldsRepository.watchField(fieldId)).thenAnswer(
        (_) => Stream.fromIterable([fieldEntity]));
    expect(
        watchFieldListsUsecase.call(fieldId),
        emitsInOrder([
          FieldListsPageData(
              field: fieldEntity, fieldLists: [fieldListEntity1]),
          FieldListsPageData(
              field: fieldEntity,
              fieldLists: [fieldListEntity1, fieldListEntity2]),
          FieldListsPageData(
              field: fieldEntity, fieldLists: [fieldListEntity2]),
        ]));
  });
}
