import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part 'fields_dao.g.dart';

@DriftAccessor(tables: [Fields])
class FieldsDao extends DatabaseAccessor<AppDatabase> with _$FieldsDaoMixin {
  FieldsDao(AppDatabase appDatabase) : super(appDatabase);
  create(FieldsCompanion fieldsCompanion) {
    if (fieldsCompanion.id.present && !isValid(fieldsCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (fieldsCompanion.creationAt.value.toUtc().isAfter(clock.now())) {
      throw InvalidDataException("creationAt");
    }
    if (fieldsCompanion.lastModificationAt.value.toUtc().isAfter(clock.now())) {
      throw InvalidDataException("lastModificationAt");
    }
    return into(fields).insert(fieldsCompanion);
  }

  Future<Field?> getById(String id) {
    return (select(fields)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Stream<List<Field>> watchByUserAccountId(String id) {
    return (select(fields)
          ..where((tbl) => tbl.userAccountId.equals(id))
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: tbl.usageCount, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  Future<bool> mutate(FieldsCompanion fieldsCompanion) {
    return update(fields).replace(fieldsCompanion);
  }
}
