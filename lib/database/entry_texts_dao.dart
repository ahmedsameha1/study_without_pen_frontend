import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:uuid/uuid.dart';

part 'entry_texts_dao.g.dart';

@DriftAccessor(tables: [EntryTexts])
class EntryTextsDao extends DatabaseAccessor<AppDatabase>
    with _$EntryTextsDaoMixin {
  EntryTextsDao(AppDatabase appDatabase) : super(appDatabase);

  Future<int> create(EntryTextsCompanion entryTextsCompanion) {
    if (entryTextsCompanion.id.present && !isValid(entryTextsCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    return into(entryTexts).insert(entryTextsCompanion);
  }

  Future<EntryText?> getById(String id) {
    return (select(entryTexts)..where(((tbl) => tbl.id.equals(id))))
        .getSingleOrNull();
  }

  Future<List<EntryText>> getAll() {
    return select(entryTexts).get();
  }

  Future<int> remove(String id) {
    return (delete(entryTexts)..where((tbl) => tbl.id.equals(id))).go();
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
