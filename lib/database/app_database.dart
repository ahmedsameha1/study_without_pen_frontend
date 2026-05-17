import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import './before_db_v14_constants.dart';
import 'entrys_dao.dart';
import 'field_list_notes_dao.dart';
import 'field_lists_dao.dart';
import 'field_notes_dao.dart';
import 'fields_dao.dart';
import 'session_entrys_dao.dart';
import 'sessions_dao.dart';
import 'test_sessions_dao.dart';
import 'wrong_answers_dao.dart';

part 'app_database.g.dart';

const migrationUserAccountId = '95bfc9e1-7d6a-4f92-bee2-562692bc4333';

class Entrys extends Table {
  static const int minimumTextLength = 1;
  static const int maximumTextLength = 2000;
  static const int ORDER_MINIMUM_VALUE = 0;
  static BigInt ASKED_COUNT_MINIMUM_VALUE = BigInt.from(0);
  static BigInt WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE = BigInt.from(0);
  static const int ORDER_MAXIMUM_VALUE = 65535;
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get fieldListId => text().references(FieldLists, #id)();
  TextColumn get answer => text().check(
    answer.trim().length.isBiggerOrEqualValue(Entrys.minimumTextLength) &
        answer.length.isSmallerOrEqualValue(Entrys.maximumTextLength),
  )();
  TextColumn get question => text().check(
    question.trim().length.isBiggerOrEqualValue(Entrys.minimumTextLength) &
        question.length.isSmallerOrEqualValue(Entrys.maximumTextLength),
  )();
  DateTimeColumn get creationAt => dateTime()();
  DateTimeColumn get lastModificationAt =>
      dateTime().check(lastModificationAt.isBiggerOrEqual(creationAt))();
  IntColumn get order => integer()
      .withDefault(const Constant(Entrys.ORDER_MINIMUM_VALUE))
      .check(
        order.isSmallerOrEqualValue(Entrys.ORDER_MAXIMUM_VALUE) &
            order.isBiggerOrEqualValue(Entrys.ORDER_MINIMUM_VALUE),
      )();
  BoolColumn get didAskedAtCurrentTestRound =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get emulatedCreatedAt => dateTime().nullable()();
  IntColumn get rank => integer()
      .withDefault(Constant(Rank.normal.index))
      .check(
        rank.isSmallerOrEqualValue(Rank.vital.index) &
            rank.isBiggerOrEqualValue(Rank.low.index),
      )();
  Int64Column get askedCount => int64()
      .withDefault(Constant(Entrys.ASKED_COUNT_MINIMUM_VALUE))
      .check(
        askedCount.isBiggerOrEqualValue(Entrys.ASKED_COUNT_MINIMUM_VALUE),
      )();
  Int64Column get wronglyAnsweredCount => int64()
      .withDefault(Constant(Entrys.WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE))
      .check(
        wronglyAnsweredCount.isBiggerOrEqualValue(
          Entrys.WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE,
        ),
      )();
  DateTimeColumn get lastAskedAt => dateTime().nullable()();

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
  BoolColumn get doesReadAnswer =>
      boolean().withDefault(const Constant(false))();
  IntColumn get usageCount => integer()
      .withDefault(const Constant(0))
      .check(
        usageCount.isBiggerOrEqualValue(FieldLists.MINIMUM_USAGE_COUNT) &
            usageCount.isSmallerOrEqualValue(FieldLists.MAXIMUM_USAGE_COUNT),
      )();
  IntColumn get color => integer()
      .withDefault(const Constant(FieldLists.MAXIMUM_COLOR))
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
      boolean().withDefault(const Constant(false))();

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
      .withDefault(const Constant(Fields.DEFAULT_USAGE_COUNT))
      .check(
        usageCount.isBiggerOrEqualValue(Fields.MINIMUM_USAGE_COUNT) &
            usageCount.isSmallerOrEqualValue(Fields.MAXIMUM_USAGE_COUNT),
      )();
  IntColumn get color => integer()
      .withDefault(const Constant(Fields.DEFAULT_COLOR))
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
      .withDefault(const Constant(0))
      .check(
        triesCounter.isBiggerOrEqualValue(Sessions.MINIMUM_TRIES_COUNTER) &
            triesCounter.isSmallerOrEqualValue(Sessions.MAXIMUM_TRIES_COUNTER) &
            triesCounter.isSmallerThan(triesNumber),
      )();
  IntColumn get elapsedTime => integer().check(
    elapsedTime.isBiggerOrEqualValue(Sessions.MINIMUM_ELAPSED_TIME),
  )();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  BoolColumn get lastCheckedAnswerResult =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get shouldCheckAnAnswer =>
      boolean().withDefault(const Constant(true))();
  IntColumn get currentHintCounter => integer()
      .withDefault(const Constant(0))
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
      .withDefault(const Constant(0))
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
  AppDatabase(QueryExecutor queryExecutor) : super(queryExecutor);

  @override
  int get schemaVersion => 14;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
    onUpgrade: (m, from, to) async {
      await transaction(() async {
        if (from < 3) {
          await customStatement('''
        CREATE TABLE tempTable ( 
                 ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME} TEXT PRIMARY KEY, 
                 $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 DATETIME DEFAULT CURRENT_TIMESTAMP )
                ''');

          await customStatement('''
                INSERT INTO  tempTable ( ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME}
                , $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 )
                SELECT ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME} ,
                 $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32
                 FROM  ${Old_Field_DBV6_AppV32.TABLE_NAME}
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS ${Old_Field_DBV6_AppV32.TABLE_NAME}
                ''');

          await customStatement('''
CREATE TABLE  ${Old_Field_DBV6_AppV32.TABLE_NAME} ( 
             ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME} TEXT PRIMARY KEY NOT NULL, 
            ${Old_Field_DBV6_AppV32.COLUMN_FIELD_TYPE} INTEGER NOT NULL DEFAULT 0 , 
            $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 DATETIME DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')) )
                ''');

          await customStatement('''
                INSERT INTO  ${Old_Field_DBV6_AppV32.TABLE_NAME} ( ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME}
                ,$Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 ) 
                SELECT ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME} ,
               $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32
               FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');

          await customStatement('''
                ALTER TABLE ${Old_Question_DBV6_AppV32.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
                CREATE TABLE ${Old_Question_DBV6_AppV32.TABLE_NAME} ( ${Old_Question_DBV6_AppV32.COLUMN_QUESTION_ENTRY}
            TEXT PRIMARY KEY NOT NULL, 
            $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 DATETIME DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')) )
                ''');

          await customStatement('''
                INSERT INTO ${Old_Question_DBV6_AppV32.TABLE_NAME} ( ${Old_Question_DBV6_AppV32.COLUMN_QUESTION_ENTRY}
                , $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32  ) 
                SELECT ${Old_Question_DBV6_AppV32.COLUMN_QUESTION_ENTRY} , 
                $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32
                FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');

          await customStatement('''
                ALTER TABLE ${Old_Answer_DBV6_AppV32.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
          CREATE TABLE  ${Old_Answer_DBV6_AppV32.TABLE_NAME}
             (  ${Old_Answer_DBV6_AppV32.COLUMN_ANSWER_ENTRY}
            TEXT PRIMARY KEY NOT NULL, 
            $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 DATETIME DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')) )
                ''');

          await customStatement('''
                INSERT INTO ${Old_Answer_DBV6_AppV32.TABLE_NAME}  ( ${Old_Answer_DBV6_AppV32.COLUMN_ANSWER_ENTRY}
                , $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 ) 
                SELECT ${Old_Answer_DBV6_AppV32.COLUMN_ANSWER_ENTRY} ,
                $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32
                FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');

          await customStatement('''
ALTER TABLE  ${Old_Linker_DBV6_AppV32.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
CREATE TABLE ${Old_Linker_DBV6_AppV32.TABLE_NAME}
             ( ${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK} TEXT NOT NULL, 
             ${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK} TEXT NOT NULL, 
             ${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK} TEXT NOT NULL, 
             ${Old_Linker_DBV6_AppV32.COLUMN_STUDY_DURING_ORDER} INTEGER NOT NULL DEFAULT -1 , 
             ${Old_Linker_DBV6_AppV32.COLUMN_TEST_ORDER} INTEGER NOT NULL DEFAULT -1 , 
             ${Old_Linker_DBV6_AppV32.COLUMN_TEST_WRONG_ANSWERS} TEXT NOT NULL DEFAULT '' , 
             $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 DATETIME DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')), 
            FOREIGN KEY ( ${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK} ) REFERENCES 
             ${Old_Question_DBV6_AppV32.TABLE_NAME} ( ${Old_Question_DBV6_AppV32.COLUMN_QUESTION_ENTRY} ) ON DELETE CASCADE ON UPDATE CASCADE ,
            FOREIGN KEY ( ${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK} ) REFERENCES 
             ${Old_Answer_DBV6_AppV32.TABLE_NAME} ( ${Old_Answer_DBV6_AppV32.COLUMN_ANSWER_ENTRY} ) ON DELETE CASCADE ON UPDATE CASCADE,
            FOREIGN KEY ( ${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK} ) REFERENCES 
             ${Old_Field_DBV6_AppV32.TABLE_NAME} ( ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME} ) ON DELETE CASCADE ON UPDATE CASCADE,
            PRIMARY KEY ( ${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK} ,
             ${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK} ,
             ${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK} ))
                ''');

          await customStatement('''
                INSERT INTO ${Old_Linker_DBV6_AppV32.TABLE_NAME} ( ${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK}
                , ${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK} ,
                 ${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK} ,
                $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 ) 
                SELECT ${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK}
                , ${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK} ,
                ${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK} ,
                $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32
                FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');
        }

        if (from < 4) {
          await customStatement('''
CREATE TABLE  ${Old_Study_During_Temp_DBV6_AppV32.TABLE_NAME}
             ( ${Old_Study_During_Temp_DBV6_AppV32.COLUMN_QUESTION} TEXT NOT NULL, 
            ${Old_Study_During_Temp_DBV6_AppV32.COLUMN_ANSWER} TEXT NOT NULL, 
            ${Old_Study_During_Temp_DBV6_AppV32.COLUMN_FIELD} TEXT NOT NULL )
                ''');
        }

        if (from < 5) {
          await customStatement('''
ALTER TABLE ${Old_Field_DBV6_AppV32.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
                CREATE TABLE ${Old_Field_DBV6_AppV32.TABLE_NAME} ( 
            ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME} TEXT PRIMARY KEY NOT NULL, 
            ${Old_Field_DBV6_AppV32.COLUMN_FIELD_TYPE} INTEGER NOT NULL DEFAULT 0 , 
            $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 DATETIME DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')) )
                ''');

          await customStatement('''
                INSERT INTO ${Old_Field_DBV6_AppV32.TABLE_NAME} (  ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME}
                 , $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 ) 
                SELECT ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME}
                , $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32
                FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');

          await customStatement('''
                ALTER TABLE ${Old_Linker_DBV6_AppV32.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
CREATE TABLE  ${Old_Linker_DBV6_AppV32.TABLE_NAME}
             ( ${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK} TEXT NOT NULL, 
             ${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK} TEXT NOT NULL, 
             ${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK} TEXT NOT NULL, 
             ${Old_Linker_DBV6_AppV32.COLUMN_STUDY_DURING_ORDER} INTEGER NOT NULL DEFAULT -1 , 
             ${Old_Linker_DBV6_AppV32.COLUMN_TEST_ORDER} INTEGER NOT NULL DEFAULT -1 , 
             ${Old_Linker_DBV6_AppV32.COLUMN_TEST_WRONG_ANSWERS} TEXT NOT NULL DEFAULT '' , 
             $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 DATETIME DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')), 
             FOREIGN KEY ( ${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK} ) REFERENCES 
             ${Old_Question_DBV6_AppV32.TABLE_NAME} ( ${Old_Question_DBV6_AppV32.COLUMN_QUESTION_ENTRY} ) ON DELETE CASCADE ON UPDATE CASCADE,
             FOREIGN KEY ( ${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK} ) REFERENCES 
             ${Old_Answer_DBV6_AppV32.TABLE_NAME} ( ${Old_Answer_DBV6_AppV32.COLUMN_ANSWER_ENTRY} ) ON DELETE CASCADE ON UPDATE CASCADE,
            FOREIGN KEY ( ${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK} ) REFERENCES 
            ${Old_Field_DBV6_AppV32.TABLE_NAME} ( ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME} ) ON DELETE CASCADE ON UPDATE CASCADE,
             PRIMARY KEY ( ${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK} ,
             ${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK} ,
             ${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK} ))
                ''');

          await customStatement('''
INSERT INTO  ${Old_Linker_DBV6_AppV32.TABLE_NAME} ( ${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK}
                , ${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK}
                 , ${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK}
                 ,  $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32  ) 
                SELECT  ${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK}
                , ${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK}
                , ${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK}
                , $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32
                FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');

          await customStatement('''
  WITH OrderedData AS (
    SELECT 
      ${Old_Study_During_Temp_DBV6_AppV32.COLUMN_QUESTION}, 
      ${Old_Study_During_Temp_DBV6_AppV32.COLUMN_ANSWER}, 
      ${Old_Study_During_Temp_DBV6_AppV32.COLUMN_FIELD}, 
      (ROW_NUMBER() OVER (PARTITION BY field) - 1) as relative_pos
    FROM ${Old_Study_During_Temp_DBV6_AppV32.TABLE_NAME}
  )
  UPDATE ${Old_Linker_DBV6_AppV32.TABLE_NAME}
  SET ${Old_Linker_DBV6_AppV32.COLUMN_STUDY_DURING_ORDER} = (
    SELECT relative_pos 
    FROM OrderedData 
    WHERE OrderedData.question = ${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK}
      AND OrderedData.answer = ${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK}
      AND OrderedData.field = ${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK}
  )
  WHERE EXISTS (
    SELECT 1 FROM OrderedData 
    WHERE OrderedData.question = ${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK}
      AND OrderedData.answer = ${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK}
      AND OrderedData.field = ${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK}
  );
''');

          await customStatement('''
DROP TABLE IF EXISTS ${Old_Study_During_Temp_DBV6_AppV32.TABLE_NAME}
                ''');
        }

        if (from < 6) {
          await customStatement('''
ALTER TABLE ${Old_Field_DBV6_AppV32.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
CREATE TABLE ${Old_Field_DBV6_AppV32.TABLE_NAME} (
             ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME} TEXT PRIMARY KEY NOT NULL, 
            ${Old_Field_DBV6_AppV32.COLUMN_FIELD_TYPE} INTEGER NOT NULL DEFAULT 0 , 
            $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 DATETIME DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')) )
                ''');

          await customStatement('''
          INSERT INTO ${Old_Field_DBV6_AppV32.TABLE_NAME} ( ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME}
                 , $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32 ) 
                SELECT ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME}
                , $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32
                FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');
        }

        if (from < 7) {
          await customStatement('''
CREATE TABLE IF NOT EXISTS ${STring.TABLE_NAME} ( 
             $COLUMN_ID INTEGER PRIMARY KEY NOT NULL, 
             ${STring.COLUMN_VALUE} TEXT UNIQUE NOT NULL)
                ''');

          await customStatement('''
                CREATE TABLE IF NOT EXISTS ${String_Entry.TABLE_NAME} (
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
             ${String_Entry.COLUMN_QUESTION}  INTEGER NOT NULL, 
             ${String_Entry.COLUMN_ANSWER}  INTEGER NOT NULL, 
             ${String_Entry.COLUMN_FIELD}  INTEGER NOT NULL, 
             ${String_Entry.COLUMN_PAUSED_ENHANCED_TEST_ORDER} INTEGER NOT NULL DEFAULT -1, 
             ${String_Entry.COLUMN_PAUSED_FULLY_RANDOM_TEST_ORDER} INTEGER NOT NULL DEFAULT -1, 
             ${String_Entry.COLUMN_PAUSED_STUDY_PERIOD_ORDER} INTEGER NOT NULL DEFAULT -1, 
             ${String_Entry.COLUMN_PAUSED_STUDY_AGAIN_ENHANCED_TEST_ORDER} INTEGER NOT NULL DEFAULT -1, 
             ${String_Entry.COLUMN_PAUSED_STUDY_AGAIN_FULLY_RANDOM_TEST_ORDER} INTEGER NOT NULL DEFAULT -1, 
             ${String_Entry.COLUMN_ASKED_COUNT} INTEGER NOT NULL DEFAULT 0, 
             ${String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT} INTEGER NOT NULL DEFAULT 0, 
             ${String_Entry.COLUMN_RANK} INTEGER NOT NULL DEFAULT 0, 
             ${String_Entry.COLUMN_CREATION_EMULATED_DATE} DATETIME DEFAULT NULL, 
             ${String_Entry.COLUMN_REMIND_AT} INTEGER DEFAULT NULL, 
             ${String_Entry.COLUMN_REMIND_AT_PENDINGINTENT_REQUEST} INTEGER DEFAULT NULL, 
             ${String_Entry.COLUMN_WHETHER_ASKED_AT_CURRENT_TEST_ROUND} INTEGER DEFAULT ${TestRound.ASKED_AT_CURRENT_ROUND} , 
             ${String_Entry.COLUMN_ORDER_OF_ENTRY} INTEGER DEFAULT 999999999, 
             $CREATION_DATE DATETIME NOT NULL DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')), 
            FOREIGN KEY( ${String_Entry.COLUMN_QUESTION} ) REFERENCES ${STring.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE NO ACTION, 
            FOREIGN KEY( ${String_Entry.COLUMN_ANSWER} ) REFERENCES  ${STring.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE NO ACTION, 
            FOREIGN KEY( ${String_Entry.COLUMN_FIELD} ) REFERENCES  ${FField.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE CASCADE, 
             UNIQUE ( ${String_Entry.COLUMN_QUESTION} , 
             ${String_Entry.COLUMN_ANSWER} , 
             ${String_Entry.COLUMN_FIELD} ))
                ''');

          await customStatement('''
ALTER TABLE  ${Old_Field_DBV6_AppV32.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
CREATE TABLE IF NOT EXISTS ${Old_Field_DBV12_AppV68.TABLE_NAME} ( 
             $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
             ${Old_Field_DBV12_AppV68.COLUMN_FIELD_NAME} TEXT UNIQUE NOT NULL, 
             ${Old_Field_DBV12_AppV68.COLUMN_FIELD_TYPE} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_ENTRY_QUESTION_COLUMN_DATA_TYPE} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_LOCALE} TEXT DEFAULT NULL, 
             ${Old_Field_DBV12_AppV68.COLUMN_CHECK_TYPE} INTEGER NOT NULL DEFAULT ${FField.DO_NOT_IGNORE_CASE} , 
             ${Old_Field_DBV12_AppV68.COLUMN_SORT_BY} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_LIST_TEXT_SIZE} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_QUESTION_AREA_SIZE} INTEGER NOT NULL DEFAULT 1, 
             ${Old_Field_DBV12_AppV68.COLUMN_ANSWER_AREA_SIZE} INTEGER NOT NULL DEFAULT 1, 
             ${Old_Field_DBV12_AppV68.COLUMN_TEST_TEXT_SIZE} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_ACTION_BAR_SHOWN} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_READ_ANSWER} INTEGER NOT NULL DEFAULT ${FField.DO_NOT_READ_ANSWER} , 
             ${Old_Field_DBV12_AppV68.COLUMN_USAGE_COUNT} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_CREATION_EMULATION_NUMBER} INTEGER NOT NULL DEFAULT ${Constants.NOT_EMULATED} , 
             ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TESTS} INTEGER NOT NULL DEFAULT ${FField.ZERO_RANDOM_QUICK_TESTS} , 
             ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TRIES} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_QUESTIONS} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_CONTROLLED_PORTION} INTEGER NOT NULL DEFAULT -1,              ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_WRONGNESS_LEVEL} INTEGER NOT NULL DEFAULT -1,                ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_RANK_LEVEL} INTEGER NOT NULL DEFAULT -1, 
             ${Old_Field_DBV12_AppV68.COLUMN_READING_QUESTION_LETTER_SECOND_TESTS} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_FIND_ANSWER_TIME_TESTS} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_TYPING_ANSWER_LETTER_SECOND_TESTS} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_READING_QUESTION_LETTER_SECOND_STUDY_TILL_CORRECT} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_FIND_ANSWER_TIME_STUDY_TILL_CORRECT} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_TYPING_ANSWER_LETTER_SECOND_STUDY_TILL_CORRECT} INTEGER NOT NULL DEFAULT 0, 
             ${Old_Field_DBV12_AppV68.COLUMN_TIME_OF_ANSWER_TESTS_DO_WHAT} INTEGER NOT NULL DEFAULT  ${TimeOfAnswer.NOTIFY} , 
             ${Old_Field_DBV12_AppV68.COLUMN_OBFUSCATE_QUESTION} INTEGER NOT NULL DEFAULT 0, 
             $CREATION_DATE DATETIME NOT NULL DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')))
                ''');

          await customStatement('''
