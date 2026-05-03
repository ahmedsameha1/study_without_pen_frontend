import 'dart:io';

import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

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
      .withDefault(Constant(Entrys.ORDER_MINIMUM_VALUE))
      .check(
        order.isSmallerOrEqualValue(Entrys.ORDER_MAXIMUM_VALUE) &
            order.isBiggerOrEqualValue(Entrys.ORDER_MINIMUM_VALUE),
      )();
  BoolColumn get didAskedAtCurrentTestRound =>
      boolean().withDefault(Constant(true))();
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
  static const databaseFileName = "app_database.sqlite";
  static LazyDatabase openConnection() => LazyDatabase(() async {
    final dbDirectory = await getApplicationDocumentsDirectory();
    final file = File(join(dbDirectory.path, databaseFileName));
    return NativeDatabase(file);
  });

  AppDatabase(QueryExecutor queryExecutor) : super(queryExecutor);

  @override
  int get schemaVersion => 14;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async => m.createAll(),
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
    onUpgrade: (m, from, to) async {
      if (from == 13) {
        await transaction(() async {
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
          await customStatement(
            '''
INSERT INTO field_lists (
  field_id,
  name,
  creation_at,
  last_modification_at,
  language_tag,
  check_type,
  sort_by,
  does_read_answer,
  usage_count,
  color,
  emulation_number_of_questions,
  emulation_days,
  tests_reading_question_letter_duration,
  tests_finding_answer_duration,
  tests_typing_answer_letter_duration,
  study_till_correct_reading_question_letter_duration,
  study_till_correct_finding_answer_duration,
  study_till_correct_typing_answer_letter_duration,
  tests_time_of_answer_action,
  does_obfuscate_question
)
SELECT
  ?, -- field_id
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
         ''',
            [fieldId],
          );
          await customStatement('''
INSERT INTO entrys (
  field_list_id,
  answer,
  question,
  creation_at,
  last_modification_at,
  "order",                           -- Quoted to avoid reserved keyword conflict
  did_asked_at_current_test_round,
  emulated_created_at,
  rank,
  asked_count,
  wrongly_answered_count
)
SELECT
  fl.id,                             -- From field_lists (New UUID)
  s2.value,                          -- From string (Answer text)
  s1.value,                          -- From string (Question text)
  se.creation_date,
  se.creation_date,                  -- Mapping creation to modification
  se.order_of_entry,
  se.whether_asked_at_current_test_round,
  se.creation_emulated_date,
  se.rank,
  se.asked_count,
  se.wrongly_answered_count
FROM string_entry se
INNER JOIN string s1      ON se.question = s1._id
INNER JOIN string s2      ON se.answer = s2._id
INNER JOIN field f        ON se.field = f._id
INNER JOIN field_lists fl ON f.name = fl.name
         ''');
          await customStatement(
            '''
INSERT INTO field_list_notes (
  field_list_id,
  tex_t,
  creation_at,
  last_modification_at
  )
SELECT
  fl.id,
  fn.note,
  ?,
  ?
FROM field f
INNER JOIN field_lists fl ON f.name = fl.name
INNER JOIN field_note fn ON fn.field = f._id
          ''',
            [now.toIso8601String(), now.toIso8601String()],
          );
        });
      }
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
