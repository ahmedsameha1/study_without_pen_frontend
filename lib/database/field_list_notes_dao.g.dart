// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_list_notes_dao.dart';

// ignore_for_file: type=lint
mixin _$FieldListNotesDaoMixin on DatabaseAccessor<AppDatabase> {
  $FieldsTable get fields => attachedDatabase.fields;
  $FieldListsTable get fieldLists => attachedDatabase.fieldLists;
  $FieldListNotesTable get fieldListNotes => attachedDatabase.fieldListNotes;
  FieldListNotesDaoManager get managers => FieldListNotesDaoManager(this);
}

class FieldListNotesDaoManager {
  final _$FieldListNotesDaoMixin _db;
  FieldListNotesDaoManager(this._db);
  $$FieldsTableTableManager get fields =>
      $$FieldsTableTableManager(_db.attachedDatabase, _db.fields);
  $$FieldListsTableTableManager get fieldLists =>
      $$FieldListsTableTableManager(_db.attachedDatabase, _db.fieldLists);
  $$FieldListNotesTableTableManager get fieldListNotes =>
      $$FieldListNotesTableTableManager(
        _db.attachedDatabase,
        _db.fieldListNotes,
      );
}
