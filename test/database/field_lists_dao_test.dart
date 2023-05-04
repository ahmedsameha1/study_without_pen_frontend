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

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fieldListsDao = FieldListsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Creat a FieldList", () {
    test("Invalid FieldList: id is an invalid UUID v4", () async {
      var fieldList = FieldList(id: "eewohow", fieldId: fieldId, name: name);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No FieldList with the same id", () async {
      var fieldList1 = FieldList(id: id, fieldId: fieldId, name: name);
      var fieldList2 =
          FieldList(id: id, fieldId: const Uuid().v4(), name: name);
      await fieldListsDao.create(fieldList1.toCompanion(true));
      expect(() async {
        await fieldListsDao.create(fieldList2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid FieldList: fieldId is an invalid UUID v4", () async {
      var fieldList = FieldList(id: id, fieldId: "ewhw", name: name);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldId"))));
    });

    test("Invalid FieldList: name length is less than 1", () async {
      var fieldList = FieldList(id: id, fieldId: fieldId, name: "");
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test(
        "Invalid FieldList: name length is less than ${FieldLists.MINIMUM_LENGTH_OF_NAME}",
        () async {
      var fieldList = FieldList(id: id, fieldId: fieldId, name: " ");
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test(
        "Invalid FieldList: name length is bigger than ${FieldLists.MAXIMUM_LENGTH_OF_NAME}",
        () async {
      var fieldList = FieldList(id: id, fieldId: fieldId, name: "j" * 65);
      expect(() async {
        await fieldListsDao.create(fieldList.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test("Good case: create FieldList without 'id'", () async {
      var fieldListCompanion =
          FieldListsCompanion(fieldId: Value(fieldId), name: Value(name));
      await fieldListsDao.create(fieldListCompanion);
    });
  });
}