INSERT INTO  ${Old_Field_DBV12_AppV68.TABLE_NAME} ( ${Old_Field_DBV12_AppV68.COLUMN_FIELD_NAME}
                     , ${Old_Field_DBV12_AppV68.COLUMN_FIELD_TYPE}
                     , $CREATION_DATE ) 
                    SELECT ${Old_Field_DBV6_AppV32.COLUMN_FIELD_NAME}
                    , ${Old_Field_DBV6_AppV32.COLUMN_FIELD_TYPE}
                    , $Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32
                    FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');

          await customStatement('''
INSERT INTO ${STring.TABLE_NAME} ( ${STring.COLUMN_VALUE} )
SELECT ${Old_Question_DBV6_AppV32.COLUMN_QUESTION_ENTRY}
FROM ${Old_Question_DBV6_AppV32.TABLE_NAME}
                ''');

          await customStatement('''
INSERT INTO ${STring.TABLE_NAME} ( ${STring.COLUMN_VALUE} )
SELECT ${Old_Answer_DBV6_AppV32.COLUMN_ANSWER_ENTRY}
FROM ${Old_Answer_DBV6_AppV32.TABLE_NAME}
                ''');

          await customStatement('''
DROP TABLE IF EXISTS ${Old_Question_DBV6_AppV32.TABLE_NAME}
                ''');

          await customStatement('''
DROP TABLE IF EXISTS ${Old_Answer_DBV6_AppV32.TABLE_NAME}
                ''');

          await customStatement('''
                INSERT INTO ${String_Entry.TABLE_NAME} (
                  ${String_Entry.COLUMN_QUESTION}, ${String_Entry.COLUMN_ANSWER},
                  ${String_Entry.COLUMN_FIELD}, $CREATION_DATE
                )
                SELECT s1.$COLUMN_ID, s2.$COLUMN_ID, f.$COLUMN_ID, l.$Old_COLUMN_NAME_CREATED_AT_DBV6_AppV32
                FROM 
                 ${Old_Linker_DBV6_AppV32.TABLE_NAME} l
                 INNER JOIN ${STring.TABLE_NAME} s1 ON l.${Old_Linker_DBV6_AppV32.COLUMN_QUESTION_LINK} = s1.${STring.COLUMN_VALUE}
                 INNER JOIN ${STring.TABLE_NAME} s2 ON l.${Old_Linker_DBV6_AppV32.COLUMN_ANSWER_LINK} = s2.${STring.COLUMN_VALUE}
                 INNER JOIN ${Old_Field_DBV12_AppV68.TABLE_NAME} f ON l.${Old_Linker_DBV6_AppV32.COLUMN_FIELD_LINK} = f.${Old_Field_DBV12_AppV68.COLUMN_FIELD_NAME}
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS ${Old_Linker_DBV6_AppV32.TABLE_NAME}
                ''');
        }

        if (from < 8) {
          await customStatement('''
ALTER TABLE ${Old_Field_DBV12_AppV68.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
                CREATE TABLE IF NOT EXISTS ${Old_Field_DBV12_AppV68.TABLE_NAME} ( 
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            ${Old_Field_DBV12_AppV68.COLUMN_FIELD_NAME} TEXT UNIQUE NOT NULL, 
            ${Old_Field_DBV12_AppV68.COLUMN_FIELD_TYPE} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_ENTRY_QUESTION_COLUMN_DATA_TYPE} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_LOCALE} TEXT DEFAULT NULL, 
            ${Old_Field_DBV12_AppV68.COLUMN_CHECK_TYPE} INTEGER NOT NULL DEFAULT ${FField.DO_NOT_IGNORE_CASE} , 
            ${Old_Field_DBV12_AppV68.COLUMN_SORT_BY} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_LIST_TEXT_SIZE} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_QUESTION_AREA_SIZE} INTEGER NOT NULL DEFAULT 1, 
            ${Old_Field_DBV12_AppV68.COLUMN_ANSWER_AREA_SIZE} INTEGER NOT NULL DEFAULT 1, 
            ${Old_Field_DBV12_AppV68.COLUMN_TEST_TEXT_SIZE} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_ACTION_BAR_SHOWN} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_READ_ANSWER} INTEGER NOT NULL DEFAULT  ${FField.DO_NOT_READ_ANSWER} , 
            ${Old_Field_DBV12_AppV68.COLUMN_USAGE_COUNT} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_CREATION_EMULATION_NUMBER} INTEGER NOT NULL DEFAULT ${Constants.NOT_EMULATED} , 
            ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TESTS} INTEGER NOT NULL DEFAULT ${FField.ZERO_RANDOM_QUICK_TESTS} , 
            ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TRIES} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_QUESTIONS} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_CONTROLLED_PORTION} INTEGER NOT NULL DEFAULT -1, 
            ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_WRONGNESS_LEVEL} INTEGER NOT NULL DEFAULT -1, 
            ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_RANK_LEVEL} INTEGER NOT NULL DEFAULT -1, 
            ${Old_Field_DBV12_AppV68.COLUMN_READING_QUESTION_LETTER_SECOND_TESTS} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_FIND_ANSWER_TIME_TESTS} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_TYPING_ANSWER_LETTER_SECOND_TESTS} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_READING_QUESTION_LETTER_SECOND_STUDY_TILL_CORRECT} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_FIND_ANSWER_TIME_STUDY_TILL_CORRECT} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_TYPING_ANSWER_LETTER_SECOND_STUDY_TILL_CORRECT} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_TIME_OF_ANSWER_TESTS_DO_WHAT} INTEGER NOT NULL DEFAULT ${TimeOfAnswer.NOTIFY} , 
            ${Old_Field_DBV12_AppV68.COLUMN_OBFUSCATE_QUESTION} INTEGER NOT NULL DEFAULT 0, 
            $CREATION_DATE DATETIME NOT NULL DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')))
                ''');

          await customStatement('''
                INSERT INTO  ${Old_Field_DBV12_AppV68.TABLE_NAME} ( $COLUMN_ID
                     ,  ${Old_Field_DBV12_AppV68.COLUMN_FIELD_NAME}
                     , ${Old_Field_DBV12_AppV68.COLUMN_FIELD_TYPE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_ENTRY_QUESTION_COLUMN_DATA_TYPE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_LOCALE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_CHECK_TYPE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_SORT_BY}
                     , ${Old_Field_DBV12_AppV68.COLUMN_LIST_TEXT_SIZE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_QUESTION_AREA_SIZE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_ANSWER_AREA_SIZE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_TEST_TEXT_SIZE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_ACTION_BAR_SHOWN}
                     , ${Old_Field_DBV12_AppV68.COLUMN_READ_ANSWER}
                     , ${Old_Field_DBV12_AppV68.COLUMN_USAGE_COUNT}
                     , ${Old_Field_DBV12_AppV68.COLUMN_CREATION_EMULATION_NUMBER}
                     , $CREATION_DATE ) 
                    SELECT $COLUMN_ID
                     , ${Old_Field_DBV12_AppV68.COLUMN_FIELD_NAME}
                     , ${Old_Field_DBV12_AppV68.COLUMN_FIELD_TYPE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_ENTRY_QUESTION_COLUMN_DATA_TYPE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_LOCALE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_CHECK_TYPE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_SORT_BY}
                     , ${Old_Field_DBV12_AppV68.COLUMN_LIST_TEXT_SIZE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_QUESTION_AREA_SIZE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_ANSWER_AREA_SIZE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_TEST_TEXT_SIZE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_ACTION_BAR_SHOWN}
                     , ${Old_Field_DBV12_AppV68.COLUMN_READ_ANSWER}
                     , ${Old_Field_DBV12_AppV68.COLUMN_USAGE_COUNT}
                     , ${Old_Field_DBV12_AppV68.COLUMN_CREATION_EMULATION_NUMBER}
                     , $CREATION_DATE
                    FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');

          await customStatement('''
ALTER TABLE ${String_Entry.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
CREATE TABLE IF NOT EXISTS ${Old_String_Entry.TABLE_NAME} ( 
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            ${Old_String_Entry.COLUMN_QUESTION} INTEGER NOT NULL, 
            ${Old_String_Entry.COLUMN_ANSWER} INTEGER NOT NULL, 
            ${Old_String_Entry.COLUMN_FIELD} INTEGER NOT NULL, 
            ${Old_String_Entry.COLUMN_PAUSED_TEST_ORDER} INTEGER NOT NULL DEFAULT -1, 
            ${Old_String_Entry.COLUMN_PAUSED_STUDY_PERIOD_ORDER} INTEGER NOT NULL DEFAULT -1, 
            ${Old_String_Entry.COLUMN_ASKED_COUNT} INTEGER NOT NULL DEFAULT 0, 
            ${Old_String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT} INTEGER NOT NULL DEFAULT 0, 
            ${Old_String_Entry.COLUMN_RANK} INTEGER NOT NULL DEFAULT 0, 
            ${Old_String_Entry.COLUMN_CREATION_EMULATED_DATE} DATETIME DEFAULT NULL, 
            ${Old_String_Entry.COLUMN_REMIND_AT} INTEGER DEFAULT NULL, 
            ${Old_String_Entry.COLUMN_REMIND_AT_PENDINGINTENT_REQUEST} INTEGER DEFAULT NULL, 
            ${Old_String_Entry.COLUMN_WHETHER_ASKED_AT_CURRENT_TEST_ROUND} INTEGER DEFAULT ${TestRound.ASKED_AT_CURRENT_ROUND} , 
            ${Old_String_Entry.COLUMN_ORDER_OF_ENTRY} INTEGER DEFAULT NULL, 
            $CREATION_DATE DATETIME NOT NULL DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')), 
            FOREIGN KEY( ${Old_String_Entry.COLUMN_QUESTION} ) REFERENCES ${STring.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE NO ACTION, 
            FOREIGN KEY( ${Old_String_Entry.COLUMN_ANSWER} ) REFERENCES ${STring.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE NO ACTION, 
            FOREIGN KEY( ${Old_String_Entry.COLUMN_FIELD} ) REFERENCES ${FField.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE CASCADE, 
            UNIQUE ( ${Old_String_Entry.COLUMN_QUESTION} , 
            ${Old_String_Entry.COLUMN_ANSWER} , 
            ${Old_String_Entry.COLUMN_FIELD} ))
                ''');

          await customStatement('''
                INSERT INTO ${String_Entry.TABLE_NAME} ( $COLUMN_ID
                     , ${String_Entry.COLUMN_QUESTION}
                     , ${String_Entry.COLUMN_ANSWER}
                     , ${String_Entry.COLUMN_FIELD}
                     , ${String_Entry.COLUMN_ASKED_COUNT}
                     , ${String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT}
                     , ${String_Entry.COLUMN_RANK}
                     , ${String_Entry.COLUMN_CREATION_EMULATED_DATE}
                     , $CREATION_DATE) 
                    SELECT $COLUMN_ID
                    , ${String_Entry.COLUMN_QUESTION}
                    , ${String_Entry.COLUMN_ANSWER}
                    , ${String_Entry.COLUMN_FIELD}
                    , ${String_Entry.COLUMN_ASKED_COUNT}
                    , ${String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT}
                    , ${String_Entry.COLUMN_RANK}
                    , ${String_Entry.COLUMN_CREATION_EMULATED_DATE}
                    , $CREATION_DATE
                    FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');
        }

        if (from < 9) {
          await customStatement('''
            ALTER TABLE ${Old_Field_DBV12_AppV68.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
CREATE TABLE IF NOT EXISTS ${Old_Field_DBV12_AppV68.TABLE_NAME} ( 
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            ${Old_Field_DBV12_AppV68.COLUMN_FIELD_NAME} TEXT UNIQUE NOT NULL, 
            ${Old_Field_DBV12_AppV68.COLUMN_FIELD_TYPE} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_ENTRY_QUESTION_COLUMN_DATA_TYPE} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_LOCALE} TEXT DEFAULT NULL, 
            ${Old_Field_DBV12_AppV68.COLUMN_CHECK_TYPE} INTEGER NOT NULL DEFAULT ${FField.DO_NOT_IGNORE_CASE} , 
            ${Old_Field_DBV12_AppV68.COLUMN_SORT_BY} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_LIST_TEXT_SIZE} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_QUESTION_AREA_SIZE} INTEGER NOT NULL DEFAULT 1, 
            ${Old_Field_DBV12_AppV68.COLUMN_ANSWER_AREA_SIZE} INTEGER NOT NULL DEFAULT 1, 
            ${Old_Field_DBV12_AppV68.COLUMN_TEST_TEXT_SIZE} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_ACTION_BAR_SHOWN} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_READ_ANSWER} INTEGER NOT NULL DEFAULT ${FField.DO_NOT_READ_ANSWER} , 
            ${Old_Field_DBV12_AppV68.COLUMN_USAGE_COUNT} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_CREATION_EMULATION_NUMBER} INTEGER NOT NULL DEFAULT  ${Constants.NOT_EMULATED} , 
            ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TESTS} INTEGER NOT NULL DEFAULT ${FField.ZERO_RANDOM_QUICK_TESTS} , 
            ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TRIES} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_QUESTIONS} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_CONTROLLED_PORTION} INTEGER NOT NULL DEFAULT -1, 
            ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_WRONGNESS_LEVEL} INTEGER NOT NULL DEFAULT -1, 
            ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_RANK_LEVEL} INTEGER NOT NULL DEFAULT -1, 
            ${Old_Field_DBV12_AppV68.COLUMN_READING_QUESTION_LETTER_SECOND_TESTS} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_FIND_ANSWER_TIME_TESTS} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_TYPING_ANSWER_LETTER_SECOND_TESTS} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_READING_QUESTION_LETTER_SECOND_STUDY_TILL_CORRECT} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_FIND_ANSWER_TIME_STUDY_TILL_CORRECT} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_TYPING_ANSWER_LETTER_SECOND_STUDY_TILL_CORRECT} INTEGER NOT NULL DEFAULT 0, 
            ${Old_Field_DBV12_AppV68.COLUMN_TIME_OF_ANSWER_TESTS_DO_WHAT} INTEGER NOT NULL DEFAULT ${TimeOfAnswer.NOTIFY} , 
            ${Old_Field_DBV12_AppV68.COLUMN_OBFUSCATE_QUESTION} INTEGER NOT NULL DEFAULT 0, 
            $CREATION_DATE DATETIME NOT NULL DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')))
                ''');

          await customStatement('''
                INSERT INTO ${Old_Field_DBV12_AppV68.TABLE_NAME} ( $COLUMN_ID
                    , ${Old_Field_DBV12_AppV68.COLUMN_FIELD_NAME}
                    , ${Old_Field_DBV12_AppV68.COLUMN_FIELD_TYPE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_ENTRY_QUESTION_COLUMN_DATA_TYPE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_LOCALE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_CHECK_TYPE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_SORT_BY}
                    , ${Old_Field_DBV12_AppV68.COLUMN_LIST_TEXT_SIZE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_QUESTION_AREA_SIZE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_ANSWER_AREA_SIZE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_TEST_TEXT_SIZE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_ACTION_BAR_SHOWN}
                    , ${Old_Field_DBV12_AppV68.COLUMN_READ_ANSWER}
                    , ${Old_Field_DBV12_AppV68.COLUMN_USAGE_COUNT}
                    , ${Old_Field_DBV12_AppV68.COLUMN_CREATION_EMULATION_NUMBER}
                    , ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TESTS}
                    , ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TRIES}
                    , ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_QUESTIONS}
                    , $CREATION_DATE)
                    SELECT $COLUMN_ID
                    , ${Old_Field_DBV12_AppV68.COLUMN_FIELD_NAME}
                    , ${Old_Field_DBV12_AppV68.COLUMN_FIELD_TYPE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_ENTRY_QUESTION_COLUMN_DATA_TYPE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_LOCALE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_CHECK_TYPE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_SORT_BY}
                    , ${Old_Field_DBV12_AppV68.COLUMN_LIST_TEXT_SIZE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_QUESTION_AREA_SIZE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_ANSWER_AREA_SIZE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_TEST_TEXT_SIZE}
                    , ${Old_Field_DBV12_AppV68.COLUMN_ACTION_BAR_SHOWN}
                    , ${Old_Field_DBV12_AppV68.COLUMN_READ_ANSWER}
                    , ${Old_Field_DBV12_AppV68.COLUMN_USAGE_COUNT}
                    , ${Old_Field_DBV12_AppV68.COLUMN_CREATION_EMULATION_NUMBER}
                    , ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TESTS}
                    , ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TRIES}
                    , ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_QUESTIONS}
                    , $CREATION_DATE
                    FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');
        }

        if (from < 10) {
          await customStatement('''
            ALTER TABLE ${String_Entry.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
CREATE TABLE IF NOT EXISTS ${Old_String_Entry.TABLE_NAME} ( 
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            ${Old_String_Entry.COLUMN_QUESTION} INTEGER NOT NULL, 
            ${Old_String_Entry.COLUMN_ANSWER} INTEGER NOT NULL, 
            ${Old_String_Entry.COLUMN_FIELD} INTEGER NOT NULL, 
            ${Old_String_Entry.COLUMN_PAUSED_TEST_ORDER} INTEGER NOT NULL DEFAULT -1, 
            ${Old_String_Entry.COLUMN_PAUSED_STUDY_PERIOD_ORDER} INTEGER NOT NULL DEFAULT -1, 
            ${Old_String_Entry.COLUMN_ASKED_COUNT} INTEGER NOT NULL DEFAULT 0, 
            ${Old_String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT} INTEGER NOT NULL DEFAULT 0, 
            ${Old_String_Entry.COLUMN_RANK} INTEGER NOT NULL DEFAULT 0, 
            ${Old_String_Entry.COLUMN_CREATION_EMULATED_DATE} DATETIME DEFAULT NULL, 
            ${Old_String_Entry.COLUMN_REMIND_AT} INTEGER DEFAULT NULL, 
            ${Old_String_Entry.COLUMN_REMIND_AT_PENDINGINTENT_REQUEST} INTEGER DEFAULT NULL, 
            ${Old_String_Entry.COLUMN_WHETHER_ASKED_AT_CURRENT_TEST_ROUND} INTEGER DEFAULT  ${TestRound.ASKED_AT_CURRENT_ROUND} , 
            ${Old_String_Entry.COLUMN_ORDER_OF_ENTRY} INTEGER DEFAULT NULL, 
            $CREATION_DATE DATETIME NOT NULL DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')), 
            FOREIGN KEY(${Old_String_Entry.COLUMN_QUESTION} ) REFERENCES ${STring.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE NO ACTION, 
            FOREIGN KEY( ${Old_String_Entry.COLUMN_ANSWER} ) REFERENCES ${STring.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE NO ACTION, 
            FOREIGN KEY( ${Old_String_Entry.COLUMN_FIELD} ) REFERENCES ${FField.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE CASCADE, 
             UNIQUE ( ${Old_String_Entry.COLUMN_QUESTION} , 
            ${Old_String_Entry.COLUMN_ANSWER} , 
            ${Old_String_Entry.COLUMN_FIELD} ));
                ''');

          await customStatement('''
                INSERT INTO  ${String_Entry.TABLE_NAME} ( $COLUMN_ID
                     , ${String_Entry.COLUMN_QUESTION}
                     , ${String_Entry.COLUMN_ANSWER}
                     , ${String_Entry.COLUMN_FIELD}
                     , ${String_Entry.COLUMN_ASKED_COUNT}
                     , ${String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT}
                     , ${String_Entry.COLUMN_RANK}
                     , ${String_Entry.COLUMN_CREATION_EMULATED_DATE}
                     , ${String_Entry.COLUMN_REMIND_AT}
                     , ${String_Entry.COLUMN_REMIND_AT_PENDINGINTENT_REQUEST}
                     , $CREATION_DATE)
                    SELECT $COLUMN_ID
                     , ${String_Entry.COLUMN_QUESTION}
                     , ${String_Entry.COLUMN_ANSWER}
                     , ${String_Entry.COLUMN_FIELD}
                     , ${String_Entry.COLUMN_ASKED_COUNT}
                     , ${String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT}
                     , ${String_Entry.COLUMN_RANK}
                     , ${String_Entry.COLUMN_CREATION_EMULATED_DATE}
                     , ${String_Entry.COLUMN_REMIND_AT}
                     , ${String_Entry.COLUMN_REMIND_AT_PENDINGINTENT_REQUEST}
                     , $CREATION_DATE
                     FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');

          await customStatement('''
CREATE TABLE IF NOT EXISTS ${Field_Note.TABLE_NAME} ( 
            $COLUMN_ID INTEGER PRIMARY KEY NOT NULL, 
            ${Field_Note.COLUMN_FIELD} INTEGER NOT NULL, 
            ${Field_Note.COLUMN_NOTE} TEXT NOT NULL, 
            FOREIGN KEY( ${Field_Note.COLUMN_FIELD} ) REFERENCES  ${FField.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE CASCADE, 
             UNIQUE ( ${Field_Note.COLUMN_FIELD} , 
            ${Field_Note.COLUMN_NOTE}  ))
                ''');
        }

        if (from < 11) {
          await customStatement('''
DROP TABLE IF EXISTS field_type_symbol 
                ''');

          await customStatement('''
DROP TABLE IF EXISTS field_type
                ''');

          await customStatement('''
                ALTER TABLE ${Old_String_Entry.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
                CREATE TABLE IF NOT EXISTS ${String_Entry.TABLE_NAME} ( 
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            ${String_Entry.COLUMN_QUESTION} INTEGER NOT NULL, 
            ${String_Entry.COLUMN_ANSWER} INTEGER NOT NULL, 
            ${String_Entry.COLUMN_FIELD} INTEGER NOT NULL, 
            ${String_Entry.COLUMN_ASKED_COUNT} INTEGER NOT NULL DEFAULT 0, 
            ${String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT} INTEGER NOT NULL DEFAULT 0, 
            ${String_Entry.COLUMN_RANK} INTEGER NOT NULL DEFAULT 0, 
            ${String_Entry.COLUMN_CREATION_EMULATED_DATE} DATETIME DEFAULT NULL, 
            ${String_Entry.COLUMN_REMIND_AT} INTEGER DEFAULT NULL, 
            ${String_Entry.COLUMN_REMIND_AT_PENDINGINTENT_REQUEST} INTEGER DEFAULT NULL, 
            ${String_Entry.COLUMN_WHETHER_ASKED_AT_CURRENT_TEST_ROUND} INTEGER DEFAULT ${TestRound.ASKED_AT_CURRENT_ROUND}, 
            ${String_Entry.COLUMN_ORDER_OF_ENTRY} INTEGER DEFAULT 999999999, 
            $CREATION_DATE DATETIME NOT NULL DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')), 
            FOREIGN KEY( ${String_Entry.COLUMN_QUESTION} ) REFERENCES  ${STring.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE NO ACTION, 
            FOREIGN KEY( ${String_Entry.COLUMN_ANSWER} ) REFERENCES ${STring.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE NO ACTION, 
            FOREIGN KEY( ${String_Entry.COLUMN_FIELD} ) REFERENCES  ${FField.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE CASCADE, 
             UNIQUE ( ${String_Entry.COLUMN_QUESTION} , 
             ${String_Entry.COLUMN_ANSWER} , 
             ${String_Entry.COLUMN_FIELD}  ))
                ''');

          await customStatement('''
                INSERT INTO  ${String_Entry.TABLE_NAME} (  $COLUMN_ID
                     , ${String_Entry.COLUMN_QUESTION}
                     , ${String_Entry.COLUMN_ANSWER}
                     , ${String_Entry.COLUMN_FIELD}
                     , ${String_Entry.COLUMN_ASKED_COUNT}
                     , ${String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT}
                     , ${String_Entry.COLUMN_RANK}
                     , ${String_Entry.COLUMN_CREATION_EMULATED_DATE}
                     , ${String_Entry.COLUMN_REMIND_AT}
                     , ${String_Entry.COLUMN_REMIND_AT_PENDINGINTENT_REQUEST}
                     , ${String_Entry.COLUMN_WHETHER_ASKED_AT_CURRENT_TEST_ROUND}
                     , ${String_Entry.COLUMN_ORDER_OF_ENTRY}
                     , $CREATION_DATE)
                    SELECT $COLUMN_ID
                     , ${Old_String_Entry.COLUMN_QUESTION}
                     , ${Old_String_Entry.COLUMN_ANSWER}
                     , ${Old_String_Entry.COLUMN_FIELD}
                     , ${Old_String_Entry.COLUMN_ASKED_COUNT}
                     , ${Old_String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT}
                     , ${Old_String_Entry.COLUMN_RANK}
                     , ${Old_String_Entry.COLUMN_CREATION_EMULATED_DATE}
                     , ${Old_String_Entry.COLUMN_REMIND_AT}
                     , ${Old_String_Entry.COLUMN_REMIND_AT_PENDINGINTENT_REQUEST}
                     , ${Old_String_Entry.COLUMN_WHETHER_ASKED_AT_CURRENT_TEST_ROUND}
                     , ${Old_String_Entry.COLUMN_ORDER_OF_ENTRY}
                     , $CREATION_DATE
                     FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');
        }

        if (from < 13) {
          await customStatement('''
DELETE FROM ${FField.TABLE_NAME} WHERE ${Old_Field_DBV12_AppV68.COLUMN_FIELD_TYPE} = 1
''');

          await customStatement('''
ALTER TABLE ${Old_Field_DBV12_AppV68.TABLE_NAME} RENAME TO tempTable
''');

          await customStatement('''
CREATE TABLE IF NOT EXISTS ${FField.TABLE_NAME} ( 
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            ${FField.COLUMN_FIELD_NAME} TEXT UNIQUE NOT NULL, 
            ${FField.COLUMN_ENTRY_QUESTION_COLUMN_DATA_TYPE} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_LOCALE} TEXT DEFAULT NULL, 
            ${FField.COLUMN_CHECK_TYPE} INTEGER NOT NULL DEFAULT ${FField.DO_NOT_IGNORE_CASE} , 
            ${FField.COLUMN_SORT_BY} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_COLOR} INTEGER NOT NULL DEFAULT -1, 
            ${FField.COLUMN_LIST_TEXT_SIZE} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_QUESTION_AREA_SIZE} INTEGER NOT NULL DEFAULT 1, 
            ${FField.COLUMN_ANSWER_AREA_SIZE} INTEGER NOT NULL DEFAULT 1, 
            ${FField.COLUMN_TEST_TEXT_SIZE} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_ACTION_BAR_SHOWN} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_READ_ANSWER} INTEGER NOT NULL DEFAULT ${FField.DO_NOT_READ_ANSWER} , 
            ${FField.COLUMN_USAGE_COUNT} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_CREATION_EMULATION_NUMBER} INTEGER NOT NULL DEFAULT ${Constants.NOT_EMULATED} , 
            ${FField.COLUMN_CREATION_EMULATION_WHAT_DAYS} INTEGER DEFAULT NULL, 
            ${FField.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TESTS} INTEGER NOT NULL DEFAULT ${FField.ZERO_RANDOM_QUICK_TESTS} , 
            ${FField.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TRIES} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_QUESTIONS} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_RANDOM_QUICK_TEST_CONTROLLED_PORTION} INTEGER NOT NULL DEFAULT -1, 
            ${FField.COLUMN_RANDOM_QUICK_TEST_WRONGNESS_LEVEL} INTEGER NOT NULL DEFAULT -1, 
            ${FField.COLUMN_RANDOM_QUICK_TEST_RANK_LEVEL} INTEGER NOT NULL DEFAULT -1, 
            ${FField.COLUMN_READING_QUESTION_LETTER_SECOND_TESTS} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_FIND_ANSWER_TIME_TESTS} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_TYPING_ANSWER_LETTER_SECOND_TESTS} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_READING_QUESTION_LETTER_SECOND_STUDY_TILL_CORRECT} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_FIND_ANSWER_TIME_STUDY_TILL_CORRECT} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_TYPING_ANSWER_LETTER_SECOND_STUDY_TILL_CORRECT} INTEGER NOT NULL DEFAULT 0, 
            ${FField.COLUMN_TIME_OF_ANSWER_TESTS_DO_WHAT} INTEGER NOT NULL DEFAULT ${TimeOfAnswer.NOTIFY}, 
            ${FField.COLUMN_OBFUSCATE_QUESTION} INTEGER NOT NULL DEFAULT 0, 
            $CREATION_DATE DATETIME NOT NULL DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')) )
