import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository_local.dart';

class MockFieldListsDao extends Mock implements FieldListsDao {}

void main() {
  FieldListsDao fieldListsDao = MockFieldListsDao();
  FieldListsRepository fieldListsRepository =
      FieldListsRepositoryLocal(fieldListsDao);
  String fieldId = "owefhweo";
  test('watch() throws what fieldListsDao.watchByFieldId() throw', () {
    when(() => fieldListsDao.watchByFieldId(fieldId))
        .thenThrow(SqliteException(1, 'sqlexception'));
    expect(
        () => fieldListsRepository.watch(fieldId),
        throwsA(predicate(
            (e) => e is SqliteException && e.message == 'sqlexception')));
  });
}
