// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wrong_answers_dao.dart';

// ignore_for_file: type=lint
mixin _$WrongAnswersDaoMixin on DatabaseAccessor<AppDatabase> {
  $FieldsTable get fields => attachedDatabase.fields;
  $FieldListsTable get fieldLists => attachedDatabase.fieldLists;
  $SessionsTable get sessions => attachedDatabase.sessions;
  $EntrysTable get entrys => attachedDatabase.entrys;
  $WrongAnswersTable get wrongAnswers => attachedDatabase.wrongAnswers;
  WrongAnswersDaoManager get managers => WrongAnswersDaoManager(this);
}

class WrongAnswersDaoManager {
  final _$WrongAnswersDaoMixin _db;
  WrongAnswersDaoManager(this._db);
  $$FieldsTableTableManager get fields =>
      $$FieldsTableTableManager(_db.attachedDatabase, _db.fields);
  $$FieldListsTableTableManager get fieldLists =>
      $$FieldListsTableTableManager(_db.attachedDatabase, _db.fieldLists);
  $$SessionsTableTableManager get sessions =>
      $$SessionsTableTableManager(_db.attachedDatabase, _db.sessions);
  $$EntrysTableTableManager get entrys =>
      $$EntrysTableTableManager(_db.attachedDatabase, _db.entrys);
  $$WrongAnswersTableTableManager get wrongAnswers =>
      $$WrongAnswersTableTableManager(_db.attachedDatabase, _db.wrongAnswers);
}
