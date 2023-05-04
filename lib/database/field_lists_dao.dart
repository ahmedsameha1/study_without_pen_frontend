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
  }
}
