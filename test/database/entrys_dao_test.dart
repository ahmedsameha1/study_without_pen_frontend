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

  group("Getting entry by id", () {
    test("Good case: the entry is found", () async {
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
      await entrysDao.create(entry.toCompanion(true));
      var gottenEntry = await entrysDao.getById(id);
      gottenEntry = gottenEntry!;
      expect(gottenEntry.id, id);
      expect(gottenEntry.fieldListId, fieldListId);
      expect(gottenEntry.answerId, answerId);
      expect(gottenEntry.questionId, questionId);
      expect(gottenEntry.creationAt, creationAt);
      expect(gottenEntry.lastModificationAt, lastModificationAt);
      expect(gottenEntry.order, order);
      expect(
          gottenEntry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(gottenEntry.emulatedCreatedAt, emulatedCreatedAt);
      expect(gottenEntry.rank, rank);
      expect(gottenEntry.askedCount, askedCount);
      expect(gottenEntry.wronglyAnsweredCount, wronglyAnsweredCount);
    });

    test("Good case: the entry is not found", () async {
      var gottenEntry = await entrysDao.getById(const Uuid().v4());
      expect(gottenEntry, null);
    });
  });

  group("Get entries by fieldlist", () {
    test("At least one entry is found in the fieldList", () async {
      String id1 = const Uuid().v4();
      String id2 = const Uuid().v4();
      String id3 = const Uuid().v4();
      String id4 = const Uuid().v4();
      String fieldListId1 = const Uuid().v4();
      String fieldListId2 = const Uuid().v4();
      String answerId2 = const Uuid().v4();
      String answerId3 = const Uuid().v4();
      String answerId4 = const Uuid().v4();
      String questionId2 = const Uuid().v4();
      String questionId3 = const Uuid().v4();
      String questionId4 = const Uuid().v4();
      DateTime creationAt2 = DateTime.utc(2019, 1, 1);
      DateTime creationAt3 = DateTime.utc(2021, 1, 1);
      DateTime creationAt4 = DateTime.utc(2018, 1, 1);
      DateTime lastModificationAt2 = DateTime.utc(2019, 2, 1);
      DateTime lastModificationAt3 = DateTime.utc(2021, 2, 1);
      DateTime lastModificationAt4 = DateTime.utc(2019, 2, 1);
      var entry = Entry(
          id: id1,
          fieldListId: fieldListId1,
          answerId: answerId,
          questionId: questionId,
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
          fieldListId: fieldListId2,
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
          order: 2,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
          id: id4,
          fieldListId: fieldListId1,
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
      List<Entry> entries = await entrysDao.getByFieldListId(fieldListId1);
      expect(entries.length, 3);
      entry = entries[0];
      expect(entry.id, id3);
      expect(entry.fieldListId, fieldListId1);
      expect(entry.answerId, answerId3);
      expect(entry.questionId, questionId3);
      expect(entry.creationAt, creationAt2);
      expect(entry.lastModificationAt, lastModificationAt2);
      expect(entry.order, 2);
      expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
      entry = entries[1];
      expect(entry.id, id4);
      expect(entry.fieldListId, fieldListId1);
      expect(entry.answerId, answerId4);
      expect(entry.questionId, questionId4);
      expect(entry.creationAt, creationAt4);
      expect(entry.lastModificationAt, lastModificationAt4);
      expect(entry.order, 2);
      expect(entry.didAskedAtCurrentTestRound, true);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
      entry = entries[2];
      expect(entry.id, id1);
      expect(entry.fieldListId, fieldListId1);
      expect(entry.answerId, answerId);
      expect(entry.questionId, questionId);
      expect(entry.creationAt, creationAt);
      expect(entry.lastModificationAt, lastModificationAt);
      expect(entry.order, 3);
      expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
    });

    test("Good case: no entry is found in the fieldList", () async {
      var entries = await entrysDao.getByFieldListId(const Uuid().v4());
      expect(entries.length, 0);
    });
  });

  group("Get all entries", () {
    test("Get all entries in Descending order by creationAt field", () async {
      String id2 = const Uuid().v4();
      String id3 = const Uuid().v4();
      String id4 = const Uuid().v4();
      String answerId2 = const Uuid().v4();
      String answerId3 = const Uuid().v4();
      String answerId4 = const Uuid().v4();
      String questionId2 = const Uuid().v4();
      String questionId3 = const Uuid().v4();
      String questionId4 = const Uuid().v4();
      DateTime creationAt2 = DateTime.utc(2019, 1, 1);
      DateTime creationAt3 = DateTime.utc(2021, 1, 1);
      DateTime creationAt4 = DateTime.utc(2018, 1, 1);
      DateTime lastModificationAt2 = DateTime.utc(2019, 2, 1);
      DateTime lastModificationAt3 = DateTime.utc(2021, 2, 1);
      DateTime lastModificationAt4 = DateTime.utc(2019, 2, 1);
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
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
          fieldListId: fieldListId,
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
          fieldListId: fieldListId,
          answerId: answerId3,
          questionId: questionId3,
          creationAt: creationAt2,
          lastModificationAt: lastModificationAt2,
          order: 2,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      entry = Entry(
          id: id4,
          fieldListId: fieldListId,
          answerId: answerId4,
          questionId: questionId4,
          creationAt: creationAt4,
          lastModificationAt: lastModificationAt4,
          order: order,
          didAskedAtCurrentTestRound: true,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      await entrysDao.create(entry.toCompanion(true));
      final entries = await entrysDao.getAll();
      expect(entries.length, 4);
      entry = entries[0];
      expect(entry.id, id4);
      expect(entry.fieldListId, fieldListId);
      expect(entry.answerId, answerId4);
      expect(entry.questionId, questionId4);
      expect(entry.creationAt, creationAt4);
      expect(entry.lastModificationAt, lastModificationAt4);
      expect(entry.order, order);
      expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
      entry = entries[1];
      expect(entry.id, id2);
      expect(entry.fieldListId, fieldListId);
      expect(entry.answerId, answerId2);
      expect(entry.questionId, questionId2);
      expect(entry.creationAt, creationAt3);
      expect(entry.lastModificationAt, lastModificationAt3);
      expect(entry.order, 2);
      expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
      entry = entries[2];
      expect(entry.id, id3);
      expect(entry.fieldListId, fieldListId);
      expect(entry.answerId, answerId3);
      expect(entry.questionId, questionId3);
      expect(entry.creationAt, creationAt2);
      expect(entry.lastModificationAt, lastModificationAt2);
      expect(entry.order, 2);
      expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
      entry = entries[3];
      expect(entry.id, id);
      expect(entry.fieldListId, fieldListId);
      expect(entry.answerId, answerId);
      expect(entry.questionId, questionId);
      expect(entry.creationAt, creationAt);
      expect(entry.lastModificationAt, lastModificationAt);
      expect(entry.order, 3);
      expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(entry.emulatedCreatedAt, emulatedCreatedAt);
      expect(entry.rank, rank);
      expect(entry.askedCount, askedCount);
      expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
    });

    test("Good case: there is no entries", () async {
      var entries = await entrysDao.getAll();
      expect(entries.length, 0);
    });
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

    test("No Entry with the same 'id'", () async {
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
      await entrysDao.create(entry.toCompanion(true));
      expect(() async {
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
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
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
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
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

    test("Good case: Creating Entry without giving an 'id'", () async {
      var entrysCompanion = EntrysCompanion(
          fieldListId: Value(fieldListId),
          answerId: Value(answerId),
          questionId: Value(questionId),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          order: Value(order),
          didAskedAtCurrentTestRound: Value(true),
          emulatedCreatedAt: Value(emulatedCreatedAt),
          rank: Value(rank),
          askedCount: Value(askedCount),
          wronglyAnsweredCount: Value(wronglyAnsweredCount));
      await entrysDao.create(entrysCompanion);
      List<Entry> entrys = await entrysDao.getAll();
      expect(isValid(entrys[0].id), true);
    });
  });

  group("Update Entry", () {
    setUp(() async {
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
      await entrysDao.create(entry.toCompanion(true));
    });
    test("fieldListId field should be a valid UUID v4", () {
      var entry = Entry(
          id: id,
          fieldListId: "eweho",
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
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldListId"))));
    });

    test("answerId field should be a valid UUID v4", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: "ewh2woe",
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
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("answerId"))));
    });

    test("questionId field should be a valid UUID v4", () {
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: "oewhow",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: order,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("questionId"))));
    });

    test("creationAt field should be a DateTime in the past", () {
      withClock(Clock.fixed(DateTime.utc(2020, 3, 3)), () {
        var entry = Entry(
            id: id,
            fieldListId: fieldListId,
            answerId: answerId,
            questionId: questionId,
            creationAt: DateTime.utc(2021, 5, 5),
            lastModificationAt: lastModificationAt,
            order: order,
            didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
            emulatedCreatedAt: emulatedCreatedAt,
            rank: rank,
            askedCount: askedCount,
            wronglyAnsweredCount: wronglyAnsweredCount);
        expect(() async {
          await entrysDao.mutate(entry.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("lastModificationAt field should be a DateTime in the past", () {
      withClock(Clock.fixed(DateTime.utc(2023, 1, 1)), () {
        var entry = Entry(
            id: id,
            fieldListId: fieldListId,
            answerId: answerId,
            questionId: questionId,
            creationAt: creationAt,
            lastModificationAt: DateTime(2024, 1, 1),
            order: order,
            didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
            emulatedCreatedAt: emulatedCreatedAt,
            rank: rank,
            askedCount: askedCount,
            wronglyAnsweredCount: wronglyAnsweredCount);
        expect(() async {
          await entrysDao.mutate(entry.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
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
          await entrysDao.mutate(entry.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Invalid update: order is greater than 65535", () {
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
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("order"))));
    });

    test("Invalid update: order is smaller than 0", () {
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
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("order"))));
    });

    test("Invalid update: rank is invalid value", () {
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
          rank: 7,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("rank"))));
    });

    test("Invalid update: askedCount is greater than 65535", () {
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
          askedCount: 65535 + 1,
          wronglyAnsweredCount: wronglyAnsweredCount);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("asked_count"))));
    });

    test("Invalid update: askedCount is smaller than 0", () {
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
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("asked_count"))));
    });

    test("Invalid update: wronglyAnsweredCount is greater than 65535", () {
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
          wronglyAnsweredCount: 65535 + 1);
      expect(() async {
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrongly_answered_count"))));
    });

    test("Invalid update: wronglyAnsweredCount is smaller than 0", () {
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
        await entrysDao.mutate(entry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException &&
              e.message.contains("wrongly_answered_count"))));
    });

    test("Good case 1", () async {
      const thisOrder = 10;
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: answerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: thisOrder,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: askedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      var mutated = await entrysDao.mutate(entry.toCompanion(true));
      expect(mutated, true);
      var gottenEntry = await entrysDao.getById(id);
      gottenEntry = gottenEntry!;
      expect(gottenEntry.id, id);
      expect(gottenEntry.fieldListId, fieldListId);
      expect(gottenEntry.answerId, answerId);
      expect(gottenEntry.questionId, questionId);
      expect(gottenEntry.creationAt, creationAt);
      expect(gottenEntry.lastModificationAt, lastModificationAt);
      expect(gottenEntry.order, thisOrder);
      expect(
          gottenEntry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(gottenEntry.emulatedCreatedAt, emulatedCreatedAt);
      expect(gottenEntry.rank, rank);
      expect(gottenEntry.askedCount, askedCount);
      expect(gottenEntry.wronglyAnsweredCount, wronglyAnsweredCount);
    });

    test("Good case 2", () async {
      const thisOrder = 10;
      var thisAnswerId = const Uuid().v4();
      const thisAskedCount = 1000;
      var entry = Entry(
          id: id,
          fieldListId: fieldListId,
          answerId: thisAnswerId,
          questionId: questionId,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          order: thisOrder,
          didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
          emulatedCreatedAt: emulatedCreatedAt,
          rank: rank,
          askedCount: thisAskedCount,
          wronglyAnsweredCount: wronglyAnsweredCount);
      var mutated = await entrysDao.mutate(entry.toCompanion(true));
      expect(mutated, true);
      var gottenEntry = await entrysDao.getById(id);
      gottenEntry = gottenEntry!;
      expect(gottenEntry.id, id);
      expect(gottenEntry.fieldListId, fieldListId);
      expect(gottenEntry.answerId, thisAnswerId);
      expect(gottenEntry.questionId, questionId);
      expect(gottenEntry.creationAt, creationAt);
      expect(gottenEntry.lastModificationAt, lastModificationAt);
      expect(gottenEntry.order, thisOrder);
      expect(
          gottenEntry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
      expect(gottenEntry.emulatedCreatedAt, emulatedCreatedAt);
      expect(gottenEntry.rank, rank);
      expect(gottenEntry.askedCount, thisAskedCount);
      expect(gottenEntry.wronglyAnsweredCount, wronglyAnsweredCount);
    });
  });

  test("Delete Entry", () async {
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
    await entrysDao.create(entry.toCompanion(true));
    await entrysDao.remove(entry.id);
    var gottenEntry = await entrysDao.getById(id);
    expect(gottenEntry, null);
  });
}
