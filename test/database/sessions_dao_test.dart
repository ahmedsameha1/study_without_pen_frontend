import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/sessions_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late SessionsDao sessionsDao;
  String id = Uuid().v4();
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

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    sessionsDao = SessionsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a Session", () {
    test("Invalid Session: id is an invalid UUID v4", () {
      var session = Session(
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No Sessions with the same id", () async {
      var session1 = Session(
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      var session2 = Session(
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await sessionsDao.create(session1.toCompanion(true));
      expect(() async {
        await sessionsDao.create(session2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid Session: fieldListId is an invalid UUID v4", () {
      var session = Session(
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldListId"))));
    });

    test(
        "Invalid Session: currentQuestionCounter is smaller than ${Sessions.MINIMUM_CURRENT_QUESTION_COUNTER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: Sessions.MINIMUM_CURRENT_QUESTION_COUNTER - 1,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_question_counter"))));
    });

    test(
        "Invalid Session: currentQuestionCounter is bigger than ${Sessions.MAXIMUM_CURRENT_QUESTION_COUNTER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: Sessions.MAXIMUM_CURRENT_QUESTION_COUNTER + 1,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_question_counter"))));
    });

    test(
        "Invalid Session: triesNumber is smaller than ${Sessions.MINIMUM_TRIES_NUMBER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: Sessions.MINIMUM_TRIES_NUMBER - 1,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_number"))));
    });

    test(
        "Invalid Session: triesNumber is bigger than ${Sessions.MAXIMUM_TRIES_NUMBER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: Sessions.MAXIMUM_TRIES_NUMBER + 1,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_number"))));
    });

    test(
        "Invalid Session: triesCounter is smaller than ${Sessions.MINIMUM_TRIES_COUNTER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: Sessions.MINIMUM_TRIES_COUNTER - 1,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_counter"))));
    });

    test(
        "Invalid Session: triesCounter is bigger than ${Sessions.MAXIMUM_TRIES_COUNTER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: Sessions.MAXIMUM_TRIES_COUNTER + 1,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_counter"))));
    });

    test(
        "Invalid Session: triesCounter is bigger than or equal to tries number",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesNumber,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_counter"))));
      session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesNumber + 1,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_counter"))));
    });

    test(
        "Invalid Session: elapsedTime is smaller than ${Sessions.MINIMUM_ELAPSED_TIME}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: Sessions.MINIMUM_ELAPSED_TIME - 1,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("elapsed_time"))));
    });

    test(
        "Invalid Session: currentHintCounter is smaller than ${Sessions.MINIMUM_CURRENT_HINT_COUNTER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: Sessions.MINIMUM_CURRENT_HINT_COUNTER - 1,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_hint_counter"))));
    });

    test(
        "Invalid Session: currentHintCounter is bigger than ${Sessions.MAXIMUM_CURRENT_HINT_COUNTER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: Sessions.MAXIMUM_CURRENT_HINT_COUNTER + 1,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_hint_counter"))));
    });
