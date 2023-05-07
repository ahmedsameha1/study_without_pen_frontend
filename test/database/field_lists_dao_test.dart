import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late FieldListsDao fieldListsDao;
  String id = const Uuid().v4();
  String fieldId = const Uuid().v4();
  String name = "fieldList1";
  DateTime creationAt = DateTime.utc(2020, 1, 1);
  DateTime lastModificationAt = DateTime.utc(2020, 2, 2);
  String languageTag = "en-US";

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fieldListsDao = FieldListsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Creat a FieldList", () {
    test("Invalid FieldList: id is an invalid UUID v4", () async {
      var fieldList = FieldList(
          id: "eewohow",
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No FieldList with the same id", () async {
      var fieldList1 = FieldList(
          id: id,
          fieldId: fieldId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag);
      var fieldList2 = FieldList(
          id: id,
          fieldId: const Uuid().v4(),
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag);
      await fieldListsDao.create(fieldList1.toCompanion(true));
      expect(() async {
        await fieldListsDao.create(fieldList2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid FieldList: fieldId is an invalid UUID v4", () async {
      var fieldList = FieldList(
          id: id,
          fieldId: "ewhw",
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldId"))));
    });

    test("Invalid FieldList: name length is less than 1", () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: "",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test(
        "Invalid FieldList: name length is less than ${FieldLists.MINIMUM_LENGTH_OF_NAME}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test(
        "Invalid FieldList: name length is bigger than ${FieldLists.MAXIMUM_LENGTH_OF_NAME}",
        () async {
      var fieldList = FieldList(
          id: id,
          fieldId: fieldId,
          name: "j" * 65,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          languageTag: languageTag);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test("Invalid FieldList: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2020, 1, 1)), () {
        var fieldList = FieldList(
            id: id,
            fieldId: fieldId,
            name: name,
            creationAt: DateTime.utc(2023, 1, 1),
            lastModificationAt: lastModificationAt,
            languageTag: languageTag);
        expect(() async {
          await fieldListsDao.create(fieldList.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException && e.message.contains("creation_at"))));
      });
    });

    test("Invalid FieldList: lastModificationAt is in the future", () {
      withClock(Clock.fixed(DateTime.utc(2021, 1, 1)), () {
        var fieldList = FieldList(
            id: id,
            fieldId: fieldId,
            name: name,
            creationAt: creationAt,
            lastModificationAt: DateTime.utc(2022, 1, 1),
            languageTag: languageTag);
        expect(() async {
          await fieldListsDao.create(fieldList.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Invalid FieldList: lastModificationAt is before creationAt", () {
      withClock(Clock.fixed(DateTime.utc(2021, 1, 1)), () {
        var fieldList = FieldList(
            id: id,
            fieldId: fieldId,
            name: name,
            creationAt: creationAt,
            lastModificationAt: DateTime.utc(2012, 1, 1),
            languageTag: languageTag);
        expect(() async {
          await fieldListsDao.create(fieldList.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Good case: create FieldList without 'id'", () async {
      var fieldListCompanion = FieldListsCompanion(
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          languageTag: Value(languageTag));
      await fieldListsDao.create(fieldListCompanion);
    });

    test("Good case2: create FieldList without languageTag", () async {
      var fieldListCompanion = FieldListsCompanion(
          id: Value(id),
          fieldId: Value(fieldId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await fieldListsDao.create(fieldListCompanion);
    });
  });
}
