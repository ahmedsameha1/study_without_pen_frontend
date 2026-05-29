// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field_lists_dao.dart';

// ignore_for_file: type=lint
mixin _$FieldListsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FieldsTable get fields => attachedDatabase.fields;
  $FieldListsTable get fieldLists => attachedDatabase.fieldLists;
  FieldListsDaoManager get managers => FieldListsDaoManager(this);
}

class FieldListsDaoManager {
  final _$FieldListsDaoMixin _db;
  FieldListsDaoManager(this._db);
  $$FieldsTableTableManager get fields =>
      $$FieldsTableTableManager(_db.attachedDatabase, _db.fields);
  $$FieldListsTableTableManager get fieldLists =>
      $$FieldListsTableTableManager(_db.attachedDatabase, _db.fieldLists);
}
