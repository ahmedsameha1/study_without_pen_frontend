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
          triesNumber: triesNumber);
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
          triesNumber: triesNumber);
      var fullyRandomTest2 = FullyRandomTest(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber);
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
          triesNumber: triesNumber);
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
          triesNumber: triesNumber);
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
          triesNumber: triesNumber);
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
          triesNumber: FullyRandomTests.MINIMUM_TRIES_NUMBER - 1);
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
          triesNumber: FullyRandomTests.MAXIMUM_TRIES_NUMBER + 1);
      expect(() async {
        await fullyRandomTestsDao.create(fullyRandomTest.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_number"))));
    });

    test("Good case: create FullyRandomTest without 'id'", () async {
      var fullyRandomTestsCompanion = FullyRandomTestsCompanion(
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber));
      await fullyRandomTestsDao.create(fullyRandomTestsCompanion);
    });
  });
}
