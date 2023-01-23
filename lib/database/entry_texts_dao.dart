import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:uuid/uuid.dart';

part 'entry_texts_dao.g.dart';

@DriftAccessor(tables: [EntryTexts])
class EntryTextsDao extends DatabaseAccessor<AppDatabase>
    with _$EntryTextsDaoMixin {
  EntryTextsDao(AppDatabase appDatabase) : super(appDatabase);

  Future<int> create(EntryText entryText) {
    if (!isValid(entryText.id)) {
      throw InvalidDataException("id");
    }
    return into(entryTexts).insert(entryText);
  }
}

bool isValid(String uuid) {
  try {
    Uuid.parse(uuid);
    return true;
  } catch (e) {
    return false;
  }
}
