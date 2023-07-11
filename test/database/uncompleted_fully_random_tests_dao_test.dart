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
  DateTime lastModificationAt = DateTime.utc(2020, 2, 2);

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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
            creationAt: DateTime.utc(2023, 1, 1),
            lastModificationAt: lastModificationAt);
        expect(() async {
          await uncompletedFullyRandomTestsDao
              .create(uncompletedFullyRandomTest.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test(
        "Invalid UncompletedFullyRandomTest: lastModificationAt is in the future",
        () {
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
            creationAt: creationAt,
            lastModificationAt: DateTime.utc(2023, 1, 1));
        expect(() async {
          await uncompletedFullyRandomTestsDao
              .create(uncompletedFullyRandomTest.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
      });
    });

    test(
        "Invalid UncompletedFullyRandomTest: lastModificationAt is before creationAt",
        () {
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
            creationAt: creationAt,
            lastModificationAt: DateTime.utc(2013, 1, 1));
        expect(() async {
          await uncompletedFullyRandomTestsDao
              .create(uncompletedFullyRandomTest.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
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
              creationAt: Value(creationAt),
              lastModificationAt: Value(lastModificationAt));
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
              creationAt: Value(creationAt),
              lastModificationAt: Value(lastModificationAt));
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
              creationAt: Value(creationAt),
              lastModificationAt: Value(lastModificationAt));
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
              creationAt: Value(creationAt),
              lastModificationAt: Value(lastModificationAt));
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
              creationAt: Value(creationAt),
              lastModificationAt: Value(lastModificationAt));
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
              creationAt: Value(creationAt),
              lastModificationAt: Value(lastModificationAt));
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
              creationAt: Value(creationAt),
              lastModificationAt: Value(lastModificationAt));
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
              creationAt: Value(creationAt),
              lastModificationAt: Value(lastModificationAt));
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
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
      expect(lastModificationAt,
          gottenUncompletedFullyRandomTest.lastModificationAt);
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
              creationAt: Value(creationAt),
              lastModificationAt: Value(lastModificationAt));
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

  test("Get all UncompletedFullyRandomTest by fieldListId", () async {
    final id1 = const Uuid().v4();
    final id2 = const Uuid().v4();
    final id3 = const Uuid().v4();
    final id4 = const Uuid().v4();
    final id5 = const Uuid().v4();
    final id6 = const Uuid().v4();
    final fieldListId1 = const Uuid().v4();
    final fieldListId2 = const Uuid().v4();
    final fieldListId3 = const Uuid().v4();
    final currentQuestionCounter1 = 1;
    final currentQuestionCounter2 = 2;
    final currentQuestionCounter3 = 3;
    final currentQuestionCounter4 = 4;
    final currentQuestionCounter5 = 5;
    final currentQuestionCounter6 = 6;
    final triesNumber1 = 1;
    final triesNumber2 = 2;
    final triesNumber3 = 3;
    final triesNumber4 = 1;
    final triesNumber5 = 2;
    final triesNumber6 = 3;
    final triesCounter1 = 0;
    final triesCounter2 = 1;
    final triesCounter3 = 2;
    final triesCounter4 = 0;
    final triesCounter5 = 1;
    final triesCounter6 = 2;
    final elapsedTime1 = 1000;
    final elapsedTime2 = 2000;
    final elapsedTime3 = 3000;
    final elapsedTime4 = 4000;
    final elapsedTime5 = 5000;
    final elapsedTime6 = 6000;
    final lastCheckedAnswerResult1 = true;
    final lastCheckedAnswerResult2 = false;
    final lastCheckedAnswerResult3 = true;
    final lastCheckedAnswerResult4 = false;
    final lastCheckedAnswerResult5 = true;
    final lastCheckedAnswerResult6 = false;
    final shouldCheckAnAnswer1 = false;
    final shouldCheckAnAnswer2 = true;
    final shouldCheckAnAnswer3 = false;
    final shouldCheckAnAnswer4 = true;
    final shouldCheckAnAnswer5 = false;
    final shouldCheckAnAnswer6 = true;
    final isCompleted1 = true;
    final isCompleted2 = false;
    final isCompleted3 = true;
    final isCompleted4 = false;
    final isCompleted5 = true;
    final isCompleted6 = false;
    final currentHintCounter1 = 0;
    final currentHintCounter2 = 1;
    final currentHintCounter3 = 0;
    final currentHintCounter4 = 1;
    final currentHintCounter5 = 0;
    final currentHintCounter6 = 1;
    final wrongAnswerCounter1 = 0;
    final wrongAnswerCounter2 = 1;
    final wrongAnswerCounter3 = 2;
    final wrongAnswerCounter4 = 0;
    final wrongAnswerCounter5 = 1;
    final wrongAnswerCounter6 = 2;
    final lastAnswer1 = "ohwofew";
    final lastAnswer2 = "ohwof";
    final lastAnswer3 = "hwofew";
    final lastAnswer4 = "xhwofew";
    final lastAnswer5 = "okkwofew";
    final lastAnswer6 = "ohofew";
    final creationAt1 = DateTime.utc(2020, 1, 1);
    final creationAt2 = DateTime.utc(2020, 2, 2);
    final creationAt3 = DateTime.utc(2020, 3, 3);
    final creationAt4 = DateTime.utc(2020, 4, 4);
    final creationAt5 = DateTime.utc(2020, 5, 5);
    final creationAt6 = DateTime.utc(2020, 6, 6);
    final lastModificationAt1 = DateTime.utc(2021, 1, 1);
    final lastModificationAt2 = DateTime.utc(2021, 2, 2);
    final lastModificationAt3 = DateTime.utc(2021, 3, 3);
    final lastModificationAt4 = DateTime.utc(2021, 4, 4);
    final lastModificationAt5 = DateTime.utc(2021, 5, 5);
    final lastModificationAt6 = DateTime.utc(2021, 6, 6);
    var uncompletedFullyRandomTest1 = UncompletedFullyRandomTest(
        id: id1,
        fieldListId: fieldListId1,
        currentQuestionCounter: currentQuestionCounter1,
        triesNumber: triesNumber1,
        triesCounter: triesCounter1,
        elapsedTime: elapsedTime1,
        isCompleted: isCompleted1,
        lastCheckedAnswerResult: lastCheckedAnswerResult1,
        shouldCheckAnAnswer: shouldCheckAnAnswer1,
        currentHintCounter: currentHintCounter1,
        wrongAnswerCounter: wrongAnswerCounter1,
        lastAnswer: lastAnswer1,
        creationAt: creationAt1,
        lastModificationAt: lastModificationAt1);
    var uncompletedFullyRandomTest2 = UncompletedFullyRandomTest(
        id: id2,
        fieldListId: fieldListId2,
        currentQuestionCounter: currentQuestionCounter2,
        triesNumber: triesNumber2,
        triesCounter: triesCounter2,
        elapsedTime: elapsedTime2,
        isCompleted: isCompleted2,
        lastCheckedAnswerResult: lastCheckedAnswerResult2,
        shouldCheckAnAnswer: shouldCheckAnAnswer2,
        currentHintCounter: currentHintCounter2,
        wrongAnswerCounter: wrongAnswerCounter2,
        lastAnswer: lastAnswer2,
        creationAt: creationAt2,
        lastModificationAt: lastModificationAt2);
    var uncompletedFullyRandomTest3 = UncompletedFullyRandomTest(
        id: id3,
        fieldListId: fieldListId3,
        currentQuestionCounter: currentQuestionCounter3,
        triesNumber: triesNumber3,
        triesCounter: triesCounter3,
        elapsedTime: elapsedTime3,
        isCompleted: isCompleted3,
        lastCheckedAnswerResult: lastCheckedAnswerResult3,
        shouldCheckAnAnswer: shouldCheckAnAnswer3,
        currentHintCounter: currentHintCounter3,
        wrongAnswerCounter: wrongAnswerCounter3,
        lastAnswer: lastAnswer3,
        creationAt: creationAt3,
        lastModificationAt: lastModificationAt3);
    var uncompletedFullyRandomTest4 = UncompletedFullyRandomTest(
        id: id4,
        fieldListId: fieldListId1,
        currentQuestionCounter: currentQuestionCounter4,
        triesNumber: triesNumber4,
        triesCounter: triesCounter4,
        elapsedTime: elapsedTime4,
        isCompleted: isCompleted4,
        lastCheckedAnswerResult: lastCheckedAnswerResult4,
        shouldCheckAnAnswer: shouldCheckAnAnswer4,
        currentHintCounter: currentHintCounter4,
        wrongAnswerCounter: wrongAnswerCounter4,
        lastAnswer: lastAnswer4,
        creationAt: creationAt4,
        lastModificationAt: lastModificationAt4);
    var uncompletedFullyRandomTest5 = UncompletedFullyRandomTest(
        id: id5,
        fieldListId: fieldListId2,
        currentQuestionCounter: currentQuestionCounter5,
        triesNumber: triesNumber5,
        triesCounter: triesCounter5,
        elapsedTime: elapsedTime5,
        isCompleted: isCompleted5,
        lastCheckedAnswerResult: lastCheckedAnswerResult5,
        shouldCheckAnAnswer: shouldCheckAnAnswer5,
        currentHintCounter: currentHintCounter5,
        wrongAnswerCounter: wrongAnswerCounter5,
        lastAnswer: lastAnswer5,
        creationAt: creationAt5,
        lastModificationAt: lastModificationAt5);
    var uncompletedFullyRandomTest6 = UncompletedFullyRandomTest(
        id: id6,
        fieldListId: fieldListId1,
        currentQuestionCounter: currentQuestionCounter6,
        triesNumber: triesNumber6,
        triesCounter: triesCounter6,
        elapsedTime: elapsedTime6,
        isCompleted: isCompleted6,
        lastCheckedAnswerResult: lastCheckedAnswerResult6,
        shouldCheckAnAnswer: shouldCheckAnAnswer6,
        currentHintCounter: currentHintCounter6,
        wrongAnswerCounter: wrongAnswerCounter6,
        lastAnswer: lastAnswer6,
        creationAt: creationAt6,
        lastModificationAt: lastModificationAt6);
    await uncompletedFullyRandomTestsDao
        .create(uncompletedFullyRandomTest1.toCompanion(true));
    await uncompletedFullyRandomTestsDao
        .create(uncompletedFullyRandomTest2.toCompanion(true));
    await uncompletedFullyRandomTestsDao
        .create(uncompletedFullyRandomTest3.toCompanion(true));
    await uncompletedFullyRandomTestsDao
        .create(uncompletedFullyRandomTest4.toCompanion(true));
    await uncompletedFullyRandomTestsDao
        .create(uncompletedFullyRandomTest5.toCompanion(true));
    await uncompletedFullyRandomTestsDao
        .create(uncompletedFullyRandomTest6.toCompanion(true));
    var uncompletedFullyRandomTests =
        await uncompletedFullyRandomTestsDao.getByFieldListId(fieldListId1);
    expect(uncompletedFullyRandomTests.length, 3);
    var uncompletedFullyRandomTest = uncompletedFullyRandomTests[0];
    expect(uncompletedFullyRandomTest.id, id6);
    expect(uncompletedFullyRandomTest.fieldListId, fieldListId1);
    expect(uncompletedFullyRandomTest.currentQuestionCounter,
        currentQuestionCounter6);
    expect(uncompletedFullyRandomTest.triesNumber, triesNumber6);
    expect(uncompletedFullyRandomTest.triesCounter, triesCounter6);
    expect(uncompletedFullyRandomTest.elapsedTime, elapsedTime6);
    expect(uncompletedFullyRandomTest.isCompleted, isCompleted6);
    expect(uncompletedFullyRandomTest.lastCheckedAnswerResult,
        lastCheckedAnswerResult6);
    expect(
        uncompletedFullyRandomTest.shouldCheckAnAnswer, shouldCheckAnAnswer6);
    expect(uncompletedFullyRandomTest.currentHintCounter, currentHintCounter6);
    expect(uncompletedFullyRandomTest.wrongAnswerCounter, wrongAnswerCounter6);
    expect(uncompletedFullyRandomTest.lastAnswer, lastAnswer6);
    expect(uncompletedFullyRandomTest.creationAt, creationAt6);
    expect(uncompletedFullyRandomTest.lastModificationAt, lastModificationAt6);
    uncompletedFullyRandomTest = uncompletedFullyRandomTests[1];
    expect(uncompletedFullyRandomTest.id, id4);
    expect(uncompletedFullyRandomTest.fieldListId, fieldListId1);
    expect(uncompletedFullyRandomTest.currentHintCounter, currentHintCounter4);
    expect(uncompletedFullyRandomTest.triesNumber, triesNumber4);
    expect(uncompletedFullyRandomTest.triesCounter, triesCounter4);
    expect(uncompletedFullyRandomTest.elapsedTime, elapsedTime4);
    expect(uncompletedFullyRandomTest.isCompleted, isCompleted4);
    expect(uncompletedFullyRandomTest.lastCheckedAnswerResult,
        lastCheckedAnswerResult4);
    expect(
        uncompletedFullyRandomTest.shouldCheckAnAnswer, shouldCheckAnAnswer4);
    expect(uncompletedFullyRandomTest.currentHintCounter, currentHintCounter4);
    expect(uncompletedFullyRandomTest.wrongAnswerCounter, wrongAnswerCounter4);
    expect(uncompletedFullyRandomTest.lastAnswer, lastAnswer4);
    expect(uncompletedFullyRandomTest.creationAt, creationAt4);
    expect(uncompletedFullyRandomTest.lastModificationAt, lastModificationAt4);
    uncompletedFullyRandomTest = uncompletedFullyRandomTests[2];
    expect(uncompletedFullyRandomTest.id, id1);
    expect(uncompletedFullyRandomTest.fieldListId, fieldListId1);
    expect(uncompletedFullyRandomTest.currentQuestionCounter,
        currentQuestionCounter1);
    expect(uncompletedFullyRandomTest.triesNumber, triesNumber1);
    expect(uncompletedFullyRandomTest.triesCounter, triesCounter1);
    expect(uncompletedFullyRandomTest.elapsedTime, elapsedTime1);
    expect(uncompletedFullyRandomTest.isCompleted, isCompleted1);
    expect(uncompletedFullyRandomTest.lastCheckedAnswerResult,
        lastCheckedAnswerResult1);
    expect(
        uncompletedFullyRandomTest.shouldCheckAnAnswer, shouldCheckAnAnswer1);
    expect(uncompletedFullyRandomTest.currentHintCounter, currentHintCounter1);
    expect(uncompletedFullyRandomTest.wrongAnswerCounter, wrongAnswerCounter1);
    expect(uncompletedFullyRandomTest.lastAnswer, lastAnswer1);
    expect(uncompletedFullyRandomTest.creationAt, creationAt1);
    expect(uncompletedFullyRandomTest.lastModificationAt, lastModificationAt1);
    uncompletedFullyRandomTests =
        await uncompletedFullyRandomTestsDao.getByFieldListId(fieldListId2);
    expect(uncompletedFullyRandomTests.length, 2);
    uncompletedFullyRandomTest = uncompletedFullyRandomTests[0];
    expect(uncompletedFullyRandomTest.id, id2);
    expect(uncompletedFullyRandomTest.fieldListId, fieldListId2);
    expect(uncompletedFullyRandomTest.currentQuestionCounter,
        currentQuestionCounter2);
    expect(uncompletedFullyRandomTest.triesNumber, triesNumber2);
    expect(uncompletedFullyRandomTest.triesCounter, triesCounter2);
    expect(uncompletedFullyRandomTest.elapsedTime, elapsedTime2);
    expect(uncompletedFullyRandomTest.isCompleted, isCompleted2);
    expect(uncompletedFullyRandomTest.lastCheckedAnswerResult,
        lastCheckedAnswerResult2);
    expect(
        uncompletedFullyRandomTest.shouldCheckAnAnswer, shouldCheckAnAnswer2);
    expect(uncompletedFullyRandomTest.currentHintCounter, currentHintCounter2);
    expect(uncompletedFullyRandomTest.wrongAnswerCounter, wrongAnswerCounter2);
    expect(uncompletedFullyRandomTest.lastAnswer, lastAnswer2);
    expect(uncompletedFullyRandomTest.creationAt, creationAt2);
    expect(uncompletedFullyRandomTest.lastModificationAt, lastModificationAt2);
    uncompletedFullyRandomTest = uncompletedFullyRandomTests[1];
    expect(uncompletedFullyRandomTest.id, id5);
    expect(uncompletedFullyRandomTest.fieldListId, fieldListId2);
    expect(uncompletedFullyRandomTest.currentHintCounter, currentHintCounter5);
    expect(uncompletedFullyRandomTest.triesNumber, triesNumber5);
    expect(uncompletedFullyRandomTest.triesCounter, triesCounter5);
    expect(uncompletedFullyRandomTest.elapsedTime, elapsedTime5);
    expect(uncompletedFullyRandomTest.isCompleted, isCompleted5);
    expect(uncompletedFullyRandomTest.lastCheckedAnswerResult,
        lastCheckedAnswerResult5);
    expect(
        uncompletedFullyRandomTest.shouldCheckAnAnswer, shouldCheckAnAnswer5);
    expect(uncompletedFullyRandomTest.currentHintCounter, currentHintCounter5);
    expect(uncompletedFullyRandomTest.wrongAnswerCounter, wrongAnswerCounter5);
    expect(uncompletedFullyRandomTest.lastAnswer, lastAnswer5);
    expect(uncompletedFullyRandomTest.creationAt, creationAt5);
    expect(uncompletedFullyRandomTest.lastModificationAt, lastModificationAt5);
    uncompletedFullyRandomTests =
        await uncompletedFullyRandomTestsDao.getByFieldListId(fieldListId3);
    expect(uncompletedFullyRandomTests.length, 1);
    uncompletedFullyRandomTest = uncompletedFullyRandomTests[0];
    expect(uncompletedFullyRandomTest.id, id3);
    expect(uncompletedFullyRandomTest.fieldListId, fieldListId3);
    expect(uncompletedFullyRandomTest.currentQuestionCounter,
        currentQuestionCounter3);
    expect(uncompletedFullyRandomTest.triesNumber, triesNumber3);
    expect(uncompletedFullyRandomTest.triesCounter, triesCounter3);
    expect(uncompletedFullyRandomTest.elapsedTime, elapsedTime3);
    expect(uncompletedFullyRandomTest.isCompleted, isCompleted3);
    expect(uncompletedFullyRandomTest.lastCheckedAnswerResult,
        lastCheckedAnswerResult3);
    expect(
        uncompletedFullyRandomTest.shouldCheckAnAnswer, shouldCheckAnAnswer3);
    expect(uncompletedFullyRandomTest.currentHintCounter, currentHintCounter3);
    expect(uncompletedFullyRandomTest.wrongAnswerCounter, wrongAnswerCounter3);
    expect(uncompletedFullyRandomTest.lastAnswer, lastAnswer3);
    expect(uncompletedFullyRandomTest.creationAt, creationAt3);
    expect(uncompletedFullyRandomTest.lastModificationAt, lastModificationAt3);
  });

  group("Update UncompletedFullyRandomTest", () {
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await uncompletedFullyRandomTestsDao
          .create(uncompletedFullyRandomTest.toCompanion(true));
    });

    test(
        "Invalid update: currentQuestionCounter is smaller than ${UncompletedFullyRandomTests.MINIMUM_CURRENT_QUESTION_COUNTER}",
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .mutate(uncompletedFullyRandomTest.toCompanion(true));
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .mutate(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_question_counter"))));
    });

    test(
        "Invalid update: triesNumber is smaller than ${UncompletedFullyRandomTests.MINIMUM_TRIES_NUMBER}",
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .mutate(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_number"))));
    });

    test(
        "Invalid update: triesNumber is bigger than ${UncompletedFullyRandomTests.MAXIMUM_TRIES_NUMBER}",
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .mutate(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_number"))));
    });

    test(
        "Invalid update: triesCounter is smaller than ${UncompletedFullyRandomTests.MINIMUM_TRIES_COUNTER}",
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .mutate(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_counter"))));
    });

    test(
        "Invalid update: triesCounter is bigger than ${UncompletedFullyRandomTests.MAXIMUM_TRIES_COUNTER}",
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await uncompletedFullyRandomTestsDao
            .mutate(uncompletedFullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_counter"))));
    });
  });
}
