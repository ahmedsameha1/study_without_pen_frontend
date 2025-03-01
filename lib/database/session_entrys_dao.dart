import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part 'session_entrys_dao.g.dart';

@DriftAccessor(tables: [SessionEntrys])
class SessionEntrysDao extends DatabaseAccessor<AppDatabase>
    with _$SessionEntrysDaoMixin {
  SessionEntrysDao(AppDatabase appDatabase) : super(appDatabase);
  Future<int> create(SessionEntrysCompanion sessionEntrysCompanion) {
    if (!isValid(sessionEntrysCompanion.sessionId.value)) {
      throw InvalidDataException("sessionId");
    }
    if (!isValid(sessionEntrysCompanion.entryId.value)) {
      throw InvalidDataException("entryId");
    }
    return into(sessionEntrys).insert(sessionEntrysCompanion);
  }

  Future<int> remove(String sessionId, String entryId) {
    return (delete(sessionEntrys)
          ..where((tbl) =>
              tbl.sessionId.equals(sessionId) & tbl.entryId.equals(entryId)))
        .go();
  }
}
