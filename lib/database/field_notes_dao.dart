import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part 'field_notes_dao.g.dart';

@DriftAccessor(tables: [FieldNotes])
class FieldNotesDao extends DatabaseAccessor<AppDatabase>
    with _$FieldNotesDaoMixin {
  FieldNotesDao(AppDatabase appDatabase) : super(appDatabase);
  create(FieldNotesCompanion fieldNotesCompanion) {
    if (fieldNotesCompanion.id.present && !isValid(fieldNotesCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (!isValid(fieldNotesCompanion.fieldId.value)) {
      throw InvalidDataException("fieldId");
    }
    if (fieldNotesCompanion.creationAt.value.toUtc().isAfter(clock.now())) {
      throw InvalidDataException("creationAt");
    }
    if (fieldNotesCompanion.lastModificationAt.value.toUtc().isAfter(clock.now())) {
      throw InvalidDataException("lastModificationAt");
    }
    return into(fieldNotes).insert(fieldNotesCompanion);
  }

  Future<FieldNote?> getById(String id) {
    return (select(fieldNotes)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Stream<List<FieldNote>> watchByRelationalId(String relationalId) {
    return (select(fieldNotes)
          ..where((tbl) => tbl.fieldId.equals(relationalId))
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: tbl.creationAt, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  mutate(FieldNotesCompanion fieldNotesCompanion) {
    if (!isValid(fieldNotesCompanion.fieldId.value)) {
      throw InvalidDataException("fieldId");
    }
    if (fieldNotesCompanion.creationAt.value.toUtc().isAfter(clock.now())) {
      throw InvalidDataException("creationAt");
    }
    if (fieldNotesCompanion.lastModificationAt.value.toUtc().isAfter(clock.now())) {
      throw InvalidDataException("lastModificationAt");
    }
    return update(fieldNotes).replace(fieldNotesCompanion);
  }

  remove(String id) {
    return (delete(fieldNotes)..where((tbl) => tbl.id.equals(id))).go();
  }
}
