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
  FieldsRepository fieldsRepository = FieldsRepositoryLocal(fieldsDao);
  FieldEntity fieldEntity = FieldEntity(
    const Uuid().v4(),
    const Uuid().v4(),
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
      () => fieldsRepository.create(fieldEntity),
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
    int value = await fieldsRepository.create(fieldEntity);
    expect(value, 1);
  });

  test('watchField() throws what FieldsDao.watchById throw', () {
    when(() => fieldsDao.watchById(fieldEntity.id!)).thenThrow(
      SqliteException(extendedResultCode: 1, message: 'sqlexception'),
    );
    expect(
      () => fieldsRepository.watchField(fieldEntity.id!),
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
      fieldsRepository.watchField(fieldEntity.id!),
      emitsInOrder(<FieldEntity?>[fieldEntity]),
    );

    when(
      () => fieldsDao.watchById(fieldEntity.id!),
    ).thenAnswer((_) => Stream.value(null));
    expect(
      fieldsRepository.watchField(fieldEntity.id!),
      emitsInOrder(<FieldEntity?>[null]),
    );
  });

  test(
    'giveUserTheUserlessData() calls FieldsDao.giveUserTheUserlessData()',
    () {
      when(
        () => fieldsDao.giveUserTheUserlessData(fieldEntity.userAccountId),
      ).thenAnswer((_) => Future.value());
      fieldsRepository.giveUserTheUserlessData(fieldEntity.userAccountId);
      verify(
        () => fieldsDao.giveUserTheUserlessData(fieldEntity.userAccountId),
      ).called(1);
    },
  );

  group('watchWithFieldListsCountByUserAccountId', () {
    test(
      'throws when FieldsDao.watchWithFieldListsCountByUserAccountId() throw 1',
      () {
        when(
          () => fieldsDao.watchWithFieldListsCountByUserAccountId(
            fieldEntity.userAccountId,
          ),
        ).thenThrow(
          SqliteException(extendedResultCode: 1, message: 'sqlexception'),
        );
        expect(
          () => fieldsRepository.watchWithFieldListsCountByUserAccountId(
            fieldEntity.userAccountId,
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
      },
    );

    test(
      'throws when FieldsDao.watchWithFieldListsCountByUserAccountId() throw 2',
      () {
        when(
          () => fieldsDao.watchWithFieldListsCountByUserAccountId(
            fieldEntity.userAccountId,
          ),
        ).thenAnswer((_) => Stream.error('Not Found'));
        expect(
          fieldsRepository.watchWithFieldListsCountByUserAccountId(
            fieldEntity.userAccountId,
          ),
          emitsError(predicate((e) => e is String && e == 'Not Found')),
        );
      },
    );

    test(
      'returns what FieldsDao.watchWithFieldListsCountByUserAccountId() return',
      () {
        when(
          () => fieldsDao.watchWithFieldListsCountByUserAccountId(
            fieldEntity.userAccountId,
          ),
        ).thenAnswer(
          (_) => Stream.value([
            (
              Field(
                id: fieldEntity.id!,
                userAccountId: fieldEntity.userAccountId,
                name: fieldEntity.name,
                creationAt: fieldEntity.creationAt,
                lastModificationAt: fieldEntity.creationAt,
                usageCount: fieldEntity.usageCount,
                color: fieldEntity.color,
              ),
              3,
            ),
          ]),
        );
        expect(
          fieldsRepository.watchWithFieldListsCountByUserAccountId(
            fieldEntity.userAccountId,
          ),
          emits([(fieldEntity, 3)]),
        );
      },
    );
  });

  group('remove()', () {
    test('throws what FieldsDao.remove() throw 1', () {
      when(() => fieldsDao.remove(fieldEntity.id!)).thenThrow(
        SqliteException(extendedResultCode: 1, message: 'sqlexception'),
      );
      expect(
        () => fieldsRepository.remove(fieldEntity.id!),
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

    test('throws what FieldsDao.remove() throw 2', () {
      when(
        () => fieldsDao.remove(fieldEntity.id!),
      ).thenAnswer((_) => Future.error('Not Found'));
      expect(fieldsRepository.remove(fieldEntity.id!), throwsA('Not Found'));
    });

    test('returns what FieldsDao.remove() return', () {
      when(
        () => fieldsDao.remove(fieldEntity.id!),
      ).thenAnswer((_) => Future.value(1));
      expect(fieldsRepository.remove(fieldEntity.id!), completion(1));
    });
  });
}
