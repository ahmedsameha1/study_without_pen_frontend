import 'package:drift/drift.dart';

import 'app_database.dart';

part 'field_lists_dao.g.dart';

@DriftAccessor(tables: [FieldLists])
class FieldListsDao extends DatabaseAccessor<AppDatabase>
    with _$FieldListsDaoMixin {
  FieldListsDao(AppDatabase appDatabase) : super(appDatabase);
  create(FieldListsCompanion fieldListsCompanion) {
    if (fieldListsCompanion.id.present &&
        !isValid(fieldListsCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (!isValid(fieldListsCompanion.fieldId.value)) {
      throw InvalidDataException("fieldId");
    }
    if (!isValidCheckType(fieldListsCompanion.checkType.value)) {
      throw InvalidDataException("checkType");
    }
    return into(fieldLists).insert(fieldListsCompanion);
  }
}

enum CheckType {
  NON_STRICT_IGNORE_CASE,
  NON_STRICT_DO_NOT_IGNORE_CASE,
  IGNORE_CASE,
  DO_NOT_IGNORE_CASE,
  MAX
}

bool isValidCheckType(int checkType) {
  return checkType >= 0 && checkType < CheckType.MAX.index;
}
