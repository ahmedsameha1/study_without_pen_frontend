import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part 'field_list_notes_dao.g.dart';

@DriftAccessor(tables: [FieldListNotes])
class FieldListNotesDao extends DatabaseAccessor<AppDatabase>
    with _$FieldListNotesDaoMixin {
  FieldListNotesDao(AppDatabase appDatabase) : super(appDatabase);
  create(FieldListNotesCompanion fieldListNotesCompanion) {
    if (fieldListNotesCompanion.id.present &&
        !isValid(fieldListNotesCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (!isValid(fieldListNotesCompanion.fieldListId.value)) {
      throw InvalidDataException("fieldListId");
    }
    if (fieldListNotesCompanion.creationAt.value.toUtc().isAfter(clock.now())) {
      throw InvalidDataException("creationAt");
    }
    if (fieldListNotesCompanion.lastModificationAt.value
        .toUtc()
        .isAfter(clock.now())) {
      throw InvalidDataException("lastModificationAt");
    }
    return into(fieldListNotes).insert(fieldListNotesCompanion);
  }

  Future<FieldListNote?> getById(String id) {
    return (select(fieldListNotes)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Stream<List<FieldListNote>> watchByFieldListId(String fieldListId) {
    return (select(fieldListNotes)
          ..where((tbl) => tbl.fieldListId.equals(fieldListId))
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: tbl.creationAt, mode: OrderingMode.desc)
          ]))
        .watch();
  }

  mutate(FieldListNotesCompanion fieldListNotesCompanion) {
    if (!isValid(fieldListNotesCompanion.fieldListId.value)) {
      throw InvalidDataException("fieldListId");
    }
    if (fieldListNotesCompanion.creationAt.value.toUtc().isAfter(clock.now())) {
      throw InvalidDataException("creationAt");
    }
    if (fieldListNotesCompanion.lastModificationAt.value
        .toUtc()
        .isAfter(clock.now())) {
      throw InvalidDataException("lastModificationAt");
    }
    return update(fieldListNotes).replace(fieldListNotesCompanion);
  }

  remove(String id) {
    return (delete(fieldListNotes)..where((tbl) => tbl.id.equals(id))).go();
  }
}
