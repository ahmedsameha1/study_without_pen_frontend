import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/uncompleted_fully_random_tests_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late UncompletedFullyRandomTestsDao uncompletedFullyRandomTestsDao;
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
  int wrongAnswerCounter = 3;
  String lastAnswer = "wefw";
  DateTime creationAt = DateTime.utc(2020, 1, 1);

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    uncompletedFullyRandomTestsDao =
        UncompletedFullyRandomTestsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a UncompletedFullyRandomTest", () {
    test("Invalid UncompletedFullyRandomTest: id is an invalid UUID v4", () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
          id: "owhoweh",
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
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No UncompletedFullyRandomTests with the same id", () async {
      var uncompletedFullyRandomTest1 = UncompletedFullyRandomTest(
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
          creationAt: creationAt);
      var uncompletedFullyRandomTest2 = UncompletedFullyRandomTest(
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
          creationAt: creationAt);
      await uncompletedFullyRandomTestsDao
          .create(uncompletedFullyRandomTest1.toCompanion(true));
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test(
        "Invalid UncompletedFullyRandomTest: fieldListId is an invalid UUID v4",
        () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
          id: id,
          fieldListId: "ewfewofh",
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
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldListId"))));
    });

    test(
        "Invalid UncompletedFullyRandomTest: currentQuestionCounter is smaller than ${UncompletedFullyRandomTests.MINIMUM_CURRENT_QUESTION_COUNTER}",
        () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter:
              UncompletedFullyRandomTests.MINIMUM_CURRENT_QUESTION_COUNTER - 1,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer,
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_question_counter"))));
    });

    test(
        "Invalid UncompletedFullyRandomTest: currentQuestionCounter is bigger than ${UncompletedFullyRandomTests.MAXIMUM_CURRENT_QUESTION_COUNTER}",
        () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter:
              UncompletedFullyRandomTests.MAXIMUM_CURRENT_QUESTION_COUNTER + 1,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer,
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_question_counter"))));
    });

    test(
        "Invalid UncompletedFullyRandomTest: triesNumber is smaller than ${UncompletedFullyRandomTests.MINIMUM_TRIES_NUMBER}",
        () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: UncompletedFullyRandomTests.MINIMUM_TRIES_NUMBER - 1,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer,
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_number"))));
    });

    test(
        "Invalid UncompletedFullyRandomTest: triesNumber is bigger than ${UncompletedFullyRandomTests.MAXIMUM_TRIES_NUMBER}",
        () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: UncompletedFullyRandomTests.MAXIMUM_TRIES_NUMBER + 1,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer,
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_number"))));
    });

    test(
        "Invalid UncompletedFullyRandomTest: triesCounter is smaller than ${UncompletedFullyRandomTests.MINIMUM_TRIES_COUNTER}",
        () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: UncompletedFullyRandomTests.MINIMUM_TRIES_COUNTER - 1,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer,
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_counter"))));
    });

    test(
        "Invalid UncompletedFullyRandomTest: triesCounter is bigger than ${UncompletedFullyRandomTests.MAXIMUM_TRIES_COUNTER}",
        () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: UncompletedFullyRandomTests.MAXIMUM_TRIES_COUNTER + 1,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer,
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_counter"))));
    });

    test(
        "Invalid UncompletedFullyRandomTest: elapsedTime is smaller than ${UncompletedFullyRandomTests.MINIMUM_ELAPSED_TIME}",
        () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: UncompletedFullyRandomTests.MINIMUM_ELAPSED_TIME - 1,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer,
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("elapsed_time"))));
    });

    test(
        "Invalid UncompletedFullyRandomTest: currentHintCounter is smaller than ${UncompletedFullyRandomTests.MINIMUM_CURRENT_HINT_COUNTER}",
        () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
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
              UncompletedFullyRandomTests.MINIMUM_CURRENT_HINT_COUNTER - 1,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer,
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_hint_counter"))));
    });

    test(
        "Invalid UncompletedFullyRandomTest: currentHintCounter is bigger than ${UncompletedFullyRandomTests.MAXIMUM_CURRENT_HINT_COUNTER}",
        () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
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
              UncompletedFullyRandomTests.MAXIMUM_CURRENT_HINT_COUNTER + 1,
          wrongAnswerCounter: wrongAnswerCounter,
          lastAnswer: lastAnswer,
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_hint_counter"))));
    });

    test(
        "Invalid UncompletedFullyRandomTest: wrongAnswerCounter is smaller than ${UncompletedFullyRandomTests.MINIMUM_WRONG_ANSWER_COUNTER}",
        () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
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
          wrongAnswerCounter:
              UncompletedFullyRandomTests.MINIMUM_WRONG_ANSWER_COUNTER - 1,
          lastAnswer: lastAnswer,
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrong_answer_counter"))));
    });

    test(
        "Invalid UncompletedFullyRandomTest: wrongAnswerCounter is bigger than ${UncompletedFullyRandomTests.MAXIMUM_WRONG_ANSWER_COUNTER}",
        () {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
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
          wrongAnswerCounter:
              UncompletedFullyRandomTests.MAXIMUM_WRONG_ANSWER_COUNTER + 1,
          lastAnswer: lastAnswer,
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrong_answer_counter"))));
    });

    test("Invalid UncompletedFullyRandomTest: lastAnswer is empty", () async {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
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
          lastAnswer: "",
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("last_answer"))));
      uncompletedFullyRandomTest = UncompletedFullyRandomTest(
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
          lastAnswer: " ",
          creationAt: creationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .create(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("last_answer"))));
    });

    test("Invalid UncompletedFullyRandomTest: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2020, 1, 1)), () {
        var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
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
            creationAt: DateTime.utc(2023, 1, 1));
        expect(() async {
          await uncompletedFullyRandomTestsDao
              .create(uncompletedFullyRandomTest.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("Good case: create UncompletedFullyRandomTest without 'id'", () async {
      var uncompletedFullyRandomTestsCompanion =
          UncompletedFullyRandomTestsCompanion(
              fieldListId: Value(fieldListId),
              currentQuestionCounter: Value(currentQuestionCounter),
              triesNumber: Value(triesNumber),
              triesCounter: Value(triesCounter),
              elapsedTime: Value(elapsedTime),
              isCompleted: Value(isCompleted),
              lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
              shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
              currentHintCounter: Value(currentHintCounter),
              wrongAnswerCounter: Value(wrongAnswerCounter),
              lastAnswer: Value(lastAnswer),
              creationAt: Value(creationAt));
      await uncompletedFullyRandomTestsDao
          .create((uncompletedFullyRandomTestsCompanion));
    });

    test("Good case 2: create UncompletedFullyRandomTest without triesCounter",
        () async {
      var uncompletedFullyRandomTestsCompanion =
          UncompletedFullyRandomTestsCompanion(
              id: Value(id),
              fieldListId: Value(fieldListId),
              currentQuestionCounter: Value(currentQuestionCounter),
              triesNumber: Value(triesNumber),
              elapsedTime: Value(elapsedTime),
              isCompleted: Value(isCompleted),
              lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
              shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
              currentHintCounter: Value(currentHintCounter),
              wrongAnswerCounter: Value(wrongAnswerCounter),
              lastAnswer: Value(lastAnswer),
              creationAt: Value(creationAt));
      await uncompletedFullyRandomTestsDao
          .create((uncompletedFullyRandomTestsCompanion));
    });

    test("Good case 3: create UncompletedFullyRandomTest without isCompleted",
        () async {
      var uncompletedFullyRandomTestsCompanion =
          UncompletedFullyRandomTestsCompanion(
              id: Value(id),
              fieldListId: Value(fieldListId),
              currentQuestionCounter: Value(currentQuestionCounter),
              triesNumber: Value(triesNumber),
              triesCounter: Value(triesCounter),
              elapsedTime: Value(elapsedTime),
              lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
              shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
              currentHintCounter: Value(currentHintCounter),
              wrongAnswerCounter: Value(wrongAnswerCounter),
              lastAnswer: Value(lastAnswer),
              creationAt: Value(creationAt));
      await uncompletedFullyRandomTestsDao
          .create((uncompletedFullyRandomTestsCompanion));
    });

    test(
        "Good case 4: create UncompletedFullyRandomTest without lastCheckedAnswerResult",
        () async {
      var uncompletedFullyRandomTestsCompanion =
          UncompletedFullyRandomTestsCompanion(
              id: Value(id),
              fieldListId: Value(fieldListId),
              currentQuestionCounter: Value(currentQuestionCounter),
              triesNumber: Value(triesNumber),
              triesCounter: Value(triesCounter),
              elapsedTime: Value(elapsedTime),
              isCompleted: Value(isCompleted),
              shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
              currentHintCounter: Value(currentHintCounter),
              wrongAnswerCounter: Value(wrongAnswerCounter),
              lastAnswer: Value(lastAnswer),
              creationAt: Value(creationAt));
      await uncompletedFullyRandomTestsDao
          .create((uncompletedFullyRandomTestsCompanion));
    });

    test(
        "Good case 5: create UncompletedFullyRandomTest without shouldCheckAnAnswer",
        () async {
      var uncompletedFullyRandomTestsCompanion =
          UncompletedFullyRandomTestsCompanion(
              id: Value(id),
              fieldListId: Value(fieldListId),
              currentQuestionCounter: Value(currentQuestionCounter),
              triesNumber: Value(triesNumber),
              triesCounter: Value(triesCounter),
              elapsedTime: Value(elapsedTime),
              isCompleted: Value(isCompleted),
              lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
              currentHintCounter: Value(currentHintCounter),
              wrongAnswerCounter: Value(wrongAnswerCounter),
              lastAnswer: Value(lastAnswer),
              creationAt: Value(creationAt));
      await uncompletedFullyRandomTestsDao
          .create((uncompletedFullyRandomTestsCompanion));
    });

    test(
        "Good case 6: create UncompletedFullyRandomTest without currentHintCounter",
        () async {
      var uncompletedFullyRandomTestsCompanion =
          UncompletedFullyRandomTestsCompanion(
              id: Value(id),
              fieldListId: Value(fieldListId),
              currentQuestionCounter: Value(currentQuestionCounter),
              triesNumber: Value(triesNumber),
              triesCounter: Value(triesCounter),
              elapsedTime: Value(elapsedTime),
              isCompleted: Value(isCompleted),
              lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
              shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
              wrongAnswerCounter: Value(wrongAnswerCounter),
              lastAnswer: Value(lastAnswer),
              creationAt: Value(creationAt));
      await uncompletedFullyRandomTestsDao
          .create((uncompletedFullyRandomTestsCompanion));
    });

    test(
        "Good case 6: create UncompletedFullyRandomTest without wrongAnswerCounter",
        () async {
      var uncompletedFullyRandomTestsCompanion =
          UncompletedFullyRandomTestsCompanion(
              id: Value(id),
              fieldListId: Value(fieldListId),
              currentQuestionCounter: Value(currentQuestionCounter),
              triesNumber: Value(triesNumber),
              triesCounter: Value(triesCounter),
              elapsedTime: Value(elapsedTime),
              isCompleted: Value(isCompleted),
              lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
              shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
              currentHintCounter: Value(currentHintCounter),
              lastAnswer: Value(lastAnswer),
              creationAt: Value(creationAt));
      await uncompletedFullyRandomTestsDao
          .create((uncompletedFullyRandomTestsCompanion));
    });

    test("Good case 7: create UncompletedFullyRandomTest without lastAnswer",
        () async {
      var uncompletedFullyRandomTestsCompanion =
          UncompletedFullyRandomTestsCompanion(
              id: Value(id),
              fieldListId: Value(fieldListId),
              currentQuestionCounter: Value(currentQuestionCounter),
              triesNumber: Value(triesNumber),
              triesCounter: Value(triesCounter),
              elapsedTime: Value(elapsedTime),
              isCompleted: Value(isCompleted),
              lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
              shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
              currentHintCounter: Value(currentHintCounter),
              wrongAnswerCounter: Value(wrongAnswerCounter),
              creationAt: Value(creationAt));
      await uncompletedFullyRandomTestsDao
          .create((uncompletedFullyRandomTestsCompanion));
    });
  });

  group("Getting UncompletedFullyRandomTest by id", () {
    var id2 = const Uuid().v4();
    setUp(() async {
      var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
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
          creationAt: creationAt);
      await uncompletedFullyRandomTestsDao
          .create(uncompletedFullyRandomTest.toCompanion(true));
    });

    test("Good case: UncompletedFullyRandomTest is found", () async {
      UncompletedFullyRandomTest? gottenUncompletedFullyRandomTest =
          await uncompletedFullyRandomTestsDao.getById(id);
      gottenUncompletedFullyRandomTest = gottenUncompletedFullyRandomTest!;
      expect(id, gottenUncompletedFullyRandomTest.id);
      expect(fieldListId, gottenUncompletedFullyRandomTest.fieldListId);
      expect(currentQuestionCounter,
          gottenUncompletedFullyRandomTest.currentQuestionCounter);
      expect(triesNumber, gottenUncompletedFullyRandomTest.triesNumber);
      expect(triesCounter, gottenUncompletedFullyRandomTest.triesCounter);
      expect(elapsedTime, gottenUncompletedFullyRandomTest.elapsedTime);
      expect(isCompleted, gottenUncompletedFullyRandomTest.isCompleted);
      expect(lastCheckedAnswerResult,
          gottenUncompletedFullyRandomTest.lastCheckedAnswerResult);
      expect(shouldCheckAnAnswer,
          gottenUncompletedFullyRandomTest.shouldCheckAnAnswer);
      expect(currentHintCounter,
          gottenUncompletedFullyRandomTest.currentHintCounter);
      expect(wrongAnswerCounter,
          gottenUncompletedFullyRandomTest.wrongAnswerCounter);
      expect(lastAnswer, gottenUncompletedFullyRandomTest.lastAnswer);
      expect(creationAt, gottenUncompletedFullyRandomTest.creationAt);
    });

    test("Good case: UncompletedFullyRandomTest is not found", () async {
      UncompletedFullyRandomTest? gottenUncompletedFullyRandomTest =
          await uncompletedFullyRandomTestsDao.getById(const Uuid().v4());
      expect(gottenUncompletedFullyRandomTest, null);
    });

    test("Test default values", () async {
      var uncompletedFullyRandomTestsCompanion =
          UncompletedFullyRandomTestsCompanion(
              id: Value(id2),
              fieldListId: Value(fieldListId),
              currentQuestionCounter: Value(currentQuestionCounter),
              triesNumber: Value(triesNumber),
              elapsedTime: Value(elapsedTime),
              creationAt: Value(creationAt));
      await uncompletedFullyRandomTestsDao
          .create(uncompletedFullyRandomTestsCompanion);
      UncompletedFullyRandomTest? gottenUncompletedFullyRandomTest =
          await uncompletedFullyRandomTestsDao.getById(id2);
      gottenUncompletedFullyRandomTest = gottenUncompletedFullyRandomTest!;
      expect(gottenUncompletedFullyRandomTest.triesCounter, 0);
      expect(gottenUncompletedFullyRandomTest.isCompleted, false);
      expect(gottenUncompletedFullyRandomTest.lastCheckedAnswerResult, false);
      expect(gottenUncompletedFullyRandomTest.shouldCheckAnAnswer, true);
      expect(gottenUncompletedFullyRandomTest.currentHintCounter, 0);
      expect(gottenUncompletedFullyRandomTest.wrongAnswerCounter, 0);
      expect(gottenUncompletedFullyRandomTest.lastAnswer, null);
    });
  });
}
