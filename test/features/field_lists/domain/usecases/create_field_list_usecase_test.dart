import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/create_field_list_usecase.dart';

class MockFieldListsRepository extends Mock implements FieldListsRepository {}

void main() {
  String fieldId = "woeghweo";
  String fieldListName = "field list name";
  CheckType checkType = CheckType.NON_STRICT_IGNORE_CASE;
  bool readAnswer = false;
  int color = Colors.white.toARGB32();
  DateTime creationAt = DateTime(2020, 1, 1);
  FieldListsRepository fieldListsRepository = MockFieldListsRepository();
  CreateFieldListUsecase createFieldListUsecase = CreateFieldListUsecase(
    fieldListsRepository,
  );

  test('call() throws AssertionError when there is a validation error', () {
    expect(
      () => createFieldListUsecase.call(
        fieldId,
        '',
        checkType,
        readAnswer,
        color,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message == 'FieldList name must be between 1 and 64 characters',
        ),
      ),
    );
  });

  test('call() throws what FieldRepository.create() throw', () {
    when(
      () => fieldListsRepository.create(
        FieldListEntity(
          fieldId: fieldId,
          name: fieldListName,
          checkType: checkType,
          doesReadAnswer: readAnswer,
          creationAt: creationAt,
          lastModificationAt: creationAt,
        ),
      ),
    ).thenThrow(SqliteException(1, 'sqlexception'));
    withClock(Clock.fixed(creationAt), () async {
      expect(
        () => createFieldListUsecase.call(
          fieldId,
          fieldListName,
          checkType,
          readAnswer,
          color,
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
      () => fieldListsRepository.create(
        FieldListEntity(
          fieldId: fieldId,
          name: fieldListName,
          checkType: checkType,
          doesReadAnswer: readAnswer,
          creationAt: creationAt,
          lastModificationAt: creationAt,
        ),
      ),
    ).thenAnswer((_) => Future.value(1));
    withClock(Clock.fixed(creationAt), () async {
      expectLater(
        createFieldListUsecase.call(
          fieldId,
          fieldListName,
          checkType,
          readAnswer,
          color,
        ),
        completion(1),
      );
    });
  });
}
