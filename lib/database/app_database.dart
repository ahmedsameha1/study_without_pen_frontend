import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
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
  static LazyDatabase openConnection() => LazyDatabase(() async {
    const databaseFileName = 'data';
    final applicationDocumentDirectory =
        await getApplicationDocumentsDirectory();
    var file = File(
      join(
        applicationDocumentDirectory.parent.path,
        'databases',
        databaseFileName,
      ),
    );
    if (!file.existsSync()) {
      file = File(join(applicationDocumentDirectory.path, databaseFileName));
    }
    return NativeDatabase(file);
  });

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

      });
    },
  );
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
