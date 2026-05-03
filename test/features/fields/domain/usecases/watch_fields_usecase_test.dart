import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_fields_usecase.dart';

class MockFieldRepository extends Mock implements FieldsRepository {}

void main() {
  FieldsRepository fieldRepository = MockFieldRepository();
  WatchFieldsUsecase watchFieldsUsecase = WatchFieldsUsecase(fieldRepository);
  final userAccountId = "fwefhwo";
  test('call() throws what FieldRepository.watch() throw', () {
    when(() => fieldRepository.watch(userAccountId)).thenThrow(
      SqliteException(extendedResultCode: 1, message: 'sqlexception'),
    );
    expect(
      () => watchFieldsUsecase.call(userAccountId),
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

  test('call() returns what FieldRepository.watch() return', () {
    final id = "wefohweo";
    String name = "field name";
    final usageCount = 0;
    int color = 0xff520404;
    DateTime creationAt = DateTime(2020, 1, 1);
    when(() => fieldRepository.watch(userAccountId)).thenAnswer(
      (_) => Stream.value([
        FieldEntity(
          id,
          userAccountId,
          name,
          creationAt,
          creationAt,
          usageCount,
          color,
        ),
      ]),
    );
    expect(
      watchFieldsUsecase.call(userAccountId),
      emitsInOrder([
        [
          FieldEntity(
            id,
            userAccountId,
            name,
            creationAt,
            creationAt,
            usageCount,
            color,
          ),
        ],
      ]),
    );
  });
}