/*
    test(
        "Invalid Session: wrongAnswerCounter is smaller than ${Sessions.MINIMUM_WRONG_ANSWER_COUNTER}",
        () {
      var session = Session(
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
              Sessions.MINIMUM_WRONG_ANSWER_COUNTER - 1,
          lastAnswer: lastAnswer,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao
            .create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrong_answer_counter"))));
    });

    test(
        "Invalid Session: wrongAnswerCounter is bigger than ${Sessions.MAXIMUM_WRONG_ANSWER_COUNTER}",
        () {
      var session = Session(
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
              Sessions.MAXIMUM_WRONG_ANSWER_COUNTER + 1,
          lastAnswer: lastAnswer,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao
            .create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrong_answer_counter"))));
    });

    test("Invalid Session: lastAnswer is empty", () async {
      var session = Session(
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
          lastAnswer: "",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao
            .create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("last_answer"))));
      session = Session(
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
          lastAnswer: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao
            .create(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("last_answer"))));
    });
    */

    test("Invalid Session: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2020, 1, 1)), () {
        var session = Session(
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
            creationAt: DateTime.utc(2023, 1, 1),
            lastModificationAt: lastModificationAt);
        expect(() async {
          await sessionsDao.create(session.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("Invalid Session: lastModificationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2020, 1, 1)), () {
        var session = Session(
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
            creationAt: creationAt,
            lastModificationAt: DateTime.utc(2023, 1, 1));
        expect(() async {
          await sessionsDao.create(session.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
      });
    });

    test("Invalid Session: lastModificationAt is before creationAt", () {
      withClock(Clock.fixed(DateTime.utc(2020, 1, 1)), () {
        var session = Session(
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
            creationAt: creationAt,
            lastModificationAt: DateTime.utc(2013, 1, 1));
        expect(() async {
          await sessionsDao.create(session.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Good case: create Session without 'id'", () async {
      var sessionsCompanion = SessionsCompanion(
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          triesCounter: Value(triesCounter),
          elapsedTime: Value(elapsedTime),
          isCompleted: Value(isCompleted),
          lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
          shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
          currentHintCounter: Value(currentHintCounter),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await sessionsDao.create((sessionsCompanion));
    });

    test("Good case 2: create Session without triesCounter", () async {
      var sessionsCompanion = SessionsCompanion(
          id: Value(id),
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          elapsedTime: Value(elapsedTime),
          isCompleted: Value(isCompleted),
          lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
          shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
          currentHintCounter: Value(currentHintCounter),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await sessionsDao.create((sessionsCompanion));
    });

    test("Good case 3: create Session without isCompleted", () async {
      var sessionsCompanion = SessionsCompanion(
          id: Value(id),
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          triesCounter: Value(triesCounter),
          elapsedTime: Value(elapsedTime),
          lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
          shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
          currentHintCounter: Value(currentHintCounter),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await sessionsDao.create((sessionsCompanion));
    });

    test("Good case 4: create Session without lastCheckedAnswerResult",
        () async {
      var sessionsCompanion = SessionsCompanion(
          id: Value(id),
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          triesCounter: Value(triesCounter),
          elapsedTime: Value(elapsedTime),
          isCompleted: Value(isCompleted),
          shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
          currentHintCounter: Value(currentHintCounter),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await sessionsDao.create((sessionsCompanion));
    });

    test("Good case 5: create Session without shouldCheckAnAnswer", () async {
      var sessionsCompanion = SessionsCompanion(
          id: Value(id),
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          triesCounter: Value(triesCounter),
          elapsedTime: Value(elapsedTime),
          isCompleted: Value(isCompleted),
          lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
          currentHintCounter: Value(currentHintCounter),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await sessionsDao.create((sessionsCompanion));
    });

    test("Good case 6: create Session without currentHintCounter", () async {
      var sessionsCompanion = SessionsCompanion(
          id: Value(id),
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          triesCounter: Value(triesCounter),
          elapsedTime: Value(elapsedTime),
          isCompleted: Value(isCompleted),
          lastCheckedAnswerResult: Value(lastCheckedAnswerResult),
          shouldCheckAnAnswer: Value(shouldCheckAnAnswer),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await sessionsDao.create((sessionsCompanion));
    });

    test("Good case 6: create Session without wrongAnswerCounter", () async {
      var sessionsCompanion = SessionsCompanion(
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
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await sessionsDao.create((sessionsCompanion));
    });

    test("Good case 7: create Session without lastAnswer", () async {
      var sessionsCompanion = SessionsCompanion(
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
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await sessionsDao.create((sessionsCompanion));
    });
  });

  group("Getting Session by id", () {
    var id2 = const Uuid().v4();
    setUp(() async {
      var session = Session(
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await sessionsDao.create(session.toCompanion(true));
    });

    test("Good case: Session is found", () async {
      Session? gottenSession = await sessionsDao.getById(id);
      gottenSession = gottenSession!;
      expect(id, gottenSession.id);
      expect(fieldListId, gottenSession.fieldListId);
      expect(currentQuestionCounter, gottenSession.currentQuestionCounter);
      expect(triesNumber, gottenSession.triesNumber);
      expect(triesCounter, gottenSession.triesCounter);
      expect(elapsedTime, gottenSession.elapsedTime);
      expect(isCompleted, gottenSession.isCompleted);
      expect(lastCheckedAnswerResult, gottenSession.lastCheckedAnswerResult);
      expect(shouldCheckAnAnswer, gottenSession.shouldCheckAnAnswer);
      expect(currentHintCounter, gottenSession.currentHintCounter);
      expect(creationAt, gottenSession.creationAt);
      expect(lastModificationAt, gottenSession.lastModificationAt);
    });

    test("Good case: Session is not found", () async {
      Session? gottenSession = await sessionsDao.getById(const Uuid().v4());
      expect(gottenSession, null);
    });

    test("Test default values", () async {
      var sessionsCompanion = SessionsCompanion(
          id: Value(id2),
          fieldListId: Value(fieldListId),
          currentQuestionCounter: Value(currentQuestionCounter),
          triesNumber: Value(triesNumber),
          elapsedTime: Value(elapsedTime),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await sessionsDao.create(sessionsCompanion);
      Session? gottenSession = await sessionsDao.getById(id2);
      gottenSession = gottenSession!;
      expect(gottenSession.triesCounter, 0);
      expect(gottenSession.isCompleted, false);
      expect(gottenSession.lastCheckedAnswerResult, false);
      expect(gottenSession.shouldCheckAnAnswer, true);
      expect(gottenSession.currentHintCounter, 0);
    });
  });

  test("Get all Session by fieldListId", () async {
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
    var session1 = Session(
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
        creationAt: creationAt1,
        lastModificationAt: lastModificationAt1);
    var session2 = Session(
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
        creationAt: creationAt2,
        lastModificationAt: lastModificationAt2);
    var session3 = Session(
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
        creationAt: creationAt3,
        lastModificationAt: lastModificationAt3);
    var session4 = Session(
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
        creationAt: creationAt4,
        lastModificationAt: lastModificationAt4);
    var session5 = Session(
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
        creationAt: creationAt5,
        lastModificationAt: lastModificationAt5);
    var session6 = Session(
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
        creationAt: creationAt6,
        lastModificationAt: lastModificationAt6);
    await sessionsDao.create(session1.toCompanion(true));
    await sessionsDao.create(session2.toCompanion(true));
    await sessionsDao.create(session3.toCompanion(true));
    await sessionsDao.create(session4.toCompanion(true));
    await sessionsDao.create(session5.toCompanion(true));
    await sessionsDao.create(session6.toCompanion(true));
    var sessions = await sessionsDao.getByFieldListId(fieldListId1);
    expect(sessions.length, 3);
    var session = sessions[0];
    expect(session.id, id6);
    expect(session.fieldListId, fieldListId1);
    expect(session.currentQuestionCounter, currentQuestionCounter6);
    expect(session.triesNumber, triesNumber6);
    expect(session.triesCounter, triesCounter6);
    expect(session.elapsedTime, elapsedTime6);
    expect(session.isCompleted, isCompleted6);
    expect(session.lastCheckedAnswerResult, lastCheckedAnswerResult6);
    expect(session.shouldCheckAnAnswer, shouldCheckAnAnswer6);
    expect(session.currentHintCounter, currentHintCounter6);
    expect(session.creationAt, creationAt6);
    expect(session.lastModificationAt, lastModificationAt6);
    session = sessions[1];
    expect(session.id, id4);
    expect(session.fieldListId, fieldListId1);
    expect(session.currentHintCounter, currentHintCounter4);
    expect(session.triesNumber, triesNumber4);
    expect(session.triesCounter, triesCounter4);
    expect(session.elapsedTime, elapsedTime4);
    expect(session.isCompleted, isCompleted4);
    expect(session.lastCheckedAnswerResult, lastCheckedAnswerResult4);
    expect(session.shouldCheckAnAnswer, shouldCheckAnAnswer4);
    expect(session.currentHintCounter, currentHintCounter4);
    expect(session.creationAt, creationAt4);
    expect(session.lastModificationAt, lastModificationAt4);
    session = sessions[2];
    expect(session.id, id1);
    expect(session.fieldListId, fieldListId1);
    expect(session.currentQuestionCounter, currentQuestionCounter1);
    expect(session.triesNumber, triesNumber1);
    expect(session.triesCounter, triesCounter1);
    expect(session.elapsedTime, elapsedTime1);
    expect(session.isCompleted, isCompleted1);
    expect(session.lastCheckedAnswerResult, lastCheckedAnswerResult1);
    expect(session.shouldCheckAnAnswer, shouldCheckAnAnswer1);
    expect(session.currentHintCounter, currentHintCounter1);
    expect(session.creationAt, creationAt1);
    expect(session.lastModificationAt, lastModificationAt1);
    sessions = await sessionsDao.getByFieldListId(fieldListId2);
    expect(sessions.length, 2);
    session = sessions[0];
    expect(session.id, id2);
    expect(session.fieldListId, fieldListId2);
    expect(session.currentQuestionCounter, currentQuestionCounter2);
    expect(session.triesNumber, triesNumber2);
    expect(session.triesCounter, triesCounter2);
    expect(session.elapsedTime, elapsedTime2);
    expect(session.isCompleted, isCompleted2);
    expect(session.lastCheckedAnswerResult, lastCheckedAnswerResult2);
    expect(session.shouldCheckAnAnswer, shouldCheckAnAnswer2);
    expect(session.currentHintCounter, currentHintCounter2);
    expect(session.creationAt, creationAt2);
    expect(session.lastModificationAt, lastModificationAt2);
    session = sessions[1];
    expect(session.id, id5);
    expect(session.fieldListId, fieldListId2);
    expect(session.currentHintCounter, currentHintCounter5);
    expect(session.triesNumber, triesNumber5);
    expect(session.triesCounter, triesCounter5);
    expect(session.elapsedTime, elapsedTime5);
    expect(session.isCompleted, isCompleted5);
    expect(session.lastCheckedAnswerResult, lastCheckedAnswerResult5);
    expect(session.shouldCheckAnAnswer, shouldCheckAnAnswer5);
    expect(session.currentHintCounter, currentHintCounter5);
    expect(session.creationAt, creationAt5);
    expect(session.lastModificationAt, lastModificationAt5);
    sessions = await sessionsDao.getByFieldListId(fieldListId3);
    expect(sessions.length, 1);
    session = sessions[0];
    expect(session.id, id3);
    expect(session.fieldListId, fieldListId3);
    expect(session.currentQuestionCounter, currentQuestionCounter3);
    expect(session.triesNumber, triesNumber3);
    expect(session.triesCounter, triesCounter3);
    expect(session.elapsedTime, elapsedTime3);
    expect(session.isCompleted, isCompleted3);
    expect(session.lastCheckedAnswerResult, lastCheckedAnswerResult3);
    expect(session.shouldCheckAnAnswer, shouldCheckAnAnswer3);
    expect(session.currentHintCounter, currentHintCounter3);
    expect(session.creationAt, creationAt3);
    expect(session.lastModificationAt, lastModificationAt3);
  });

  group("Update Session", () {
    setUp(() async {
      var session = Session(
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
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await sessionsDao.create(session.toCompanion(true));
    });

    test("invalid update: trying to update fieldListId", () async {
      final newFieldListId = const Uuid().v4();
      var session = Session(
          id: id,
          fieldListId: newFieldListId,
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
      expect(() async {
        await sessionsDao.mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("Updating fieldListId"))));
    });

    test(
        "Invalid update: currentQuestionCounter is smaller than ${Sessions.MINIMUM_CURRENT_QUESTION_COUNTER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: Sessions.MINIMUM_CURRENT_QUESTION_COUNTER - 1,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_question_counter"))));
    });

    test(
        "Invalid Session: currentQuestionCounter is bigger than ${Sessions.MAXIMUM_CURRENT_QUESTION_COUNTER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: Sessions.MAXIMUM_CURRENT_QUESTION_COUNTER + 1,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_question_counter"))));
    });

    test(
        "Invalid update: triesNumber is smaller than ${Sessions.MINIMUM_TRIES_NUMBER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: Sessions.MINIMUM_TRIES_NUMBER - 1,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_number"))));
    });

    test(
        "Invalid update: triesNumber is bigger than ${Sessions.MAXIMUM_TRIES_NUMBER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: Sessions.MAXIMUM_TRIES_NUMBER + 1,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_number"))));
    });

    test(
        "Invalid update: triesCounter is smaller than ${Sessions.MINIMUM_TRIES_COUNTER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: Sessions.MINIMUM_TRIES_COUNTER - 1,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_counter"))));
    });

    test(
        "Invalid update: triesCounter is bigger than ${Sessions.MAXIMUM_TRIES_COUNTER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: Sessions.MAXIMUM_TRIES_COUNTER + 1,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("tries_counter"))));
    });

    test(
        "Invalid update: elapsedTime is smaller than ${Sessions.MINIMUM_ELAPSED_TIME}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: Sessions.MINIMUM_ELAPSED_TIME - 1,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("elapsed_time"))));
    });

    test(
        "Invalid update: currentHintCounter is smaller than ${Sessions.MINIMUM_CURRENT_HINT_COUNTER}",
        () {
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: currentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: triesCounter,
          elapsedTime: elapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: Sessions.MINIMUM_CURRENT_HINT_COUNTER - 1,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao.mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("current_hint_counter"))));
    });
