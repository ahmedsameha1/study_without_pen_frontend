// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_notes_dao.dart';

// ignore_for_file: type=lint
mixin _$FieldNotesDaoMixin on DatabaseAccessor<AppDatabase> {
  $FieldsTable get fields => attachedDatabase.fields;
  $FieldNotesTable get fieldNotes => attachedDatabase.fieldNotes;
  FieldNotesDaoManager get managers => FieldNotesDaoManager(this);
}

class FieldNotesDaoManager {
  final _$FieldNotesDaoMixin _db;
  FieldNotesDaoManager(this._db);
  $$FieldsTableTableManager get fields =>
      $$FieldsTableTableManager(_db.attachedDatabase, _db.fields);
  $$FieldNotesTableTableManager get fieldNotes =>
      $$FieldNotesTableTableManager(_db.attachedDatabase, _db.fieldNotes);
}
