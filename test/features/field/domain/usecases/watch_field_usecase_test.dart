import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/field/data/repositories/field_repository.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/usecases/watch_field_usecase.dart';

class MockFieldRepository extends Mock implements FieldRepository {}

void main() {
  FieldRepository fieldRepository = MockFieldRepository();
  WatchFieldUsecase watchFieldUsecase = WatchFieldUsecase(fieldRepository);
  String fieldId = 'weoghwoeg';
  test('call() returns what FieldRepository.watchField() return', () {
    when(() => fieldRepository.watchField(fieldId))
        .thenThrow(SqliteException(1, 'sqlexception'));
    expect(
        () => watchFieldUsecase.call(fieldId),
        throwsA(predicate((e) =>
            e is SqliteException &&
            e.extendedResultCode == 1 &&
            e.message == 'sqlexception')));
  });
}