/*
    test(
        "Invalid update: wrongAnswerCounter is smaller than ${Sessions.MINIMUM_WRONG_ANSWER_COUNTER}",
        () {
      var session = Session(
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
          lastAnswer: lastAnswer,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao
            .mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrong_answer_counter"))));
    });

    test(
        "Invalid update: wrongAnswerCounter is bigger than ${Sessions.MAXIMUM_WRONG_ANSWER_COUNTER}",
        () {
      var session = Session(
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
          lastAnswer: lastAnswer,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao
            .mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrong_answer_counter"))));
    });

    test("Invalid update: lastAnswer is empty", () async {
      var session = Session(
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
          lastAnswer: "",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao
            .mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("last_answer"))));
      session = Session(
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
          lastAnswer: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await sessionsDao
            .mutate(session.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("last_answer"))));
    });
    */

    test("Invalid update: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2020, 1, 1)), () {
        var session = Session(
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
            creationAt: DateTime.utc(2023, 1, 1),
            lastModificationAt: lastModificationAt);
        expect(() async {
          await sessionsDao.mutate(session.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("Invalid update: lastModificationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2020, 1, 1)), () {
        var session = Session(
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
            creationAt: creationAt,
            lastModificationAt: DateTime.utc(2023, 1, 1));
        expect(() async {
          await sessionsDao.mutate(session.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
      });
    });

    test("Invalid update: lastModificationAt is before creationAt", () {
      withClock(Clock.fixed(DateTime.utc(2020, 1, 1)), () {
        var session = Session(
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
            creationAt: creationAt,
            lastModificationAt: DateTime.utc(2013, 1, 1));
        expect(() async {
          await sessionsDao.mutate(session.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("good case:", () async {
      final newCurrentQuestionCounter = currentQuestionCounter + 1;
      final newTriesCounter = triesCounter + 1;
      final newElapsedTime = elapsedTime + 100;
      var session = Session(
          id: id,
          fieldListId: fieldListId,
          currentQuestionCounter: newCurrentQuestionCounter,
          triesNumber: triesNumber,
          triesCounter: newTriesCounter,
          elapsedTime: newElapsedTime,
          isCompleted: isCompleted,
          lastCheckedAnswerResult: lastCheckedAnswerResult,
          shouldCheckAnAnswer: shouldCheckAnAnswer,
          currentHintCounter: currentHintCounter,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await sessionsDao.mutate(session.toCompanion(true));
      var gottenSession = await sessionsDao.getById(id);
      gottenSession = gottenSession!;
      expect(session.id, id);
      expect(session.fieldListId, fieldListId);
      expect(session.currentQuestionCounter, newCurrentQuestionCounter);
      expect(session.triesNumber, triesNumber);
      expect(session.triesCounter, newTriesCounter);
      expect(session.elapsedTime, newElapsedTime);
      expect(session.isCompleted, isCompleted);
      expect(session.lastCheckedAnswerResult, lastCheckedAnswerResult);
      expect(session.shouldCheckAnAnswer, shouldCheckAnAnswer);
      expect(session.currentHintCounter, currentHintCounter);
      expect(session.creationAt, creationAt);
      expect(session.lastModificationAt, lastModificationAt);
    });
  });
  test("Delete Session", () async {
    var session = Session(
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
        creationAt: creationAt,
        lastModificationAt: lastModificationAt);
    await sessionsDao.create(session.toCompanion(true));
    await sessionsDao.remove(id);
    var gottenSession = await sessionsDao.getById(id);
    expect(gottenSession, null);
  });
}
