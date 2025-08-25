import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';

class FieldsRepositoryLocal implements FieldsRepository {
  FieldsRepositoryLocal(this._fieldsDao);
  final FieldsDao _fieldsDao;
  @override
  Future<int> create(FieldEntity fieldEntity) {
    return _fieldsDao.create(FieldsCompanion(
        userAccountId: Value(fieldEntity.userAccountId),
        name: Value(fieldEntity.name),
        creationAt: Value(fieldEntity.creationAt),
        lastModificationAt: Value(fieldEntity.lastModificationAt),
        usageCount: Value(fieldEntity.usageCount),
        color: Value(fieldEntity.color)));
  }

  @override
  Stream<List<FieldEntity>> watch(String userAccountId) {
    return _fieldsDao.watchByUserAccountId(userAccountId).map((list) => list
        .map((field) => FieldEntity(
            field.id,
            field.userAccountId,
            field.name,
            field.creationAt,
            field.lastModificationAt,
            field.usageCount,
            field.color))
        .toList());
  }

  @override
  Stream<FieldEntity?> watchField(String fieldId) {
    return _fieldsDao.watchById(fieldId).map((field) {
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
            field.color);
      }
    });
  }
}
