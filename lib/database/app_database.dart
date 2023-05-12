import 'dart:io';

import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_without_pen_by_flutter/database/entry_texts_dao.dart';
import 'package:study_without_pen_by_flutter/database/questions_dao.dart';
import 'package:uuid/uuid.dart';

import 'entrys_dao.dart';
import 'field_lists_dao.dart';

part 'app_database.g.dart';

class EntryTexts extends Table {
  static const int MINIMUM_VALUE_LENGTH = 1;
  static const int MAXIMUM_VALUE_LENGTH = 2000;
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get value => text()
      .check(value
              .trim()
              .length
              .isBiggerOrEqualValue(EntryTexts.MINIMUM_VALUE_LENGTH) &
          value.length.isSmallerOrEqualValue(EntryTexts.MAXIMUM_VALUE_LENGTH))
      .unique()();

  @override
  Set<Column> get primaryKey => {id};
}

class Questions extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  IntColumn get questionType => integer()();
  TextColumn get address => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => <Set<Column<Object>>>[
        {questionType, address}
      ];
}

class Entrys extends Table {
  static const int ORDER_MINIMUM_VALUE = 0;
  static const int ASKED_COUNT_MINIMUM_VALUE = 0;
  static const int WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE = 0;
  static const int ORDER_MAXIMUM_VALUE = 65535;
  static const int ASKED_COUNT_MAXIMUM_VALUE = 65535;
  static const int WRONGLY_ANSWERED_COUNT_MAXIMUM_VALUE = 65535;
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get fieldListId => text()();
  TextColumn get answerId => text()();
  TextColumn get questionId => text()();
  DateTimeColumn get creationAt =>
      dateTime().check(creationAt.isSmallerThanValue(clock.now().toUtc()))();
  DateTimeColumn get lastModificationAt => dateTime().check(
      lastModificationAt.isSmallerThanValue(clock.now().toUtc()) &
          lastModificationAt.isBiggerOrEqual(creationAt))();
  IntColumn get order =>
      integer().check(order.isSmallerOrEqualValue(Entrys.ORDER_MAXIMUM_VALUE) &
          order.isBiggerOrEqualValue(Entrys.ORDER_MINIMUM_VALUE))();
  BoolColumn get didAskedAtCurrentTestRound => boolean()();
  DateTimeColumn get emulatedCreatedAt => dateTime()();
  IntColumn get rank => integer()();
  IntColumn get askedCount => integer().check(
      askedCount.isSmallerOrEqualValue(Entrys.ASKED_COUNT_MAXIMUM_VALUE) &
          askedCount.isBiggerOrEqualValue(Entrys.ASKED_COUNT_MINIMUM_VALUE))();
  IntColumn get wronglyAnsweredCount => integer().check(wronglyAnsweredCount
          .isSmallerOrEqualValue(Entrys.WRONGLY_ANSWERED_COUNT_MAXIMUM_VALUE) &
      wronglyAnsweredCount
          .isBiggerOrEqualValue(Entrys.WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
        {fieldListId, answerId, questionId}
      ];
}

class FieldLists extends Table {
  static const int MINIMUM_LENGTH_OF_NAME = 1;
  static const int MAXIMUM_LENGTH_OF_NAME = 64;
  static const int MINIMUM_USAGE_COUNT = 0;
  static const int MAXIMUM_USAGE_COUNT = 65535;
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get fieldId => text()();
  TextColumn get name => text().check(name
          .trim()
          .length
          .isBiggerOrEqualValue(FieldLists.MINIMUM_LENGTH_OF_NAME) &
      name.length.isSmallerOrEqualValue(FieldLists.MAXIMUM_LENGTH_OF_NAME))();
  DateTimeColumn get creationAt =>
      dateTime().check(creationAt.isSmallerThanValue(clock.now().toUtc()))();
  DateTimeColumn get lastModificationAt => dateTime().check(
      lastModificationAt.isSmallerThanValue(clock.now().toUtc()) &
          lastModificationAt.isBiggerOrEqual(creationAt))();
  TextColumn get languageTag => text().nullable()();
  IntColumn get checkType => integer()();
  IntColumn get sortBy => integer()();
  BoolColumn get doesReadAnswer => boolean().withDefault(Constant(false))();
  IntColumn get usageCount => integer().withDefault(Constant(0)).check(
      usageCount.isBiggerOrEqualValue(FieldLists.MINIMUM_USAGE_COUNT) &
          usageCount.isSmallerOrEqualValue(FieldLists.MAXIMUM_USAGE_COUNT))();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
    tables: [EntryTexts, Questions, Entrys, FieldLists],
    daos: [EntryTextsDao, QuestionsDao, EntrysDao, FieldListsDao])
class AppDatabase extends _$AppDatabase {
  static const databaseFileName = "db.sqlite";
  static LazyDatabase openConnection() {
    return LazyDatabase(() async {
      final dbDirectory = await getApplicationDocumentsDirectory();
      final file = File(join(dbDirectory.path, databaseFileName));
      return NativeDatabase(file);
    });
  }

  AppDatabase(QueryExecutor queryExecutor) : super(queryExecutor);

  @override
  int get schemaVersion => 1;
}

bool isValid(String uuid) {
  try {
    Uuid.parse(uuid);
    return true;
  } catch (e) {
    return false;
  }
}