''');

          await customStatement('''
INSERT INTO ${FField.TABLE_NAME} ( $COLUMN_ID
                     , ${FField.COLUMN_FIELD_NAME}
                     , ${FField.COLUMN_ENTRY_QUESTION_COLUMN_DATA_TYPE}
                     , ${FField.COLUMN_LOCALE}
                     , ${FField.COLUMN_CHECK_TYPE}
                     , ${FField.COLUMN_SORT_BY}
                     , ${FField.COLUMN_LIST_TEXT_SIZE}
                     , ${FField.COLUMN_QUESTION_AREA_SIZE}
                     , ${FField.COLUMN_ANSWER_AREA_SIZE}
                     , ${FField.COLUMN_TEST_TEXT_SIZE}
                     , ${FField.COLUMN_ACTION_BAR_SHOWN}
                     , ${FField.COLUMN_READ_ANSWER}
                     , ${FField.COLUMN_USAGE_COUNT}
                     , ${FField.COLUMN_CREATION_EMULATION_NUMBER}
                     , ${FField.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TESTS}
                     , ${FField.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TRIES}
                     , ${FField.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_QUESTIONS}
                     , ${FField.COLUMN_RANDOM_QUICK_TEST_CONTROLLED_PORTION}
                     , ${FField.COLUMN_RANDOM_QUICK_TEST_WRONGNESS_LEVEL}
                     , ${FField.COLUMN_RANDOM_QUICK_TEST_RANK_LEVEL}
                     , $CREATION_DATE )
                    SELECT $COLUMN_ID
                     , ${Old_Field_DBV12_AppV68.COLUMN_FIELD_NAME}
                     , ${Old_Field_DBV12_AppV68.COLUMN_ENTRY_QUESTION_COLUMN_DATA_TYPE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_LOCALE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_CHECK_TYPE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_SORT_BY}
                     , ${Old_Field_DBV12_AppV68.COLUMN_LIST_TEXT_SIZE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_QUESTION_AREA_SIZE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_ANSWER_AREA_SIZE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_TEST_TEXT_SIZE}
                     , ${Old_Field_DBV12_AppV68.COLUMN_ACTION_BAR_SHOWN}
                     , ${Old_Field_DBV12_AppV68.COLUMN_READ_ANSWER}
                     , ${Old_Field_DBV12_AppV68.COLUMN_USAGE_COUNT}
                     , ${Old_Field_DBV12_AppV68.COLUMN_CREATION_EMULATION_NUMBER}
                     , ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TESTS}
                     , ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_TRIES}
                     , ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_NUMBER_OF_QUESTIONS}
                     , ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_CONTROLLED_PORTION}
                     , ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_WRONGNESS_LEVEL}
                     , ${Old_Field_DBV12_AppV68.COLUMN_RANDOM_QUICK_TEST_RANK_LEVEL}
                     , $CREATION_DATE
                     FROM tempTable
