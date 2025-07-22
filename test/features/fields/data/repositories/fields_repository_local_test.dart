import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository_local.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';

class MockFieldsDao extends Mock implements FieldsDao {}

void main() {
  FieldsDao fieldsDao = MockFieldsDao();
  FieldsRepository fieldRepository = FieldsRepositoryLocal(fieldsDao);
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

  test('watch() throws what FieldsDao.watchByUserAccountId() throw', () {
    when(() => fieldsDao.watchByUserAccountId(userAccountId))
        .thenThrow(SqliteException(1, 'sqlexception'));
    expect(
        () => fieldRepository.watch(userAccountId),
        throwsA(predicate(
            (e) => e is SqliteException && e.message == 'sqlexception')));
  });

  test('watch() returns what FieldsDao.watchByUserAccountId() return',
      () async {
    when(() => fieldsDao.watchByUserAccountId(userAccountId))
        .thenAnswer((_) => Stream.value([
              Field(
                  id: "field id",
                  userAccountId: userAccountId,
                  name: name,
                  creationAt: creationAt,
                  lastModificationAt: creationAt,
                  usageCount: usageCount,
                  color: color)
            ]));
    expect(
        fieldRepository.watch(userAccountId),
        emitsInOrder([
          [
            FieldEntity('field id', userAccountId, name, creationAt, creationAt,
                usageCount, color)
          ]
        ]));
  });
}
