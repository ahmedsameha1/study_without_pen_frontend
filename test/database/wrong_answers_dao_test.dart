import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/database/sessions_dao.dart';
import 'package:study_without_pen_by_flutter/database/wrong_answers_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late WrongAnswersDao wrongAnswersDao;
  late SessionsDao sessionsDao;
  late EntrysDao entrysDao;
  String id = const Uuid().v4();
  String entryId = const Uuid().v4();
  String sessionId = const Uuid().v4();
  String value = "wrong answer";
  String fieldListId = Uuid().v4();
  int currentQuestionCounter = 5;
  int triesNumber = 3;
  int triesCounter = 1;
  int elapsedTime = 6000;
  bool isCompleted = true;
  bool lastCheckedAnswerResult = true;
  bool shouldCheckAnAnswer = true;
  int currentHintCounter = 0;
  DateTime creationAt = DateTime.utc(2020, 1, 1);
  DateTime lastModificationAt = DateTime.utc(2020, 2, 2);
  String answerId = const Uuid().v4();
  String questionId = const Uuid().v4();
  DateTime emulatedCreatedAt = DateTime.utc(2022, 2, 2);
  int order = 1;
  int rank = Rank.Normal.index;
  int askedCount = 2;
  int wronglyAnsweredCount = 1;
  bool didAskedAtCurrentTestRound = true;

  setUp(() async {
    appDatabase = AppDatabase(NativeDatabase.memory());
    wrongAnswersDao = WrongAnswersDao(appDatabase);
    sessionsDao = SessionsDao(appDatabase);
    entrysDao = EntrysDao(appDatabase);
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
    await sessionsDao.create(session.toCompanion(true));
    var entry = Entry(
        id: entryId,
        fieldListId: fieldListId,
        answerId: answerId,
        questionId: questionId,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: rank,
        askedCount: askedCount,
        wronglyAnsweredCount: wronglyAnsweredCount);
    await entrysDao.create(entry.toCompanion(true));
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create wrongAnswer", () {
    test("Invalid wrongAnswer: id is invalid UUID v4", () {
      final wrongAnswer = WrongAnswer(
          id: "efweh", sessionId: sessionId, entryId: entryId, value: value);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No two or more wrongAnswers with the same id", () async {
      final wrongAnswer = WrongAnswer(
          id: id, sessionId: sessionId, entryId: entryId, value: value);
      await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("wrong_answers.id"))));
    });

    test("Invalid wrongAnswer: sessionId is invalid UUID v4", () {
      final wrongAnswer = WrongAnswer(
          id: id, sessionId: "owfbhwe", entryId: entryId, value: value);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("sessionId"))));
    });

    test("Invalid wrongAnswer: sessionId doesn't exist in sessions table", () {
      final wrongAnswer = WrongAnswer(
          id: id, sessionId: const Uuid().v4(), entryId: entryId, value: value);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test("Invalid wrongAnswer: entryId is invalid UUID v4", () {
      final wrongAnswer = WrongAnswer(
          id: id, sessionId: sessionId, entryId: "efbw", value: value);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("entryId"))));
    });

    test("Invalid wrongAnswer: entryId doesn't exist in sessions table", () {
      final wrongAnswer = WrongAnswer(
          id: id,
          sessionId: sessionId,
          entryId: const Uuid().v4(),
          value: value);
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test("Invalid wrongAnswer: value is an empty String", () {
      var wrongAnswer = WrongAnswer(
          id: id, sessionId: sessionId, entryId: entryId, value: "");
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("value"))));
      wrongAnswer = WrongAnswer(
          id: id, sessionId: sessionId, entryId: entryId, value: " ");
      expect(() async {
        await wrongAnswersDao.create(wrongAnswer.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("value"))));
    });

    test("Good case: not provide id", () async {
      var wrongAnswerCompanion = WrongAnswersCompanion(
          sessionId: Value(sessionId),
          entryId: Value(entryId),
          value: Value("wefhweo"));
      await wrongAnswersDao.create(wrongAnswerCompanion);
    });
  });
}
