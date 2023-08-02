import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/database/fully_random_test.dart';
import 'package:study_without_pen_by_flutter/database/fully_random_tests_dao.dart';
import 'package:study_without_pen_by_flutter/database/sessions_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late FullyRandomTestsDao fullyRandomTestsDao;
  late SessionsDao sessionsDao;
  late EntrysDao entrysDao;
  String id = Uuid().v4();
  String fieldListId = Uuid().v4();
  int currentQuestionCounter = 5;
  int questionsNumber = 2;
  int triesNumber = 2;
  int triesCounter = 1;
  int elapsedTime = 6000;
  bool isCompleted = true;
  bool lastCheckedAnswerResult = true;
  bool shouldCheckAnAnswer = true;
  int currentHintCounter = 0;
  int wrongAnswerCounter = 3;
  String lastAnswer = "wefw";
  DateTime creationAt = DateTime.utc(2020, 1, 1);
  DateTime lastModificationAt = DateTime.utc(2020, 2, 2);

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fullyRandomTestsDao = FullyRandomTestsDao(appDatabase);
    sessionsDao = SessionsDao(appDatabase);
    entrysDao = EntrysDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a FullyRandomTest", () {
    test("Invalid FullyRandomTest: invalid Session", () {
      expect(() async {
        await fullyRandomTestsDao.create(
            questionsNumber: questionsNumber,
            id: "wefwe",
            fieldListId: fieldListId,
            currentQuestionCounter: currentQuestionCounter,
            triesNumber: triesNumber,
            triesCounter: triesCounter,
            elapsedTime: elapsedTime,
            isCompleted: isCompleted,
            lastCheckedAnswerResult: lastCheckedAnswerResult,
            shouldCheckAnAnswer: shouldCheckAnAnswer,
            currentHintCounter: currentHintCounter,
            wrongAnswerCounter: wrongAnswerCounter,
            lastAnswer: lastAnswer,
            creationAt: creationAt,
            lastModificationAt: lastModificationAt,
            seed: 1);
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test(
        "Invalid FullyRandomTest: questionsNumber is less than ${FullyRandomTestsDao.MINIMUM_QUESTIONS_NUMBER}",
        () {
      expect(() async {
        await fullyRandomTestsDao.create(
            questionsNumber: FullyRandomTestsDao.MINIMUM_QUESTIONS_NUMBER - 1,
            id: id,
            fieldListId: fieldListId,
            currentQuestionCounter: currentQuestionCounter,
            triesNumber: triesNumber,
            triesCounter: triesCounter,
            elapsedTime: elapsedTime,
            isCompleted: isCompleted,
            lastCheckedAnswerResult: lastCheckedAnswerResult,
            shouldCheckAnAnswer: shouldCheckAnAnswer,
            currentHintCounter: currentHintCounter,
            wrongAnswerCounter: wrongAnswerCounter,
            lastAnswer: lastAnswer,
            creationAt: creationAt,
            lastModificationAt: lastModificationAt,
            seed: 1);
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("questionsNumber"))));
    });

    test(
        "Invalid FullyRandomTest: the number of entries in fieldlist is less than questions number",
        () async {
      expect(() async {
        await fullyRandomTestsDao.create(
            questionsNumber: questionsNumber,
            id: id,
            fieldListId: fieldListId,
            currentQuestionCounter: currentQuestionCounter,
            triesNumber: triesNumber,
            triesCounter: triesCounter,
            elapsedTime: elapsedTime,
            isCompleted: isCompleted,
            lastCheckedAnswerResult: lastCheckedAnswerResult,
            shouldCheckAnAnswer: shouldCheckAnAnswer,
            currentHintCounter: currentHintCounter,
            wrongAnswerCounter: wrongAnswerCounter,
            lastAnswer: lastAnswer,
            creationAt: creationAt,
            lastModificationAt: lastModificationAt,
            seed: 1);
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains(
                  "number of entries in fieldlist is less than questions number"))));
    });

    test(
        "Invalid FullyRandomTest: invalid Session is not created in the database",
        () async {
      try {
        await fullyRandomTestsDao.create(
            questionsNumber: questionsNumber,
            id: "wefwe",
            fieldListId: fieldListId,
            currentQuestionCounter: currentQuestionCounter,
            triesNumber: triesNumber,
            triesCounter: triesCounter,
            elapsedTime: elapsedTime,
            isCompleted: isCompleted,
            lastCheckedAnswerResult: lastCheckedAnswerResult,
            shouldCheckAnAnswer: shouldCheckAnAnswer,
            currentHintCounter: currentHintCounter,
            wrongAnswerCounter: wrongAnswerCounter,
            lastAnswer: lastAnswer,
            creationAt: creationAt,
            lastModificationAt: lastModificationAt,
            seed: 1);
      } on InvalidDataException {}
      var gotten = await sessionsDao.getByFieldListId(fieldListId);
      expect(gotten.length, 0);
    });
  });

  group("Getting FullyRandomTest by id", () {
    String id1 = const Uuid().v4();
    String id2 = const Uuid().v4();
    String id3 = const Uuid().v4();
    String id4 = const Uuid().v4();
    String fieldListId1 = const Uuid().v4();
    String fieldListId2 = const Uuid().v4();
    String answerId1 = const Uuid().v4();
    String answerId2 = const Uuid().v4();
    String answerId3 = const Uuid().v4();
    String answerId4 = const Uuid().v4();
    String questionId1 = const Uuid().v4();
    String questionId2 = const Uuid().v4();
    String questionId3 = const Uuid().v4();
    String questionId4 = const Uuid().v4();
    DateTime creationAt2 = DateTime.utc(2019, 1, 1);
    DateTime creationAt3 = DateTime.utc(2021, 1, 1);
    DateTime creationAt4 = DateTime.utc(2018, 1, 1);
    DateTime lastModificationAt2 = DateTime.utc(2019, 2, 1);
    DateTime lastModificationAt3 = DateTime.utc(2021, 2, 1);
    DateTime lastModificationAt4 = DateTime.utc(2019, 2, 1);
    int rank = Rank.Normal.index;
    int askedCount = 2;
    int wronglyAnsweredCount = 1;
    DateTime emulatedCreatedAt = DateTime.utc(2022, 2, 2);
    setUp(() async {
      var entry = Entry(
          id: id1,
          fieldListId: fieldListId1,
          answerId: answerId1,
          questionId: questionId1,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 3,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
          id: id2,
          fieldListId: fieldListId1,
          answerId: answerId2,
          questionId: questionId2,
          creationAt: creationAt3,
          lastModificationAt: lastModificationAt3,
          order: 2,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
          id: id3,
          fieldListId: fieldListId1,
          answerId: answerId3,
          questionId: questionId3,
          creationAt: creationAt2,
          lastModificationAt: lastModificationAt2,
          order: 1,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
          id: id4,
          fieldListId: fieldListId2,
          answerId: answerId4,
          questionId: questionId4,
          creationAt: creationAt4,
          lastModificationAt: lastModificationAt4,
          order: 2,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
    });

    test("Good case: is found", () async {
      await fullyRandomTestsDao.create(
          questionsNumber: questionsNumber,
          id: id,
          fieldListId: fieldListId1,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          seed: 1);
      FullyRandomTest? fullyRandomTest = await fullyRandomTestsDao.getById(id);
      fullyRandomTest = fullyRandomTest!;
      expect(fullyRandomTest.session.id, id);
      expect(fullyRandomTest.session.fieldListId, fieldListId1);
      expect(fullyRandomTest.session.currentQuestionCounter,
          currentQuestionCounter);
      expect(fullyRandomTest.session.triesNumber, triesNumber);
      expect(fullyRandomTest.session.triesCounter, triesCounter);
      expect(fullyRandomTest.session.elapsedTime, elapsedTime);
      expect(fullyRandomTest.session.isCompleted, isCompleted);
      expect(fullyRandomTest.session.lastCheckedAnswerResult,
          lastCheckedAnswerResult);
      expect(fullyRandomTest.session.shouldCheckAnAnswer, shouldCheckAnAnswer);
      expect(fullyRandomTest.session.currentHintCounter, currentHintCounter);
      expect(fullyRandomTest.session.creationAt, creationAt);
      expect(fullyRandomTest.session.lastModificationAt, lastModificationAt);
      expect(fullyRandomTest.entries, {id1, id2});
    });
  });
}
