import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/database/sessions_dao.dart';
import 'package:study_without_pen_by_flutter/database/test_sessions_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late TestSessionsDao testSessionsDao;
  late SessionsDao sessionsDao;
  late FieldsDao fieldsDao;
  late FieldListsDao fieldListsDao;
  String fieldId = const Uuid().v4();
  final sessionId = const Uuid().v4();
  String fieldListId = const Uuid().v4();
  String fieldName = "fieldName";
  String fieldListName = "fieldListName";
  int currentQuestionCounter = 5;
  int wrongAnswerCounter = 1;
  int triesNumber = 3;
  int triesCounter = 1;
  int elapsedTime = 6000;
  bool isCompleted = true;
  bool lastCheckedAnswerResult = true;
  bool shouldCheckAnAnswer = true;
  int currentHintCounter = 0;
  DateTime creationAt = DateTime.utc(2020, 1, 1);
  DateTime lastModificationAt = DateTime.utc(2020, 2, 2);
  String lastAnswer = "efh";
  String languageTag = "en-US";
  int checkType = CheckType.NON_STRICT_IGNORE_CASE.index;
  int sortBy = SortBy.CREATION_DATE_DESC.index;
  bool doesReadAnswer = true;
  int usageCount = 20;
  int color = 0x55554433;
  int emulationNumberOfQuestions = 0;
  String emulationDays = "01234";
  int testsReadingQuestionLetterDuration = 200;
  int testsFindingAnswerDuration = 1000;
  int testsTypingAnswerLetterDuration = 100;
  int studyTillCorrectReadingQuestionLetterDuration = 200;
  int studyTillCorrectFindingAnswerDuration = 1000;
  int studyTillCorrectTypingAnswerLetterDuration = 100;
  int testsTimeOfAnswerAction = TimeOfAnswerAction.NEXT.index;
  bool doesObfuscateQuestion = true;
  String userAccountId = "j0kW7TZPcdZBHLsIUvJOFiAI8VN2";
  DateTime creationAt1 = DateTime(2019, 1, 1);
  DateTime lastModificationAt1 = DateTime.utc(2019, 2, 2);
  int usageCount1 = 9;
  int color1 = 0xff347b88;
  var field = Field(
      id: fieldId,
      userAccountId: userAccountId,
      name: fieldName,
      creationAt: creationAt1,
      lastModificationAt: lastModificationAt1,
      usageCount: usageCount1,
      color: color1);
  var fieldList = FieldList(
      id: fieldListId,
      fieldId: fieldId,
      name: fieldListName,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      languageTag: languageTag,
      checkType: checkType,
      sortBy: sortBy,
      doesReadAnswer: doesReadAnswer,
      usageCount: usageCount,
      color: color,
      emulationNumberOfQuestions: emulationNumberOfQuestions,
      emulationDays: emulationDays,
      testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration,
      testsFindingAnswerDuration: testsFindingAnswerDuration,
      testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
      studyTillCorrectReadingQuestionLetterDuration:
          studyTillCorrectReadingQuestionLetterDuration,
      studyTillCorrectFindingAnswerDuration:
          studyTillCorrectFindingAnswerDuration,
      studyTillCorrectTypingAnswerLetterDuration:
          studyTillCorrectTypingAnswerLetterDuration,
      testsTimeOfAnswerAction: testsTimeOfAnswerAction,
      doesObfuscateQuestion: doesObfuscateQuestion);
  setUp(() async {
    appDatabase = AppDatabase(NativeDatabase.memory());
    testSessionsDao = TestSessionsDao(appDatabase);
    sessionsDao = SessionsDao(appDatabase);
    fieldsDao = FieldsDao(appDatabase);
    fieldListsDao = FieldListsDao(appDatabase);
    var session = Session(
        id: sessionId,
        fieldListId: fieldListId,
        currentQuestionCounter: currentQuestionCounter,
        triesNumber: triesNumber,
        triesCounter: triesCounter,
        elapsedTime: elapsedTime,
        isCompleted: isCompleted,
        lastCheckedAnswerResult: lastCheckedAnswerResult,
        shouldCheckAnAnswer: shouldCheckAnAnswer,
        currentHintCounter: currentHintCounter,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt);
    await fieldsDao.create(field.toCompanion(true));
    await fieldListsDao.create(fieldList.toCompanion(true));
    await sessionsDao.create(session.toCompanion(true));
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a TestSession", () {
    test("Invalid TestSession: sessionId is an invalid UUID v4", () {
      final testSession = TestSession(
          sessionId: "wefbhwe",
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer);
      expect(() async {
        await testSessionsDao.create(testSession.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("sessionId"))));
    });

    test("Invalid TestSession: sessionId doesn't exist in sessions table", () {
      final testSession = TestSession(
          sessionId: const Uuid().v4(),
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer);
      expect(() async {
        await testSessionsDao.create(testSession.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test(
        "Invalid TestSession: No more than one TestSession with the same sessionId",
        () async {
      final testSession1 = TestSession(
          sessionId: sessionId,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer);
      final testSession2 = TestSession(
          sessionId: sessionId,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer);
      await testSessionsDao.create(testSession1.toCompanion(true));
      expect(() async {
        await testSessionsDao.create(testSession2.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("session_id"))));
    });

    test(
        "Invalid TestSession: wrongAnswerCounter is smaller than ${TestSessions.MINIMUM_WRONG_ANSWER_COUNTER}",
        () {
      final testSession = TestSession(
          sessionId: sessionId,
          wrongAnswerCounter: TestSessions.MINIMUM_WRONG_ANSWER_COUNTER - 1,
          lastAnswer: lastAnswer);
      expect(() async {
        await testSessionsDao.create(testSession.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrong_answer_counter"))));
    });

    test(
        "Invalid TestSession: wrongAnswerCounter is bigger than ${TestSessions.MAXIMUM_WRONG_ANSWER_COUNTER}",
        () {
      final testSession = TestSession(
          sessionId: sessionId,
          wrongAnswerCounter: TestSessions.MAXIMUM_WRONG_ANSWER_COUNTER + 1,
          lastAnswer: lastAnswer);
      expect(() async {
        await testSessionsDao.create(testSession.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrong_answer_counter"))));
    });

    test("Invalid TestSession: lastAnswer is empty", () async {
      var testSession = TestSession(
          sessionId: sessionId,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: "");
      expect(() async {
        await testSessionsDao.create(testSession.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("last_answer"))));
      testSession = TestSession(
          sessionId: sessionId,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: " ");
      expect(() async {
        await testSessionsDao.create(testSession.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("last_answer"))));
    });

    test("wrongAnswerCounter has default", () async {
      var testSessionCompanion = TestSessionsCompanion(
          sessionId: Value(sessionId), lastAnswer: Value(lastAnswer));
      await testSessionsDao.create(testSessionCompanion);
      var result = await (appDatabase.select(appDatabase.testSessions)
            ..where((tbl) => tbl.sessionId.equals(sessionId)))
          .getSingleOrNull();
      result = result!;
      expect(result.wrongAnswerCounter, 0);
    });

    test("lastAnswer has default", () async {
      var testSessionCompanion = TestSessionsCompanion(
          sessionId: Value(sessionId),
          wrongAnswerCounter: Value(wrongAnswerCounter));
      await testSessionsDao.create(testSessionCompanion);
      var result = await (appDatabase.select(appDatabase.testSessions)
            ..where((tbl) => tbl.sessionId.equals(sessionId)))
          .getSingleOrNull();
      result = result!;
      expect(result.lastAnswer, null);
    });
  });
}
