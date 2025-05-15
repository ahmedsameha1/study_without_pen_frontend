import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/features/field/data/repositories/field_repository.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/models/field_entity.dart';

class FieldRepositoryLocal implements FieldRepository {
  FieldRepositoryLocal(this.fieldsDao);
  FieldsDao fieldsDao;
  @override
  Future<int> create(FieldEntity fieldEntity) {
    return fieldsDao.create(FieldsCompanion(
        userAccountId: Value(fieldEntity.userAccountId),
        name: Value(fieldEntity.name),
        creationAt: Value(fieldEntity.creationAt),
        lastModificationAt: Value(fieldEntity.lastModificationAt),
        usageCount: Value(fieldEntity.usageCount),
        color: Value(fieldEntity.color)));
  }
}
