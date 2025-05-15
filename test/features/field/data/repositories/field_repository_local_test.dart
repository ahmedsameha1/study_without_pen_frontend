import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/features/field/data/repositories/field_repository.dart';
import 'package:study_without_pen_by_flutter/features/field/data/repositories/field_repository_local.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/models/field_entity.dart';

class MockFieldsDao extends Mock implements FieldsDao {}

void main() {
  FieldsDao fieldsDao = MockFieldsDao();
  FieldRepository fieldRepository = FieldRepositoryLocal(fieldsDao);
  DateTime creationAt = DateTime(2020, 1, 1);
  final userAccountId = 'wohfgowe';
  late String name = 'field name';
  final usageCount = 0;
  int color = 0xff520404;
  FieldEntity fieldEntity = FieldEntity(
      null, userAccountId, name, creationAt, creationAt, usageCount, color);
  test('create() throws when FieldsDao.create() throws', () {
    when(() => fieldsDao.create(FieldsCompanion(
        name: Value(name),
        userAccountId: Value(userAccountId),
        creationAt: Value(creationAt),
        lastModificationAt: Value(creationAt),
        usageCount: Value(usageCount),
        color: Value(color)))).thenThrow(SqliteException(1, "sqlexception"));
    expect(
        () => fieldRepository.create(fieldEntity),
        throwsA(predicate(
            (e) => e is SqliteException && e.message == "sqlexception")));
  });

  test('create() returns what FieldsDao.create() return', () async {
    when(() => fieldsDao.create(FieldsCompanion(
        name: Value(name),
        userAccountId: Value(userAccountId),
        creationAt: Value(creationAt),
        lastModificationAt: Value(creationAt),
        usageCount: Value(usageCount),
        color: Value(color)))).thenAnswer((_) => Future.value(1));
    int value = await fieldRepository.create(fieldEntity);
    expect(value, 1);
  });
}
