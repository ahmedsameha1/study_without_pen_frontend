import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'app_database.dart';

part 'fields_dao.g.dart';

@DriftAccessor(tables: [Fields])
class FieldsDao extends DatabaseAccessor<AppDatabase> with _$FieldsDaoMixin {
  FieldsDao(super.appDatabase);
  Future<int> create(FieldsCompanion fieldsCompanion) {
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

  Stream<Field?> watchById(String id) => (select(
      fields,
    )..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();

  Stream<List<Field>> watchByUserAccountId(String id) => (select(fields)
          ..where((tbl) => tbl.userAccountId.equals(id))
          ..orderBy([
            (tbl) => OrderingTerm(
              expression: tbl.usageCount,
              mode: OrderingMode.desc,
            ),
          ]))
        .watch();

  Future<bool> mutate(FieldsCompanion fieldsCompanion) async {
    if (fieldsCompanion.creationAt.value.toUtc().isAfter(clock.now())) {
      throw InvalidDataException("creationAt");
    }
    if (fieldsCompanion.lastModificationAt.value.toUtc().isAfter(clock.now())) {
      throw InvalidDataException("lastModificationAt");
    }
    final Field? gotten = await watchById(fieldsCompanion.id.value).first;
    if (gotten != null &&
        (gotten.userAccountId != fieldsCompanion.userAccountId.value)) {
      throw InvalidDataException("Updating userAccountId");
    }
    return update(fields).replace(fieldsCompanion);
  }

  remove(String id) => (delete(fields)..where((tbl) => tbl.id.equals(id))).go();

  Future<void> giveUserTheUserlessData(String userAccountId) =>
      (update(fields)..where(
            (table) => table.userAccountId.equals(migrationUserAccountId),
          ))
          .write(FieldsCompanion(userAccountId: Value(userAccountId)));
}
