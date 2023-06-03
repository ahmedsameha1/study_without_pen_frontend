import 'package:clock/clock.dart';
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
  String userAccountId = "j0kW7TZPcdZBHLsIUvJOFiAI8VN2";
  String name = "name";
  DateTime creationAt = DateTime(2020, 1, 1);
  DateTime lastModificationAt = DateTime.utc(2020, 2, 2);
  int usageCount = 9;

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fieldsDao = FieldsDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a Field", () {
    test("Invalid Field: id is an invalid UUID v4", () async {
      var field = Field(
          id: "wewen",
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount);
      expect(() async {
        await fieldsDao.create(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No Field with the same id", () async {
      var field1 = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount);
      var field2 = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount);
      expect(() async {
        await fieldsDao.create(field1.toCompanion(true));
        await fieldsDao.create(field2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid Field: userAccountId is an empty String", () {
      var field = Field(
          id: id,
          userAccountId: "",
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount);
      expect(() async {
        await fieldsDao.create(field.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("user_account_id"))));
      field = Field(
          id: id,
          userAccountId: " " * Fields.MINIMUM_LENGTH_OF_USER_ACCOUNT_ID,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount);
      expect(() async {
        await fieldsDao.create(field.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("user_account_id"))));
    });

    test(
        "Invalid Field: name length is less than ${Fields.MINIMUM_LENGTH_OF_NAME}",
        () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: "",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount);
      expect(() async {
        await fieldsDao.create(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
      field = Field(
          id: id,
          userAccountId: userAccountId,
          name: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount);
      expect(() async {
        await fieldsDao.create(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test(
        "Invalid Field: name length is bigger than ${Fields.MAXIMUM_LENGTH_OF_NAME}",
        () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: "s" * (Fields.MAXIMUM_LENGTH_OF_NAME + 1),
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount);
      expect(() async {
        await fieldsDao.create(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test("Invalid Field: creationAt is in the future", () async {
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () async {
        var field = Field(
            id: id,
            userAccountId: userAccountId,
            name: name,
            creationAt: DateTime(2020, 2, 2),
            lastModificationAt: lastModificationAt,
            usageCount: usageCount);
        expect(() async {
          await fieldsDao.create(field.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("Invalid Field: lastModificationAt is in the future", () async {
      withClock(Clock.fixed(DateTime(2020, 2, 2)), () async {
        var field = Field(
            id: id,
            userAccountId: userAccountId,
            name: name,
            creationAt: creationAt,
            lastModificationAt: DateTime(2020, 3, 3),
            usageCount: usageCount);
        expect(() async {
          await fieldsDao.create(field.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
      });
    });

    test("Invalid Field: lastModificationAt is before creationAt", () async {
      withClock(Clock.fixed(DateTime(2020, 2, 2)), () async {
        var field = Field(
            id: id,
            userAccountId: userAccountId,
            name: name,
            creationAt: creationAt,
            lastModificationAt: DateTime(2019, 3, 3),
            usageCount: usageCount);
        expect(() async {
          await fieldsDao.create(field.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test(
        "Invalid Field: usageCount is smaller than ${Fields.MINIMUM_USAGE_COUNT}",
        () async {
      withClock(Clock.fixed(DateTime(2021, 2, 2)), () async {
        var field = Field(
            id: id,
            userAccountId: userAccountId,
            name: name,
            creationAt: creationAt,
            lastModificationAt: lastModificationAt,
            usageCount: Fields.MINIMUM_USAGE_COUNT - 1);
        expect(() async {
          await fieldsDao.create(field.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException && e.message.contains("usage_count"))));
      });
    });

    test(
        "Invalid Field: usageCount is bigger than ${Fields.MAXIMUM_USAGE_COUNT}",
        () async {
      withClock(Clock.fixed(DateTime(2021, 2, 2)), () async {
        var field = Field(
            id: id,
            userAccountId: userAccountId,
            name: name,
            creationAt: creationAt,
            lastModificationAt: lastModificationAt,
            usageCount: Fields.MAXIMUM_USAGE_COUNT + 1);
        expect(() async {
          await fieldsDao.create(field.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException && e.message.contains("usage_count"))));
      });
    });

    test("Good case 1: create Field without 'id'", () async {
      var fieldCompanion = FieldsCompanion(
          userAccountId: Value(userAccountId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          usageCount: Value(usageCount));
      await fieldsDao.create(fieldCompanion);
    });

    test("Good case 2: create Field without usageCount", () async {
      var fieldCompanion = FieldsCompanion(
          id: Value(id),
          userAccountId: Value(userAccountId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await fieldsDao.create(fieldCompanion);
    });
  });
}
