import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/create_field_usecase.dart';

class MockFieldRepository extends Mock implements FieldsRepository {}

void main() {
  DateTime creationAt = DateTime(2020, 1, 1);
  final userAccountId = 'wohfgowe';
  late String name;
  final usageCount = 0;
  int color = 0xff520404;
  FieldsRepository fieldRepository = MockFieldRepository();
  final usecase = CreateFieldUseCase(fieldRepository);

  test('call() throws AssertionError when there is a validation error', () {
    name = "";
    expect(
        () => usecase.call(userAccountId, name, color),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message == 'Field name must be between 1 and 64 characters')));
  });

  test('call() throws what FieldRepository.create() throw', () {
    name = 'field name';
    when(() => fieldRepository.create(FieldEntity(
        null,
        userAccountId,
        name,
        creationAt,
        creationAt,
        usageCount,
        color))).thenThrow(SqliteException(1, 'sqlexception'));
    withClock(Clock.fixed(creationAt), () async {
      expect(
          () => usecase.call(userAccountId, name, color),
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.extendedResultCode == 1 &&
              e.message == 'sqlexception')));
    });
  });

  test('call() success', () {
    name = 'field name';
    when(() => fieldRepository.create(FieldEntity(
        null,
        userAccountId,
        name,
        creationAt,
        creationAt,
        usageCount,
        color))).thenAnswer((_) => Future.value(1));
    withClock(Clock.fixed(creationAt), () async {
      expect(() => usecase.call(userAccountId, name, color), returnsNormally);
    });
  });
}
