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
  static const int MINIMUM_COLOR = 0;
  static const int MAXIMUM_COLOR = 0xffffffff;
  static const int MINIMUM_EMULATION_NUMBER_OF_QUESTIONS = 0;
  static const int MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS = 255;
  static const int MINIMUM_TESTS_DURATIONS = 1; // In milliseconds
  static const int MINIMUM_STUDY_TILL_CORRECT_DURATIONS = 1; // In milliseconds

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
  IntColumn get checkType => integer().check(checkType.isBiggerOrEqualValue(0) &
      checkType.isSmallerThanValue(CheckType.MAX.index))();
  IntColumn get sortBy => integer().check(sortBy.isBiggerOrEqualValue(0) &
      sortBy.isSmallerThanValue(SortBy.MAX.index))();
  BoolColumn get doesReadAnswer => boolean().withDefault(Constant(false))();
  IntColumn get usageCount => integer().withDefault(Constant(0)).check(
      usageCount.isBiggerOrEqualValue(FieldLists.MINIMUM_USAGE_COUNT) &
          usageCount.isSmallerOrEqualValue(FieldLists.MAXIMUM_USAGE_COUNT))();
  IntColumn get color => integer()
      .withDefault(Constant(FieldLists.MAXIMUM_COLOR))
      .check(color.isBiggerOrEqualValue(FieldLists.MINIMUM_COLOR) &
          color.isSmallerOrEqualValue(FieldLists.MAXIMUM_COLOR))();
  IntColumn get emulationNumberOfQuestions => integer().nullable().check(
      emulationNumberOfQuestions.isBiggerOrEqualValue(
              FieldLists.MINIMUM_EMULATION_NUMBER_OF_QUESTIONS) &
          emulationNumberOfQuestions.isSmallerOrEqualValue(
              FieldLists.MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS))();
  TextColumn get emulationDays => text().nullable()();
  IntColumn get testsReadingQuestionLetterDuration =>
      integer().nullable().check(testsReadingQuestionLetterDuration
          .isBiggerOrEqualValue(FieldLists.MINIMUM_TESTS_DURATIONS))();
  IntColumn get testsFindingAnswerDuration =>
      integer().nullable().check(testsFindingAnswerDuration
          .isBiggerOrEqualValue(FieldLists.MINIMUM_TESTS_DURATIONS))();
  IntColumn get testsTypingAnswerLetterDuration =>
      integer().nullable().check(testsTypingAnswerLetterDuration
          .isBiggerOrEqualValue(FieldLists.MINIMUM_TESTS_DURATIONS))();
  IntColumn get studyTillCorrectReadingQuestionLetterDuration => integer()
      .nullable()
      .check(studyTillCorrectReadingQuestionLetterDuration.isBiggerOrEqualValue(
          FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS))();
  IntColumn get studyTillCorrectFindingAnswerDuration => integer()
      .nullable()
      .check(studyTillCorrectFindingAnswerDuration.isBiggerOrEqualValue(
          FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS))();
  IntColumn get studyTillCorrectTypingAnswerLetterDuration => integer()
      .nullable()
      .check(studyTillCorrectTypingAnswerLetterDuration.isBiggerOrEqualValue(
          FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS))();
  IntColumn get testsTimeOfAnswerAction =>
      integer().check(testsTimeOfAnswerAction.isBiggerOrEqualValue(0) &
          testsTimeOfAnswerAction
              .isSmallerThanValue(TimeOfAnswerAction.MAX.index))();
  BoolColumn get doesObfuscateQuestion =>
      boolean().withDefault(Constant(false))();

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

enum CheckType {
  NON_STRICT_IGNORE_CASE,
  NON_STRICT_DO_NOT_IGNORE_CASE,
  IGNORE_CASE,
  DO_NOT_IGNORE_CASE,
  MAX
}

enum SortBy {
  CREATION_DATE_DESC,
  ANSWER_DESC,
  QUESTION_ASC,
  ANSWER_ASC,
  DATE_DESC,
  DATE_ASC,
  QUESTION_DESC,
  CREATION_DATE_ASC,
  ORDER_ASC,
  ORDER_DESC,
  RANK_ASC,
  RANK_DESC,
  WRONGNESS_ASC,
  WRONGNESS_DESC,
  MAX
}

enum TimeOfAnswerAction { NEXT, NOTIFY, MAX }
