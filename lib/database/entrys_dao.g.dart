// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entrys_dao.dart';

// ignore_for_file: type=lint
mixin _$EntrysDaoMixin on DatabaseAccessor<AppDatabase> {
  $FieldsTable get fields => attachedDatabase.fields;
  $FieldListsTable get fieldLists => attachedDatabase.fieldLists;
  $EntrysTable get entrys => attachedDatabase.entrys;
  EntrysDaoManager get managers => EntrysDaoManager(this);
}

class EntrysDaoManager {
  final _$EntrysDaoMixin _db;
  EntrysDaoManager(this._db);
  $$FieldsTableTableManager get fields =>
      $$FieldsTableTableManager(_db.attachedDatabase, _db.fields);
  $$FieldListsTableTableManager get fieldLists =>
      $$FieldListsTableTableManager(_db.attachedDatabase, _db.fieldLists);
  $$EntrysTableTableManager get entrys =>
      $$EntrysTableTableManager(_db.attachedDatabase, _db.entrys);
}
