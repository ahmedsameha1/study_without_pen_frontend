import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/sessions_dao.dart';
import 'package:study_without_pen_by_flutter/database/test_sessions_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late TestSessionsDao testSessionsDao;
  late SessionsDao sessionsDao;
  final sessionId = Uuid().v4();
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

  setUp(() async {
    appDatabase = AppDatabase(NativeDatabase.memory());
    testSessionsDao = TestSessionsDao(appDatabase);
    sessionsDao = SessionsDao(appDatabase);
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
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a TestSession", () {
    test("Invalid TestSession: sessionId is an invalid UUID v4", () {
      final testSession = TestSession(sessionId: "wefbhwe");
      expect(() async {
        await testSessionsDao.create(testSession.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("sessionId"))));
    });

    test("Invalid TestSession: sessionId doesn't exist in sessions table", () {
      final testSession = TestSession(sessionId: const Uuid().v4());
      expect(() async {
        await testSessionsDao.create(testSession.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test(
        "Invalid TestSession: No more than one TestSession with the same sessionId",
        () async {
      final testSession1 = TestSession(sessionId: sessionId);
      final testSession2 = TestSession(sessionId: sessionId);
      await testSessionsDao.create(testSession1.toCompanion(true));
      expect(() async {
        await testSessionsDao.create(testSession2.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("session_id"))));
    });
  });
}
