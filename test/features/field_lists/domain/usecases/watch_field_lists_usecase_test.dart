import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/watch_field_lists_usecase.dart';

class MockFieldListsRepository extends Mock implements FieldListsRepository {}

void main() {
  FieldListsRepository fieldListsRepository = MockFieldListsRepository();
  WatchFieldListsUsecase watchFieldListsUsecase =
      WatchFieldListsUsecase(fieldListsRepository);
  String fieldId = 'wthowow4tg3tg';
  test('call() throws what FieldListsRepository.watch() throw', () {
    when(() => fieldListsRepository.watch(fieldId))
        .thenThrow(SqliteException(1, 'sqlexception'));
    expect(
        () => watchFieldListsUsecase.call(fieldId),
        throwsA(predicate((e) =>
            e is SqliteException &&
            e.extendedResultCode == 1 &&
            e.message == 'sqlexception')));
  });
}
