import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/fully_random_tests_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late FullyRandomTestsDao fullyRandomTestsDao;
  String id = Uuid().v4();
  String fieldListId = Uuid().v4();
  int currentQuestionCounter = 5;
  int triesNumber = 2;
  int triesCounter = 1;
  int elapsedTime = 6000;
  bool isCompleted = true;
  bool lastCheckedAnswerResult = true;
  bool shouldCheckAnAnswer = true;
  int currentHintCounter = 0;

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fullyRandomTestsDao = FullyRandomTestsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a FullyRandomTest", () {
    test("Invalid FullyRandomTest: id is an invalid UUID v4", () {
      var fullyRandomTest = FullyRandomTest(
          id: "owhoweh",
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter);
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No FullyRandomTests with the same id", () async {
      var fullyRandomTest1 = FullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter);
      var fullyRandomTest2 = FullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter);
      await fullyRandomTestsDao.create(fullyRandomTest1.toCompanion(true));
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid FullyRandomTest: fieldListId is an invalid UUID v4", () {
      var fullyRandomTest = FullyRandomTest(
          id: id,
          fieldListId: "ewfewofh",
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter);
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldListId"))));
    });

    test(
        "Invalid FullyRandomTest: currentQuestionCounter is smaller than ${FullyRandomTests.MINIMUM_CURRENT_QUESTION_COUNTER}",
        () {
      var fullyRandomTest = FullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter:
              FullyRandomTests.MINIMUM_CURRENT_QUESTION_COUNTER - 1,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter);
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_question_counter"))));
    });

    test(
        "Invalid FullyRandomTest: currentQuestionCounter is bigger than ${FullyRandomTests.MAXIMUM_CURRENT_QUESTION_COUNTER}",
        () {
      var fullyRandomTest = FullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter:
              FullyRandomTests.MAXIMUM_CURRENT_QUESTION_COUNTER + 1,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter);
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_question_counter"))));
    });

    test(
        "Invalid FullyRandomTest: triesNumber is smaller than ${FullyRandomTests.MINIMUM_TRIES_NUMBER}",
        () {
      var fullyRandomTest = FullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: FullyRandomTests.MINIMUM_TRIES_NUMBER - 1,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter);
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_number"))));
    });

    test(
        "Invalid FullyRandomTest: triesNumber is bigger than ${FullyRandomTests.MAXIMUM_TRIES_NUMBER}",
        () {
      var fullyRandomTest = FullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: FullyRandomTests.MAXIMUM_TRIES_NUMBER + 1,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter);
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_number"))));
    });

    test(
        "Invalid FullyRandomTest: triesCounter is smaller than ${FullyRandomTests.MINIMUM_TRIES_COUNTER}",
        () {
      var fullyRandomTest = FullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: FullyRandomTests.MINIMUM_TRIES_COUNTER - 1,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter);
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_counter"))));
    });

    test(
        "Invalid FullyRandomTest: triesCounter is bigger than ${FullyRandomTests.MAXIMUM_TRIES_COUNTER}",
        () {
      var fullyRandomTest = FullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: FullyRandomTests.MAXIMUM_TRIES_COUNTER + 1,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter);
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_counter"))));
    });

    test(
        "Invalid FullyRandomTest: elapsedTime is smaller than ${FullyRandomTests.MINIMUM_ELAPSED_TIME}",
        () {
      var fullyRandomTest = FullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: FullyRandomTests.MINIMUM_ELAPSED_TIME - 1,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter);
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("elapsed_time"))));
    });

    test(
        "Invalid FullyRandomTest: currentHintCounter is smaller than ${FullyRandomTests.MINIMUM_CURRENT_HINT_COUNTER}",
        () {
      var fullyRandomTest = FullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter:
              FullyRandomTests.MINIMUM_CURRENT_HINT_COUNTER - 1);
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_hint_counter"))));
    });

    test(
        "Invalid FullyRandomTest: currentHintCounter is bigger than ${FullyRandomTests.MAXIMUM_CURRENT_HINT_COUNTER}",
        () {
      var fullyRandomTest = FullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter:
              FullyRandomTests.MAXIMUM_CURRENT_HINT_COUNTER + 1);
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_hint_counter"))));
    });

    test("Good case: create FullyRandomTest without 'id'", () async {
      var fullyRandomTestsCompanion = FullyRandomTestsCompanion(
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          triesCounter: Value(triesCounter),
          elapsedTime: Value(elapsedTime),
          isCompleted: Value(isCompleted),
          lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
          shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
          currentHintCounter: Value(currentHintCounter));
      await fullyRandomTestsDao.create(fullyRandomTestsCompanion);
    });

    test("Good case 2: create FullyRandomTest without triesCounter", () async {
      var fullyRandomTestsCompanion = FullyRandomTestsCompanion(
          id: Value(id),
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          elapsedTime: Value(elapsedTime),
          isCompleted: Value(isCompleted),
          lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
          shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
          currentHintCounter: Value(currentHintCounter));
      await fullyRandomTestsDao.create(fullyRandomTestsCompanion);
    });

    test("Good case 3: create FullyRandomTest without isCompleted", () async {
      var fullyRandomTestsCompanion = FullyRandomTestsCompanion(
          id: Value(id),
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          triesCounter: Value(triesCounter),
          elapsedTime: Value(elapsedTime),
          lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
          shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
          currentHintCounter: Value(currentHintCounter));
      await fullyRandomTestsDao.create(fullyRandomTestsCompanion);
    });

    test("Good case 4: create FullyRandomTest without lastCheckedAnswerResult",
        () async {
      var fullyRandomTestsCompanion = FullyRandomTestsCompanion(
          id: Value(id),
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          triesCounter: Value(triesCounter),
          elapsedTime: Value(elapsedTime),
          isCompleted: Value(isCompleted),
          shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
          currentHintCounter: Value(currentHintCounter));
      await fullyRandomTestsDao.create(fullyRandomTestsCompanion);
    });

    test("Good case 5: create FullyRandomTest without shouldCheckAnAnswer",
        () async {
      var fullyRandomTestsCompanion = FullyRandomTestsCompanion(
          id: Value(id),
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          triesCounter: Value(triesCounter),
          elapsedTime: Value(elapsedTime),
          isCompleted: Value(isCompleted),
          lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
          currentHintCounter: Value(currentHintCounter));
      await fullyRandomTestsDao.create(fullyRandomTestsCompanion);
    });

    test("Good case 6: create FullyRandomTest without currentHintCounter",
        () async {
      var fullyRandomTestsCompanion = FullyRandomTestsCompanion(
          id: Value(id),
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          triesCounter: Value(triesCounter),
          elapsedTime: Value(elapsedTime),
          isCompleted: Value(isCompleted),
          lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
          shouldCheckAnAnswer: Value(shouldCheckAnAnswer));
      await fullyRandomTestsDao.create(fullyRandomTestsCompanion);
    });
  });
}
