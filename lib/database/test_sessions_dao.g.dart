// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_sessions_dao.dart';

// ignore_for_file: type=lint
mixin _$TestSessionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FieldsTable get fields => attachedDatabase.fields;
  $FieldListsTable get fieldLists => attachedDatabase.fieldLists;
  $SessionsTable get sessions => attachedDatabase.sessions;
  $TestSessionsTable get testSessions => attachedDatabase.testSessions;
  TestSessionsDaoManager get managers => TestSessionsDaoManager(this);
}

class TestSessionsDaoManager {
  final _$TestSessionsDaoMixin _db;
  TestSessionsDaoManager(this._db);
  $$FieldsTableTableManager get fields =>
      $$FieldsTableTableManager(_db.attachedDatabase, _db.fields);
  $$FieldListsTableTableManager get fieldLists =>
      $$FieldListsTableTableManager(_db.attachedDatabase, _db.fieldLists);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db.attachedDatabase, _db.sessions);
  $$TestSessionsTableTableManager get testSessions =>
      $$TestSessionsTableTableManager(_db.attachedDatabase, _db.testSessions);
}
