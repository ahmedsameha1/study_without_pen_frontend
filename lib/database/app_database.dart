import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/database/session_entrys_dao.dart';
import 'package:study_without_pen_by_flutter/database/sessions_dao.dart';
import 'package:study_without_pen_by_flutter/database/field_notes_dao.dart';
import 'package:uuid/uuid.dart';

import 'entrys_dao.dart';
import 'field_list_notes_dao.dart';
import 'field_lists_dao.dart';
import 'test_sessions_dao.dart';
import 'wrong_answers_dao.dart';

part 'app_database.g.dart';

class Entrys extends Table {
  static const int minimumTextLength = 1;
  static const int maximumTextLength = 2000;
  static const int ORDER_MINIMUM_VALUE = 0;
  static const int ASKED_COUNT_MINIMUM_VALUE = 0;
  static const int WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE = 0;
  static const int ORDER_MAXIMUM_VALUE = 65535;
  static const int ASKED_COUNT_MAXIMUM_VALUE = 65535;
  static const int WRONGLY_ANSWERED_COUNT_MAXIMUM_VALUE = 65535;
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get fieldListId => text().references(FieldLists, #id)();
  TextColumn get answer => text().check(
    answer.length.isSmallerOrEqualValue(Entrys.maximumTextLength) &
        answer.length.isBiggerOrEqualValue(Entrys.minimumTextLength),
  )();
  TextColumn get question => text().check(
    question.length.isSmallerOrEqualValue(Entrys.maximumTextLength) &
        question.length.isBiggerOrEqualValue(Entrys.minimumTextLength),
  )();
  DateTimeColumn get creationAt => dateTime()();
  DateTimeColumn get lastModificationAt =>
      dateTime().check(lastModificationAt.isBiggerOrEqual(creationAt))();
  IntColumn get order => integer().check(
    order.isSmallerOrEqualValue(Entrys.ORDER_MAXIMUM_VALUE) &
        order.isBiggerOrEqualValue(Entrys.ORDER_MINIMUM_VALUE),
  )();
  BoolColumn get didAskedAtCurrentTestRound => boolean()();
  DateTimeColumn get emulatedCreatedAt => dateTime()();
  IntColumn get rank => integer()();
  IntColumn get askedCount => integer().check(
    askedCount.isSmallerOrEqualValue(Entrys.ASKED_COUNT_MAXIMUM_VALUE) &
        askedCount.isBiggerOrEqualValue(Entrys.ASKED_COUNT_MINIMUM_VALUE),
  )();
  IntColumn get wronglyAnsweredCount => integer().check(
    wronglyAnsweredCount.isSmallerOrEqualValue(
          Entrys.WRONGLY_ANSWERED_COUNT_MAXIMUM_VALUE,
        ) &
        wronglyAnsweredCount.isBiggerOrEqualValue(
          Entrys.WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE,
        ),
  )();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
    {fieldListId, answer, question},
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
  TextColumn get fieldId => text().references(Fields, #id)();
  TextColumn get name => text().check(
    name.trim().length.isBiggerOrEqualValue(FieldLists.MINIMUM_LENGTH_OF_NAME) &
        name.length.isSmallerOrEqualValue(FieldLists.MAXIMUM_LENGTH_OF_NAME),
  )();
  DateTimeColumn get creationAt => dateTime()();
  DateTimeColumn get lastModificationAt =>
      dateTime().check(lastModificationAt.isBiggerOrEqual(creationAt))();
  TextColumn get languageTag => text().nullable()();
  IntColumn get checkType => integer()
      .withDefault(Constant(CheckType.NON_STRICT_IGNORE_CASE.index))
      .check(
        checkType.isBiggerOrEqualValue(0) &
            checkType.isSmallerOrEqualValue(CheckType.DO_NOT_IGNORE_CASE.index),
      )();
  IntColumn get sortBy => integer()
      .withDefault(Constant(SortBy.CREATION_DATE_DESC.index))
      .check(
        sortBy.isBiggerOrEqualValue(0) &
            sortBy.isSmallerThanValue(SortBy.MAX.index),
      )();
  BoolColumn get doesReadAnswer => boolean().withDefault(Constant(false))();
  IntColumn get usageCount => integer()
      .withDefault(Constant(0))
      .check(
        usageCount.isBiggerOrEqualValue(FieldLists.MINIMUM_USAGE_COUNT) &
            usageCount.isSmallerOrEqualValue(FieldLists.MAXIMUM_USAGE_COUNT),
      )();
  IntColumn get color => integer()
      .withDefault(Constant(FieldLists.MAXIMUM_COLOR))
      .check(
        color.isBiggerOrEqualValue(FieldLists.MINIMUM_COLOR) &
            color.isSmallerOrEqualValue(FieldLists.MAXIMUM_COLOR),
      )();
  IntColumn get emulationNumberOfQuestions => integer().nullable().check(
    emulationNumberOfQuestions.isBiggerOrEqualValue(
          FieldLists.MINIMUM_EMULATION_NUMBER_OF_QUESTIONS,
        ) &
        emulationNumberOfQuestions.isSmallerOrEqualValue(
          FieldLists.MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS,
        ),
  )();
  TextColumn get emulationDays => text().nullable()();
  IntColumn get testsReadingQuestionLetterDuration =>
      integer().nullable().check(
        testsReadingQuestionLetterDuration.isBiggerOrEqualValue(
          FieldLists.MINIMUM_TESTS_DURATIONS,
        ),
      )();
  IntColumn get testsFindingAnswerDuration => integer().nullable().check(
    testsFindingAnswerDuration.isBiggerOrEqualValue(
      FieldLists.MINIMUM_TESTS_DURATIONS,
    ),
  )();
  IntColumn get testsTypingAnswerLetterDuration => integer().nullable().check(
    testsTypingAnswerLetterDuration.isBiggerOrEqualValue(
      FieldLists.MINIMUM_TESTS_DURATIONS,
    ),
  )();
  IntColumn get studyTillCorrectReadingQuestionLetterDuration =>
      integer().nullable().check(
        studyTillCorrectReadingQuestionLetterDuration.isBiggerOrEqualValue(
          FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS,
        ),
      )();
  IntColumn get studyTillCorrectFindingAnswerDuration =>
      integer().nullable().check(
        studyTillCorrectFindingAnswerDuration.isBiggerOrEqualValue(
          FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS,
        ),
      )();
  IntColumn get studyTillCorrectTypingAnswerLetterDuration =>
      integer().nullable().check(
        studyTillCorrectTypingAnswerLetterDuration.isBiggerOrEqualValue(
          FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS,
        ),
      )();
  IntColumn get testsTimeOfAnswerAction => integer()
      .withDefault(Constant(TimeOfAnswerAction.NOTIFY.index))
      .check(
        testsTimeOfAnswerAction.isBiggerOrEqualValue(0) &
            testsTimeOfAnswerAction.isSmallerThanValue(
              TimeOfAnswerAction.MAX.index,
            ),
      )();
  BoolColumn get doesObfuscateQuestion =>
      boolean().withDefault(Constant(false))();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
    {fieldId, name},
  ];
}

class Fields extends Table {
  static const int MINIMUM_LENGTH_OF_USER_ACCOUNT_ID = 28;
  static const int MINIMUM_LENGTH_OF_NAME = 1;
  static const int MAXIMUM_LENGTH_OF_NAME = 64;
  static const int MINIMUM_USAGE_COUNT = 0;
  static const int MAXIMUM_USAGE_COUNT = 0xffffffff;
  static const int DEFAULT_USAGE_COUNT = 0;
  static const int MINIMUM_COLOR = 0;
  static const int MAXIMUM_COLOR = 0xffffffff;
  static const int DEFAULT_COLOR = 0xffffffff;

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get userAccountId => text().check(
    userAccountId.trim().length.isBiggerOrEqualValue(
      Fields.MINIMUM_LENGTH_OF_USER_ACCOUNT_ID,
    ),
  )();
  TextColumn get name => text().check(
    name.trim().length.isBiggerOrEqualValue(Fields.MINIMUM_LENGTH_OF_NAME) &
        name.length.isSmallerOrEqualValue(Fields.MAXIMUM_LENGTH_OF_NAME),
  )();
  DateTimeColumn get creationAt => dateTime()();
  DateTimeColumn get lastModificationAt =>
      dateTime().check(lastModificationAt.isBiggerOrEqual(creationAt))();
  IntColumn get usageCount => integer()
      .withDefault(Constant(Fields.DEFAULT_USAGE_COUNT))
      .check(
        usageCount.isBiggerOrEqualValue(Fields.MINIMUM_USAGE_COUNT) &
            usageCount.isSmallerOrEqualValue(Fields.MAXIMUM_USAGE_COUNT),
      )();
  IntColumn get color => integer()
      .withDefault(Constant(Fields.DEFAULT_COLOR))
      .check(
        color.isBiggerOrEqualValue(Fields.MINIMUM_COLOR) &
            color.isSmallerOrEqualValue(Fields.MAXIMUM_COLOR),
      )();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => [
    {userAccountId, name},
  ];
}

class FieldNotes extends Table {
  static const int MINIMUM_LENGTH_OF_TEXT = 1;
  static const int MAXIMUM_LENGTH_OF_TEXT = 2000;

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get fieldId => text().references(Fields, #id)();
  TextColumn get texT => text().check(
    texT.trim().length.isBiggerOrEqualValue(FieldNotes.MINIMUM_LENGTH_OF_TEXT) &
        texT.length.isSmallerOrEqualValue(FieldNotes.MAXIMUM_LENGTH_OF_TEXT),
  )();
  DateTimeColumn get creationAt => dateTime()();
  DateTimeColumn get lastModificationAt =>
      dateTime().check(lastModificationAt.isBiggerOrEqual(creationAt))();

  @override
  Set<Column> get primaryKey => {id};
}

class FieldListNotes extends Table {
  static const int MINIMUM_LENGTH_OF_TEXT = 1;
  static const int MAXIMUM_LENGTH_OF_TEXT = 2000;

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get fieldListId => text().references(FieldLists, #id)();
  TextColumn get texT => text().check(
    texT.trim().length.isBiggerOrEqualValue(
          FieldListNotes.MINIMUM_LENGTH_OF_TEXT,
        ) &
        texT.length.isSmallerOrEqualValue(
          FieldListNotes.MAXIMUM_LENGTH_OF_TEXT,
        ),
  )();
  DateTimeColumn get creationAt => dateTime()();
  DateTimeColumn get lastModificationAt =>
      dateTime().check(lastModificationAt.isBiggerOrEqual(creationAt))();

  @override
  Set<Column> get primaryKey => {id};
}

class Sessions extends Table {
  static const int MINIMUM_CURRENT_QUESTION_COUNTER = 0;
  static const int MAXIMUM_CURRENT_QUESTION_COUNTER = 0xffffffff;
  static const int MINIMUM_TRIES_NUMBER = 0;
  static const int MAXIMUM_TRIES_NUMBER = 0xff;
  static const int MINIMUM_TRIES_COUNTER = 0;
  static const int MAXIMUM_TRIES_COUNTER = 0xff;
  static const int MINIMUM_ELAPSED_TIME = 1; // in milliseconds
  static const int MINIMUM_CURRENT_HINT_COUNTER = 0;
  static const int MAXIMUM_CURRENT_HINT_COUNTER = 0xff;

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get fieldListId => text().references(FieldLists, #id)();
  IntColumn get currentQuestionCounter => integer().check(
    currentQuestionCounter.isBiggerOrEqualValue(
          Sessions.MINIMUM_CURRENT_QUESTION_COUNTER,
        ) &
        currentQuestionCounter.isSmallerOrEqualValue(
          Sessions.MAXIMUM_CURRENT_QUESTION_COUNTER,
        ),
  )();
  IntColumn get triesNumber => integer().check(
    triesNumber.isBiggerOrEqualValue(Sessions.MINIMUM_TRIES_NUMBER) &
        triesNumber.isSmallerOrEqualValue(Sessions.MAXIMUM_TRIES_NUMBER),
  )();
  IntColumn get triesCounter => integer()
      .withDefault(Constant(0))
      .check(
        triesCounter.isBiggerOrEqualValue(Sessions.MINIMUM_TRIES_COUNTER) &
            triesCounter.isSmallerOrEqualValue(Sessions.MAXIMUM_TRIES_COUNTER) &
            triesCounter.isSmallerThan(triesNumber),
      )();
  IntColumn get elapsedTime => integer().check(
    elapsedTime.isBiggerOrEqualValue(Sessions.MINIMUM_ELAPSED_TIME),
  )();
  BoolColumn get isCompleted => boolean().withDefault(Constant(false))();
  BoolColumn get lastCheckedAnswerResult =>
      boolean().withDefault(Constant(false))();
  BoolColumn get shouldCheckAnAnswer => boolean().withDefault(Constant(true))();
  IntColumn get currentHintCounter => integer()
      .withDefault(Constant(0))
      .check(
        currentHintCounter.isBiggerOrEqualValue(
              Sessions.MINIMUM_CURRENT_HINT_COUNTER,
            ) &
            currentHintCounter.isSmallerOrEqualValue(
              Sessions.MAXIMUM_CURRENT_HINT_COUNTER,
            ),
      )();
  DateTimeColumn get creationAt => dateTime()();
  DateTimeColumn get lastModificationAt =>
      dateTime().check(lastModificationAt.isBiggerOrEqual(creationAt))();

  @override
  Set<Column> get primaryKey => {id};
}

class SessionEntrys extends Table {
  TextColumn get sessionId => text().references(Sessions, #id)();
  TextColumn get entryId => text().references(Entrys, #id)();

  @override
  Set<Column> get primaryKey => {sessionId, entryId};
}

class TestSessions extends Table {
  static const int MINIMUM_WRONG_ANSWER_COUNTER = 0;
  static const int MAXIMUM_WRONG_ANSWER_COUNTER = 0xffffffff;
  static const int MINIMUM_LAST_ANSWER = 1;

  TextColumn get sessionId => text().references(Sessions, #id)();
  IntColumn get wrongAnswerCounter => integer()
      .withDefault(Constant(0))
      .check(
        wrongAnswerCounter.isBiggerOrEqualValue(
              TestSessions.MINIMUM_WRONG_ANSWER_COUNTER,
            ) &
            wrongAnswerCounter.isSmallerOrEqualValue(
              TestSessions.MAXIMUM_WRONG_ANSWER_COUNTER,
            ),
      )();
  TextColumn get lastAnswer => text().nullable().check(
    lastAnswer.trim().length.isBiggerOrEqualValue(
      TestSessions.MINIMUM_LAST_ANSWER,
    ),
  )();

  @override
  Set<Column> get primaryKey => {sessionId};
}

class WrongAnswers extends Table {
  static const int MINIMUM_VALUE_LENGTH = 1;

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get sessionId => text().references(Sessions, #id)();
  TextColumn get entryId => text().references(Entrys, #id)();
  TextColumn get value => text().check(
    value.trim().length.isBiggerOrEqualValue(WrongAnswers.MINIMUM_VALUE_LENGTH),
  )();
  DateTimeColumn get creationAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    Entrys,
    FieldLists,
    Fields,
    FieldNotes,
    FieldListNotes,
    Sessions,
    SessionEntrys,
    TestSessions,
    WrongAnswers,
  ],
  daos: [
    EntrysDao,
    FieldListsDao,
    FieldsDao,
    FieldNotesDao,
    FieldListNotesDao,
    SessionsDao,
    SessionEntrysDao,
    TestSessionsDao,
    WrongAnswersDao,
  ],
)
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

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement("PRAGMA foreign_keys = ON");
      },
    );
  }
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
  MAX,
}

enum TimeOfAnswerAction { NEXT, NOTIFY, MAX }
