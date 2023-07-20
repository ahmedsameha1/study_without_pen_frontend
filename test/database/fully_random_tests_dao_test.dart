import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/fully_random_tests_dao.dart';
import 'package:study_without_pen_by_flutter/database/uncompleted_fully_random_tests_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late FullyRandomTestsDao fullyRandomTestsDao;
  late UncompletedFullyRandomTestsDao uncompletedFullyRandomTestsDao;

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fullyRandomTestsDao = FullyRandomTestsDao(appDatabase);
    uncompletedFullyRandomTestsDao =
        UncompletedFullyRandomTestsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a FullyRandomTest", () {
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
            lastModificationAt: lastModificationAt);
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("questionsNumber"))));
    });

    test("Invalid FullyRandomTest: invalid UncompletedFullyRandomTest", () {
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
            lastModificationAt: lastModificationAt);
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("Invalid FullyRandomTest: there is no entries in the fieldlist",
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
            lastModificationAt: lastModificationAt);
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("FieldList has no entries"))));
    });

    test(
        "Invalid FullyRandomTest: invalid UncompletedFullyRandomTest is not created in the database",
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
            lastModificationAt: lastModificationAt);
      } on InvalidDataException {}
      var gotten =
          await uncompletedFullyRandomTestsDao.getByFieldListId(fieldListId);
      expect(gotten.length, 0);
    });
  });
}