''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');

          await customStatement('''
                ALTER TABLE ${String_Entry.TABLE_NAME} RENAME TO tempTable
                ''');

          await customStatement('''
                CREATE TABLE IF NOT EXISTS ${String_Entry.TABLE_NAME} ( 
            $COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
            ${String_Entry.COLUMN_QUESTION} INTEGER NOT NULL, 
            ${String_Entry.COLUMN_ANSWER} INTEGER NOT NULL, 
            ${String_Entry.COLUMN_FIELD} INTEGER NOT NULL, 
            ${String_Entry.COLUMN_PAUSED_ENHANCED_TEST_ORDER} INTEGER NOT NULL DEFAULT -1, 
            ${String_Entry.COLUMN_PAUSED_FULLY_RANDOM_TEST_ORDER} INTEGER NOT NULL DEFAULT -1, 
            ${String_Entry.COLUMN_PAUSED_STUDY_PERIOD_ORDER} INTEGER NOT NULL DEFAULT -1, 
            ${String_Entry.COLUMN_PAUSED_STUDY_AGAIN_ENHANCED_TEST_ORDER} INTEGER NOT NULL DEFAULT -1, 
            ${String_Entry.COLUMN_PAUSED_STUDY_AGAIN_FULLY_RANDOM_TEST_ORDER} INTEGER NOT NULL DEFAULT -1, 
            ${String_Entry.COLUMN_ASKED_COUNT} INTEGER NOT NULL DEFAULT 0, 
            ${String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT} INTEGER NOT NULL DEFAULT 0, 
            ${String_Entry.COLUMN_RANK} INTEGER NOT NULL DEFAULT 0, 
            ${String_Entry.COLUMN_CREATION_EMULATED_DATE} DATETIME DEFAULT NULL, 
            ${String_Entry.COLUMN_REMIND_AT} INTEGER DEFAULT NULL, 
            ${String_Entry.COLUMN_REMIND_AT_PENDINGINTENT_REQUEST} INTEGER DEFAULT NULL, 
            ${String_Entry.COLUMN_WHETHER_ASKED_AT_CURRENT_TEST_ROUND} INTEGER DEFAULT ${TestRound.ASKED_AT_CURRENT_ROUND} , 
            ${String_Entry.COLUMN_ORDER_OF_ENTRY} INTEGER DEFAULT 999999999, 
            $CREATION_DATE DATETIME NOT NULL DEFAULT (DATETIME(CURRENT_TIMESTAMP, 'LOCALTIME')), 
            FOREIGN KEY( ${String_Entry.COLUMN_QUESTION} ) REFERENCES ${STring.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE NO ACTION, 
            FOREIGN KEY( ${String_Entry.COLUMN_ANSWER} ) REFERENCES ${STring.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE NO ACTION, 
            FOREIGN KEY( ${String_Entry.COLUMN_FIELD} ) REFERENCES ${FField.TABLE_NAME} ( $COLUMN_ID ) ON UPDATE CASCADE ON DELETE CASCADE, 
             UNIQUE ( ${String_Entry.COLUMN_QUESTION} , 
             ${String_Entry.COLUMN_ANSWER} , 
             ${String_Entry.COLUMN_FIELD} ))
                ''');

          await customStatement('''
                INSERT INTO ${String_Entry.TABLE_NAME} ( $COLUMN_ID
                     , ${String_Entry.COLUMN_QUESTION}
                     , ${String_Entry.COLUMN_ANSWER}
                     , ${String_Entry.COLUMN_FIELD}
                     , ${String_Entry.COLUMN_ASKED_COUNT}
                     , ${String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT}
                     , ${String_Entry.COLUMN_RANK}
                     , ${String_Entry.COLUMN_CREATION_EMULATED_DATE}
                     , ${String_Entry.COLUMN_REMIND_AT}
                     , ${String_Entry.COLUMN_REMIND_AT_PENDINGINTENT_REQUEST}
                     , ${String_Entry.COLUMN_WHETHER_ASKED_AT_CURRENT_TEST_ROUND}
                     , ${String_Entry.COLUMN_ORDER_OF_ENTRY}
                     , $CREATION_DATE)
                    SELECT $COLUMN_ID
                     , ${String_Entry.COLUMN_QUESTION}
                     , ${String_Entry.COLUMN_ANSWER}
                     , ${String_Entry.COLUMN_FIELD}
                     , ${String_Entry.COLUMN_ASKED_COUNT}
                     , ${String_Entry.COLUMN_WRONGLY_ANSWERED_COUNT}
                     , ${String_Entry.COLUMN_RANK}
                     , ${String_Entry.COLUMN_CREATION_EMULATED_DATE}
                     , ${String_Entry.COLUMN_REMIND_AT}
                     , ${String_Entry.COLUMN_REMIND_AT_PENDINGINTENT_REQUEST}
                     , ${String_Entry.COLUMN_WHETHER_ASKED_AT_CURRENT_TEST_ROUND}
                     , ${String_Entry.COLUMN_ORDER_OF_ENTRY}
                     , $CREATION_DATE
                     FROM tempTable
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS tempTable
                ''');

          await customStatement('''
UPDATE ${String_Entry.TABLE_NAME} SET ${String_Entry.COLUMN_ORDER_OF_ENTRY} = 999999999 WHERE ${String_Entry.COLUMN_ORDER_OF_ENTRY} IS NULL 
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS ${Old_Study_Period_Repeated_Entry_DBV12_AppV68.TABLE_NAME} 
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS ${Old_Study_Period_Paused_DBV12_AppV68.TABLE_NAME} 
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS symbol
                ''');

          await customStatement('''
                DROP TABLE IF EXISTS field_type_symbol
                ''');

          await customStatement('''
DELETE FROM ${FField.TABLE_NAME} WHERE LENGTH( ${FField.COLUMN_FIELD_NAME} ) > 500
''');

          await customStatement('''
DELETE FROM ${String_Entry.TABLE_NAME} WHERE ${String_Entry.COLUMN_QUESTION} IN (SELECT $COLUMN_ID FROM ${STring.TABLE_NAME} WHERE LENGTH( ${STring.COLUMN_VALUE} ) > 500 )
OR ${String_Entry.COLUMN_ANSWER} IN (SELECT $COLUMN_ID FROM ${STring.TABLE_NAME} WHERE LENGTH( ${STring.COLUMN_VALUE} ) > 500 )
''');

          await customStatement('''
DELETE FROM ${STring.TABLE_NAME} WHERE LENGTH( ${STring.COLUMN_VALUE} ) > 500
''');
        }

        if (from < 14) {
          await customStatement('DROP TABLE IF EXISTS not_string');
          await customStatement('DROP TABLE IF EXISTS not_string_entry');
          await customStatement(
            'DROP TABLE IF EXISTS test_wrong_answer_string',
          );
          await customStatement(
            'DROP TABLE IF EXISTS test_wrong_answer_not_string',
          );
          await customStatement('DROP TABLE IF EXISTS test_paused');
          await customStatement(
            'DROP TABLE IF EXISTS study_till_correct_repeated_entry',
          );
          await customStatement(
            'DROP TABLE IF EXISTS study_till_correct_paused',
          );
          await customStatement(
            'DROP TABLE IF EXISTS alternative_answer_string',
          );
          await customStatement(
            'DROP TABLE IF EXISTS alternative_answer_not_string',
          );
          await customStatement('DROP TABLE IF EXISTS excluded_time');
          await customStatement('DROP TABLE IF EXISTS scheduled_time_backup');
          await customStatement('DROP TABLE IF EXISTS google_payment_order_id');
          await m.createAll();
          final now = clock.now();
          final fieldId = const Uuid().v4();
          await m.database
              .into(fields)
              .insert(
                FieldsCompanion(
                  id: Value(fieldId),
                  userAccountId: const Value(migrationUserAccountId),
                  name: const Value('field'),
                  creationAt: Value(now),
                  lastModificationAt: Value(now),
                ),
              );
          List<QueryRow> results = await customSelect('''
SELECT
  _id,
  name,
  creation_date,
  creation_date,
  locale,
  check_type,
  sort_by,
  read_answer,
  usage_count,
  color,
  creation_emulation_number,
  creation_emulation_what_days,
  reading_question_letter_second_tests,
  find_answer_time_tests,
  typing_answer_letter_second_tests,
  reading_question_letter_second_study_till_correct,
  find_answer_time_study_till_correct,
  typing_answer_letter_second_study_till_correct,
  time_of_answer_tests_do_what,
  obfuscate_question
FROM field
''').get();
          final List<FieldListsCompanion> fieldListCompanions = [];
          final fieldToFieldListMapping = <int, String>{};
          for (int i = 0; i < results.length; i++) {
            final data = results[i].data;
            final String currentFieldListId = const Uuid().v4();
            fieldToFieldListMapping[data['_id'] as int] = currentFieldListId;
            fieldListCompanions.add(
              FieldListsCompanion(
                id: Value(currentFieldListId),
                fieldId: Value(fieldId),
                name: Value(data['name'] as String),
                creationAt: Value(
                  DateTime.parse(data['creation_date'] as String),
                ),
                lastModificationAt: Value(
                  DateTime.parse(data['creation_date'] as String),
                ),
                languageTag: Value(data['locale'] as String?),
                checkType: Value(data['check_type'] as int),
                sortBy: Value(data['sort_by'] as int),
                doesReadAnswer: Value((data['read_answer'] as int) == 1),
                usageCount: Value(data['usage_count'] as int),
                color: Value(
                  (data['color'] as int) < 0 ? 0 : (data['color'] as int),
                ),
                testsReadingQuestionLetterDuration:
                    (data['reading_question_letter_second_tests'] as int) > 0
                    ? Value(data['reading_question_letter_second_tests'] as int)
                    : const Value.absent(),
                testsFindingAnswerDuration:
                    (data['find_answer_time_tests'] as int) > 0
                    ? Value(data['find_answer_time_tests'] as int)
                    : const Value.absent(),
                testsTypingAnswerLetterDuration:
                    (data['typing_answer_letter_second_tests'] as int) > 0
                    ? Value(data['typing_answer_letter_second_tests'] as int)
                    : const Value.absent(),
                studyTillCorrectReadingQuestionLetterDuration:
                    (data['reading_question_letter_second_study_till_correct']
                            as int) >
                        0
                    ? Value(
                        data['reading_question_letter_second_study_till_correct']
                            as int,
                      )
                    : const Value.absent(),
                studyTillCorrectFindingAnswerDuration:
                    (data['find_answer_time_study_till_correct'] as int) > 0
                    ? Value(data['find_answer_time_study_till_correct'] as int)
                    : const Value.absent(),
                studyTillCorrectTypingAnswerLetterDuration:
                    (data['typing_answer_letter_second_study_till_correct']
                            as int) >
                        0
                    ? Value(
                        data['typing_answer_letter_second_study_till_correct']
                            as int,
                      )
                    : const Value.absent(),
                testsTimeOfAnswerAction: Value(
                  data['time_of_answer_tests_do_what'] as int,
                ),
                doesObfuscateQuestion: Value(
                  (data['obfuscate_question'] as int) == 1,
                ),
              ),
            );
          }
          await batch(
            (batch) => batch.insertAll(fieldLists, fieldListCompanions),
          );
          results = await customSelect('''
SELECT
  s2.value answer,
  s1.value question,
  se.field,
  se.creation_date creationAt,
  se.creation_date lastModificationAt,
  se.order_of_entry,
  se.whether_asked_at_current_test_round,
  se.creation_emulated_date,
  se.rank,
  se.asked_count,
  se.wrongly_answered_count
FROM string_entry se
INNER JOIN string s1      ON se.question = s1._id
INNER JOIN string s2      ON se.answer = s2._id
''').get();
          List<EntrysCompanion> entrysCompanions = [];
          for (int i = 0; i < results.length; i++) {
            final data = results[i].data;
            entrysCompanions.add(
              EntrysCompanion(
                fieldListId: Value(
                  fieldToFieldListMapping[data['field'] as int]!,
                ),
                answer: Value(data['answer'] as String),
                question: Value(data['question'] as String),
                creationAt: Value(DateTime.parse(data['creationAt'] as String)),
                lastModificationAt: Value(
                  DateTime.parse(data['lastModificationAt'] as String),
                ),
                order: (data['order_of_entry'] as int) != 999999999
                    ? Value(data['order_of_entry'] as int)
                    : const Value.absent(),
                didAskedAtCurrentTestRound: Value(
                  (data['whether_asked_at_current_test_round'] as int) == 1,
                ),
                rank: Value(data['rank'] as int),
                askedCount: Value(BigInt.parse(data['asked_count'].toString())),
                wronglyAnsweredCount: Value(
                  BigInt.parse(data['wrongly_answered_count'].toString()),
                ),
              ),
            );
          }
          await batch((batch) => batch.insertAll(entrys, entrysCompanions));
          results = await customSelect(
            '''SELECT field, note FROM field_note''',
          ).get();
          List<FieldListNotesCompanion> fieldListNotesCompanions = [];
          for (int i = 0; i < results.length; i++) {
            final data = results[i].data;
            fieldListNotesCompanions.add(
              FieldListNotesCompanion(
                fieldListId: Value(
                  fieldToFieldListMapping[data['field'] as int]!,
                ),
                texT: Value(data['note'] as String),
                creationAt: Value(now),
                lastModificationAt: Value(now),
              ),
            );
          }
          await batch(
            (batch) =>
                batch.insertAll(fieldListNotes, fieldListNotesCompanions),
          );
          await customStatement('DROP TABLE IF EXISTS field');
          await customStatement('DROP TABLE IF EXISTS string_entry');
          await customStatement('DROP TABLE IF EXISTS string');
          await customStatement('DROP TABLE IF EXISTS field_note');
        }
      });
    },
  );

  Future<void> runMigrationsEarly() async {
    await customSelect('SELECT 1').get();
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
