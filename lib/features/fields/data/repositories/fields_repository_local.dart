import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';
import '../../../../database/fields_dao.dart';
import '../../domain/models/field_entity.dart';
import 'fields_repository.dart';

class FieldsRepositoryLocal implements FieldsRepository {
  FieldsRepositoryLocal(this._fieldsDao);
  final FieldsDao _fieldsDao;
  @override
  Future<int> create(FieldEntity fieldEntity) => _fieldsDao.create(
    FieldsCompanion(
      userAccountId: Value(fieldEntity.userAccountId),
      name: Value(fieldEntity.name),
      creationAt: Value(fieldEntity.creationAt),
      lastModificationAt: Value(fieldEntity.lastModificationAt),
      usageCount: Value(fieldEntity.usageCount),
      color: Value(fieldEntity.color),
    ),
  );

  @override
  Stream<FieldEntity?> watchField(String fieldId) =>
      _fieldsDao.watchById(fieldId).map((field) {
        if (field == null) {
          return null;
        } else {
          return FieldEntity(
            field!.id,
            field.userAccountId,
            field.name,
            field.creationAt,
            field.lastModificationAt,
            field.usageCount,
            field.color,
          );
        }
      });

  @override
  Future<void> giveUserTheUserlessData(String userAccountId) =>
      _fieldsDao.giveUserTheUserlessData(userAccountId);

  Stream<List<(FieldEntity, int)>> watchWithFieldListsCountByUserAccountId(
    String userAccountId,
  ) => _fieldsDao
      .watchWithFieldListsCountByUserAccountId(userAccountId)
      .map(
        (List<(Field, int)> list) => list
            .map(
              (record) => (
                FieldEntity(
                  record.$1.id,
                  record.$1.userAccountId,
                  record.$1.name,
                  record.$1.creationAt,
                  record.$1.lastModificationAt,
                  record.$1.usageCount,
                  record.$1.color,
                ),
                record.$2,
              ),
            )
            .toList(),
      );

  Future<int> remove(String fieldId) => _fieldsDao.remove(fieldId);
}
