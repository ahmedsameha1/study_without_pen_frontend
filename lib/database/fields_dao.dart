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
    return into(fields).insert(fieldsCompanion);
  }
}
