import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late EntrysDao entrysDao;
  String id = const Uuid().v4();
  String fieldListId = const Uuid().v4();
  String answerId = const Uuid().v4();
  String questionId = const Uuid().v4();
  DateTime creationAt = DateTime.utc(2020, 1, 1);
  DateTime lastModificationAt = DateTime.utc(2020, 2, 2);
  DateTime emulatedCreatedAt = DateTime.utc(2022, 2, 2);
  int order = 1;
  int rank = Rank.Normal.index;
  int askedCount = 2;
  int wronglyAnsweredCount = 1;
  bool didAskedAtCurrentTestRound = true;
  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    entrysDao = EntrysDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create an Entry", () {
    test("Invalid Entry: id is an invalid UUID v4", () async {
      var entry = Entry(
          id: "ewhfwo",
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
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("Creating Question with the same 'id'", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          emulatedCreatedAt: emulatedCreatedAt,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      var entry1 = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          emulatedCreatedAt: emulatedCreatedAt,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
        await entrysDao.create(entry1.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid Entry: fieldListId is an invalid UUID v4", () async {
      var entry = Entry(
          id: id,
          fieldListId: "wiuofehw",
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          emulatedCreatedAt: emulatedCreatedAt,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldListId"))));
    });

    test("Invalid Entry: answerId is an invalid UUID v4", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: "uefwe",
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("answerId"))));
    });

    test("Invalid Entry: questionId is an invalid UUID v4", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: "uehfe",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("questionId"))));
    });

    test("The same fieldListId and the same answerId and the same questionId",
        () {
      var entry = Entry(
          id: id,
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
      var entry1 = Entry(
          id: const Uuid().v4(),
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
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
        await entrysDao.create(entry1.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("field_list_id") &&
              e.message.contains("question_id") &&
              e.message.contains("answer_id"))));
    });

    test("Invalid Entry: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2023, 1, 1)), () {
        var entry = Entry(
            id: id,
            fieldListId: fieldListId,
            answerId: answerId,
            questionId: questionId,
            creationAt: DateTime.utc(2023, 2, 2),
            lastModificationAt: lastModificationAt,
            order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
            rank: rank,
            askedCount: askedCount,
            wronglyAnsweredCount: wronglyAnsweredCount);
        expect(() async {
          await entrysDao.create(entry.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException && e.message.contains("creation_at"))));
      });
    });

    test("Invalid Entry: lastModificationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2023, 1, 1)), () {
        var entry = Entry(
            id: id,
            fieldListId: fieldListId,
            answerId: answerId,
            questionId: questionId,
            creationAt: creationAt,
            lastModificationAt: DateTime.utc(2023, 2, 2),
            order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
            rank: rank,
            askedCount: askedCount,
            wronglyAnsweredCount: wronglyAnsweredCount);
        expect(() async {
          await entrysDao.create(entry.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Invalid Entry: lastModificationAt is before creationAt", () {
      withClock(Clock.fixed(DateTime.utc(2023, 1, 1)), () {
        var entry = Entry(
            id: id,
            fieldListId: fieldListId,
            answerId: answerId,
            questionId: questionId,
            creationAt: DateTime.utc(2021, 1, 1),
            lastModificationAt: DateTime.utc(2020, 1, 1),
            order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
            rank: rank,
            askedCount: askedCount,
            wronglyAnsweredCount: wronglyAnsweredCount);
        expect(() async {
          await entrysDao.create(entry.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Invalid Entry: order is greater than 65535", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 65535 + 1,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("order"))));
    });

    test("Invalid Entry: order is smaller than 0", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 0 - 1,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("order"))));
    });

    test("Invalid Entry: rank is invalid value", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: 8,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("rank"))));
    });

    test("Invalid Entry: askedCount is greater than 65535", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 1,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: 65535 + 1,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("asked_count"))));
    });

    test("Invalid Entry: askedCount is smaller than 0", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: 0 - 1,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("asked_count"))));
    });

    test("Invalid Entry: wronglyAnsweredCount is greater than 65535", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: 1,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: 65535 + 1);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrongly_answered_count"))));
    });

    test("Invalid Entry: wronglyAnsweredCount is smaller than 0", () async {
      var entry = Entry(
          id: id,
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
          wronglyAnsweredCount: 0 - 1);
      expect(() async {
        await entrysDao.create(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrongly_answered_count"))));
    });

    test("Good case", () async {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
    });
  });
}
