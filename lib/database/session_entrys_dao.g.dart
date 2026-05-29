// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_entrys_dao.dart';

// ignore_for_file: type=lint
mixin _$SessionEntrysDaoMixin on DatabaseAccessor<AppDatabase> {
  $FieldsTable get fields => attachedDatabase.fields;
  $FieldListsTable get fieldLists => attachedDatabase.fieldLists;
  $SessionsTable get sessions => attachedDatabase.sessions;
  $EntrysTable get entrys => attachedDatabase.entrys;
  $SessionEntrysTable get sessionEntrys => attachedDatabase.sessionEntrys;
  SessionEntrysDaoManager get managers => SessionEntrysDaoManager(this);
}

class SessionEntrysDaoManager {
  final _$SessionEntrysDaoMixin _db;
  SessionEntrysDaoManager(this._db);
  $$FieldsTableTableManager get fields =>
      $$FieldsTableTableManager(_db.attachedDatabase, _db.fields);
  $$FieldListsTableTableManager get fieldLists =>
      $$FieldListsTableTableManager(_db.attachedDatabase, _db.fieldLists);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db.attachedDatabase, _db.sessions);
  $$EntrysTableTableManager get entrys =>
      $$EntrysTableTableManager(_db.attachedDatabase, _db.entrys);
  $$SessionEntrysTableTableManager get sessionEntrys =>
      $$SessionEntrysTableTableManager(_db.attachedDatabase, _db.sessionEntrys);
}
