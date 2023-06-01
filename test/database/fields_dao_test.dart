import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late FieldsDao fieldsDao;
  String id = const Uuid().v4();
  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fieldsDao = FieldsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a Field", () {
    test("Invalid Field: id is an invalid UUID v4", () async {
      var field = Field(id: "wewen");
      expect(() async {
        await fieldsDao.create(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No Field with the same id", () async {
      var field1 = Field(id: id);
      var field2 = Field(id: id);
      expect(() async {
        await fieldsDao.create(field1.toCompanion(true));
        await fieldsDao.create(field2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Good case 1: create Field without 'id'", () async {
      var fieldCompanion = FieldsCompanion();
      await fieldsDao.create(fieldCompanion);
    });
  });
}
