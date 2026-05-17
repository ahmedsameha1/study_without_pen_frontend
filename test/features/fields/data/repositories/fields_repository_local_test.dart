import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository_local.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:uuid/uuid.dart';

class MockFieldsDao extends Mock implements FieldsDao {}

void main() {
  FieldsDao fieldsDao = MockFieldsDao();
  FieldsRepository fieldRepository = FieldsRepositoryLocal(fieldsDao);
  FieldEntity fieldEntity = FieldEntity(
    const Uuid().v4(),
    'wohfgowe',
    'field name',
    DateTime(2020, 1, 1),
    DateTime(2020, 1, 1),
    0,
    0xff520404,
  );
  test('create() throws when FieldsDao.create() throws', () {
    when(
      () => fieldsDao.create(
        FieldsCompanion(
          name: Value(fieldEntity.name),
          userAccountId: Value(fieldEntity.userAccountId),
          creationAt: Value(fieldEntity.creationAt),
          lastModificationAt: Value(fieldEntity.creationAt),
          usageCount: Value(fieldEntity.usageCount),
          color: Value(fieldEntity.color),
        ),
      ),
    ).thenThrow(
      SqliteException(extendedResultCode: 1, message: "sqlexception"),
    );
    expect(
      () => fieldRepository.create(fieldEntity),
      throwsA(
        predicate((e) => e is SqliteException && e.message == "sqlexception"),
      ),
    );
  });

  test('create() returns what FieldsDao.create() return', () async {
    when(
      () => fieldsDao.create(
        FieldsCompanion(
          name: Value(fieldEntity.name),
          userAccountId: Value(fieldEntity.userAccountId),
          creationAt: Value(fieldEntity.creationAt),
          lastModificationAt: Value(fieldEntity.creationAt),
          usageCount: Value(fieldEntity.usageCount),
          color: Value(fieldEntity.color),
        ),
      ),
    ).thenAnswer((_) => Future.value(1));
    int value = await fieldRepository.create(fieldEntity);
    expect(value, 1);
  });

  test('watch() throws what FieldsDao.watchByUserAccountId() throw', () {
    when(
      () => fieldsDao.watchByUserAccountId(fieldEntity.userAccountId),
    ).thenThrow(
      SqliteException(extendedResultCode: 1, message: 'sqlexception'),
    );
    expect(
      () => fieldRepository.watch(fieldEntity.userAccountId),
      throwsA(
        predicate((e) => e is SqliteException && e.message == 'sqlexception'),
      ),
    );
  });

  test(
    'watch() returns what FieldsDao.watchByUserAccountId() return',
    () async {
      when(
        () => fieldsDao.watchByUserAccountId(fieldEntity.userAccountId),
      ).thenAnswer(
        (_) => Stream.value([
          Field(
            id: fieldEntity.id!,
            userAccountId: fieldEntity.userAccountId,
            name: fieldEntity.name,
            creationAt: fieldEntity.creationAt,
            lastModificationAt: fieldEntity.creationAt,
            usageCount: fieldEntity.usageCount,
            color: fieldEntity.color,
          ),
        ]),
      );
      expect(
        fieldRepository.watch(fieldEntity.userAccountId),
        emitsInOrder([
          [fieldEntity],
        ]),
      );
    },
  );

  test('watchField() throws what FieldsDao.watchById throw', () {
    when(() => fieldsDao.watchById(fieldEntity.id!)).thenThrow(
      SqliteException(extendedResultCode: 1, message: 'sqlexception'),
    );
    expect(
      () => fieldRepository.watchField(fieldEntity.id!),
      throwsA(
        predicate((e) => e is SqliteException && e.message == "sqlexception"),
      ),
    );
  });

  test('watchField() returns what FieldsDao.watchById return', () {
    when(() => fieldsDao.watchById(fieldEntity.id!)).thenAnswer(
      (_) => Stream.value(
        Field(
          id: fieldEntity.id!,
          userAccountId: fieldEntity.userAccountId,
          name: fieldEntity.name,
          creationAt: fieldEntity.creationAt,
          lastModificationAt: fieldEntity.creationAt,
          usageCount: fieldEntity.usageCount,
          color: fieldEntity.color,
        ),
      ),
    );
    expect(
      fieldRepository.watchField(fieldEntity.id!),
      emitsInOrder(<FieldEntity?>[fieldEntity]),
    );

    when(
      () => fieldsDao.watchById(fieldEntity.id!),
    ).thenAnswer((_) => Stream.value(null));
    expect(
      fieldRepository.watchField(fieldEntity.id!),
      emitsInOrder(<FieldEntity?>[null]),
    );
  });

  test(
    'giveUserTheUserlessData() calls FieldsDao.giveUserTheUserlessData()',
    () {
      final userAccountId = const Uuid().v4();
      when(
        () => fieldsDao.giveUserTheUserlessData(userAccountId),
      ).thenAnswer((_) => Future.value());
      fieldRepository.giveUserTheUserlessData(userAccountId);
      verify(() => fieldsDao.giveUserTheUserlessData(userAccountId)).called(1);
    },
  );
}
