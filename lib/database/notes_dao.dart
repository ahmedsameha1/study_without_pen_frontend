import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part 'notes_dao.g.dart';

@DriftAccessor(tables: [Notes])
class NotesDao extends DatabaseAccessor<AppDatabase> with _$NotesDaoMixin {
  NotesDao(AppDatabase appDatabase) : super(appDatabase);
  create(NotesCompanion notesCompanion) {
    if (notesCompanion.id.present && !isValid(notesCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (!isValid(notesCompanion.relationalId.value)) {
      throw InvalidDataException("relationalId");
    }
    return into(notes).insert(notesCompanion);
  }

  Future<Note?> getById(String id) {
    return (select(notes)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}
