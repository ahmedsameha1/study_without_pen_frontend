import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/delete_field_usecase.dart';
import 'package:uuid/uuid.dart';

class MockFieldRepository extends Mock implements FieldsRepository {}

void main() {
  DateTime creationAt = DateTime(2020, 1, 1);
  final userAccountId = 'wohfgowe';
  late String name;
  final usageCount = 0;
  int color = 0xff520404;
  String fieldId = const Uuid().v4();
  FieldsRepository fieldRepository = MockFieldRepository();
  DeleteFieldUsecase deleteFieldUsecase = DeleteFieldUsecase(fieldRepository);

  group('call()', () {
    test('throws what FieldsRepository.remove() throw 1', () {
      name = 'field name';
      when(() => fieldRepository.remove(fieldId)).thenThrow(
        SqliteException(extendedResultCode: 1, message: 'sqlexception'),
      );
      expect(
        () => deleteFieldUsecase.call(fieldId),
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

    test('throws what FieldsRepository.remove() throw 2', () {
      when(
        () => fieldRepository.remove(fieldId),
      ).thenAnswer((_) => Future.error('Not Found'));
      expect(deleteFieldUsecase.call(fieldId), throwsA('Not Found'));
    });

    test('returns what FieldsRepository.remove() return', () {
      when(
        () => fieldRepository.remove(fieldId),
      ).thenAnswer((_) => Future.value(1));
      expect(deleteFieldUsecase.call(fieldId), completion(1));
    });
  });
}
