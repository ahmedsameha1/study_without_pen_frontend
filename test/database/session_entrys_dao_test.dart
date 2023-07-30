import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/session_entrys_dao.dart';
import 'package:study_without_pen_by_flutter/database/uncompleted_fully_random_tests_dao.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';

void main() {
  late AppDatabase appDatabase;
  late SessionEntrysDao sessionEntrysDao;
  late UncompletedFullyRandomTestsDao uncompletedFullyRandomTestsDao;
  late EntrysDao entrysDao;
  final entryId = Uuid().v4();
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
  int wrongAnswerCounter = 3;
  String lastAnswer = "wefw";
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
    sessionEntrysDao = SessionEntrysDao(appDatabase);
    uncompletedFullyRandomTestsDao =
        UncompletedFullyRandomTestsDao(appDatabase);
    entrysDao = EntrysDao(appDatabase);
    var uncompletedFullyRandomTest = UncompletedFullyRandomTest(
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
        wrongAnswerCounter: wrongAnswerCounter,
        lastAnswer: lastAnswer,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt);
    await uncompletedFullyRandomTestsDao
        .create(uncompletedFullyRandomTest.toCompanion(true));
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

  group("Create SessionEntry", () {
    test("Invalid SessionEntry: sessionId is an invalid UUID v4", () async {
      final sessionEntry = SessionEntry(sessionId: "wef", entryId: entryId);
      expect(() async {
        await sessionEntrysDao.create(sessionEntry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("sessionId"))));
    });

    test("Invalid SessionEntry: sessionId doesn't exist", () async {
      final sessionEntry =
          SessionEntry(sessionId: const Uuid().v4(), entryId: entryId);
      expect(() async {
        await sessionEntrysDao.create(sessionEntry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test("Invalid SessionEntry: entryId is an invalid UUID v4", () async {
      final sessionEntry =
          SessionEntry(sessionId: sessionId, entryId: "ehfwofj");
      expect(() async {
        await sessionEntrysDao.create(sessionEntry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("entryId"))));
    });

    test("Invalid SessionEntry: entryId doesn't exist", () async {
      final sessionEntry =
          SessionEntry(sessionId: sessionId, entryId: const Uuid().v4());
      expect(() async {
        await sessionEntrysDao.create(sessionEntry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test("No more one SesstionEntry with the same sessionId and entryId",
        () async {
      final sessionEntry = SessionEntry(sessionId: sessionId, entryId: entryId);
      await sessionEntrysDao.create(sessionEntry.toCompanion(true));
      expect(() async {
        await sessionEntrysDao.create(sessionEntry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("entry_id") &&
              e.message.contains("session_id"))));
    });
  });

  test("Delete SessionEntry", () async {
    final sessionEntry = SessionEntry(sessionId: sessionId, entryId: entryId);
    await sessionEntrysDao.create(sessionEntry.toCompanion(true));
    await sessionEntrysDao.remove(sessionId, entryId);
    final result = await (appDatabase.select(appDatabase.sessionEntrys)
          ..where((tbl) =>
              tbl.sessionId.equals(sessionId) & tbl.entryId.equals(entryId)))
        .getSingleOrNull();
    expect(result, null);
  });
}
