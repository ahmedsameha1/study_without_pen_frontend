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
  int color = 0xff55ee11;

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
          usageCount: usageCount,
          color: color);
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
          usageCount: usageCount,
          color: color);
      var field2 = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: color);
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
          usageCount: usageCount,
          color: color);
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
          usageCount: usageCount,
          color: color);
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
          usageCount: usageCount,
          color: color);
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
          usageCount: usageCount,
          color: color);
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
          usageCount: usageCount,
          color: color);
      expect(() async {
        await fieldsDao.create(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test("Invalid Field: userAccountId & name aren't unique", () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: color);
      var field2 = Field(
          id: const Uuid().v4(),
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: color);
      await fieldsDao.create(field.toCompanion(true));
      expect(() async {
        await fieldsDao.create(field2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("UNIQUE"))));
    });

    test("Invalid Field: creationAt is in the future", () async {
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () async {
        var field = Field(
            id: id,
            userAccountId: userAccountId,
            name: name,
            creationAt: DateTime(2020, 2, 2),
            lastModificationAt: lastModificationAt,
            usageCount: usageCount,
            color: color);
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
            usageCount: usageCount,
            color: color);
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
            usageCount: usageCount,
            color: color);
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
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: Fields.MINIMUM_USAGE_COUNT - 1,
          color: color);
      expect(() async {
        await fieldsDao.create(field.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("usage_count"))));
    });

    test(
        "Invalid Field: usageCount is bigger than ${Fields.MAXIMUM_USAGE_COUNT}",
        () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: Fields.MAXIMUM_USAGE_COUNT + 1,
          color: color);
      expect(() async {
        await fieldsDao.create(field.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("usage_count"))));
    });

    test("Invalid Field: color is smaller than ${Fields.MINIMUM_COLOR}",
        () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: Fields.MINIMUM_COLOR - 1);
      expect(() async {
        await fieldsDao.create(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("color"))));
    });

    test("Invalid Field: color is bigger than ${Fields.MAXIMUM_COLOR}",
        () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: Fields.MAXIMUM_COLOR + 1);
      expect(() async {
        await fieldsDao.create(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("color"))));
    });

    test("Good case 1: create Field without 'id'", () async {
      var fieldCompanion = FieldsCompanion(
          userAccountId: Value(userAccountId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          usageCount: Value(usageCount),
          color: Value(color));
      await fieldsDao.create(fieldCompanion);
    });

    test("Good case 2: create Field without usageCount", () async {
      var fieldCompanion = FieldsCompanion(
          id: Value(id),
          userAccountId: Value(userAccountId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          color: Value(color));
      await fieldsDao.create(fieldCompanion);
    });

    test("Good case 3: create Field without color", () async {
      var fieldCompanion = FieldsCompanion(
          id: Value(id),
          userAccountId: Value(userAccountId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt),
          usageCount: Value(usageCount));
      await fieldsDao.create(fieldCompanion);
    });
  });

  group("Geting a specific Field by id", () {
    test("Good case: this specific field is found", () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: color);
      await fieldsDao.create(field.toCompanion(true));
      Field? gottenField = await fieldsDao.watchById(id).first;
      gottenField = gottenField!;
      expect(gottenField.id, id);
      expect(gottenField.userAccountId, userAccountId);
      expect(gottenField.name, name);
      expect(gottenField.creationAt, creationAt);
      expect(gottenField.lastModificationAt, lastModificationAt);
      expect(gottenField.usageCount, usageCount);
      expect(gottenField.color, color);
    });

    test("Good case: this specific field is not found", () async {
      Field? gottenField = await fieldsDao.watchById(const Uuid().v4()).first;
      expect(gottenField, null);
    });

    test("Test default values", () async {
      var fieldCompanion = FieldsCompanion(
          id: Value(id),
          userAccountId: Value(userAccountId),
          name: Value(name),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await fieldsDao.create(fieldCompanion);
      Field? gottenField = await fieldsDao.watchById(id).first;
      gottenField = gottenField!;
      expect(gottenField.usageCount, Fields.DEFAULT_USAGE_COUNT);
      expect(gottenField.color, Fields.DEFAULT_COLOR);
    });
  });

  test("getting all Fields for a specific user account id", () async {
    var userAccountId1 = const Uuid().v4();
    var userAccountId2 = const Uuid().v4();
    var userAccountId3 = const Uuid().v4();
    var fieldId1 = const Uuid().v4();
    var fieldId2 = const Uuid().v4();
    var fieldId3 = const Uuid().v4();
    var fieldId4 = const Uuid().v4();
    var fieldId5 = const Uuid().v4();
    var fieldId6 = const Uuid().v4();
    var name1 = "name1";
    var name2 = "name2";
    var name3 = "name3";
    var name4 = "name4";
    var name5 = "name5";
    var name6 = "name6";
    DateTime creationAt1 = DateTime.utc(2020, 1, 1);
    DateTime creationAt2 = DateTime.utc(2020, 1, 2);
    DateTime creationAt3 = DateTime.utc(2020, 2, 1);
    DateTime creationAt4 = DateTime.utc(2020, 2, 2);
    DateTime creationAt5 = DateTime.utc(2020, 3, 1);
    DateTime creationAt6 = DateTime.utc(2020, 3, 2);
    DateTime lastModificationAt1 = DateTime.utc(2021, 1, 1);
    DateTime lastModificationAt2 = DateTime.utc(2021, 1, 2);
    DateTime lastModificationAt3 = DateTime.utc(2021, 2, 1);
    DateTime lastModificationAt4 = DateTime.utc(2021, 2, 2);
    DateTime lastModificationAt5 = DateTime.utc(2021, 3, 1);
    DateTime lastModificationAt6 = DateTime.utc(2021, 3, 2);
    int usageCount1 = 20;
    int usageCount2 = 30;
    int usageCount3 = 40;
    int usageCount4 = 50;
    int usageCount5 = 60;
    int usageCount6 = 70;
    int color1 = 0x55554433;
    int color2 = 0x55664433;
    int color3 = 0x55774433;
    int color4 = 0x55884433;
    int color5 = 0x55994433;
    int color6 = 0x55aa4433;
    var field1 = Field(
        id: fieldId1,
        userAccountId: userAccountId1,
        name: name1,
        creationAt: creationAt1,
        lastModificationAt: lastModificationAt1,
        usageCount: usageCount1,
        color: color1);
    var field2 = Field(
        id: fieldId2,
        userAccountId: userAccountId2,
        name: name2,
        creationAt: creationAt2,
        lastModificationAt: lastModificationAt2,
        usageCount: usageCount2,
        color: color2);
    var field3 = Field(
        id: fieldId3,
        userAccountId: userAccountId3,
        name: name3,
        creationAt: creationAt3,
        lastModificationAt: lastModificationAt3,
        usageCount: usageCount3,
        color: color3);
    var field4 = Field(
        id: fieldId4,
        userAccountId: userAccountId1,
        name: name4,
        creationAt: creationAt4,
        lastModificationAt: lastModificationAt4,
        usageCount: usageCount4,
        color: color4);
    var field5 = Field(
        id: fieldId5,
        userAccountId: userAccountId2,
        name: name5,
        creationAt: creationAt5,
        lastModificationAt: lastModificationAt5,
        usageCount: usageCount5,
        color: color5);
    var field6 = Field(
        id: fieldId6,
        userAccountId: userAccountId1,
        name: name6,
        creationAt: creationAt6,
        lastModificationAt: lastModificationAt6,
        usageCount: usageCount6,
        color: color6);
    await fieldsDao.create(field1.toCompanion(true));
    await fieldsDao.create(field2.toCompanion(true));
    await fieldsDao.create(field3.toCompanion(true));
    await fieldsDao.create(field4.toCompanion(true));
    await fieldsDao.create(field5.toCompanion(true));
    await fieldsDao.create(field6.toCompanion(true));
    Stream<List<Field>> fieldsStream =
        fieldsDao.watchByUserAccountId(userAccountId1);
    List<Field> fields = await fieldsStream.first;
    expect(fields.length, 3);
    var gottenField = fields[0];
    expect(gottenField.id, fieldId6);
    expect(gottenField.userAccountId, userAccountId1);
    expect(gottenField.name, name6);
    expect(gottenField.creationAt, creationAt6);
    expect(gottenField.lastModificationAt, lastModificationAt6);
    expect(gottenField.usageCount, usageCount6);
    expect(gottenField.color, color6);
    gottenField = fields[1];
    expect(gottenField.id, fieldId4);
    expect(gottenField.userAccountId, userAccountId1);
    expect(gottenField.name, name4);
    expect(gottenField.creationAt, creationAt4);
    expect(gottenField.lastModificationAt, lastModificationAt4);
    expect(gottenField.usageCount, usageCount4);
    expect(gottenField.color, color4);
    gottenField = fields[2];
    expect(gottenField.id, fieldId1);
    expect(gottenField.userAccountId, userAccountId1);
    expect(gottenField.name, name1);
    expect(gottenField.creationAt, creationAt1);
    expect(gottenField.lastModificationAt, lastModificationAt1);
    expect(gottenField.usageCount, usageCount1);
    expect(gottenField.color, color1);
    fieldsStream = fieldsDao.watchByUserAccountId(userAccountId2);
    fields = await fieldsStream.first;
    expect(fields.length, 2);
    gottenField = fields[0];
    expect(gottenField.id, fieldId5);
    expect(gottenField.userAccountId, userAccountId2);
    expect(gottenField.name, name5);
    expect(gottenField.creationAt, creationAt5);
    expect(gottenField.lastModificationAt, lastModificationAt5);
    expect(gottenField.usageCount, usageCount5);
    expect(gottenField.color, color5);
    gottenField = fields[1];
    expect(gottenField.id, fieldId2);
    expect(gottenField.userAccountId, userAccountId2);
    expect(gottenField.name, name2);
    expect(gottenField.creationAt, creationAt2);
    expect(gottenField.lastModificationAt, lastModificationAt2);
    expect(gottenField.usageCount, usageCount2);
    expect(gottenField.color, color2);
    fieldsStream = fieldsDao.watchByUserAccountId(userAccountId3);
    fields = await fieldsStream.first;
    expect(fields.length, 1);
    gottenField = fields[0];
    expect(gottenField.id, fieldId3);
    expect(gottenField.userAccountId, userAccountId3);
    expect(gottenField.name, name3);
    expect(gottenField.creationAt, creationAt3);
    expect(gottenField.lastModificationAt, lastModificationAt3);
    expect(gottenField.usageCount, usageCount3);
    expect(gottenField.color, color3);
  });

  group("Update Field", () {
    setUp(() async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: color);
      await fieldsDao.create(field.toCompanion(true));
    });

    test(
        "Invalid update: name length is less than ${Fields.MINIMUM_LENGTH_OF_NAME}",
        () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: "",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: color);
      expect(() async {
        await fieldsDao.mutate(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
      field = Field(
          id: id,
          userAccountId: userAccountId,
          name: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: color);
      expect(() async {
        await fieldsDao.mutate(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test(
        "Invalid update: name length is bigger than ${Fields.MAXIMUM_LENGTH_OF_NAME}",
        () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: "s" * (Fields.MAXIMUM_LENGTH_OF_NAME + 1),
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: color);
      expect(() async {
        await fieldsDao.mutate(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("name"))));
    });

    test("Invalid update: creationAt is in the future", () async {
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () async {
        var field = Field(
            id: id,
            userAccountId: userAccountId,
            name: name,
            creationAt: DateTime(2020, 2, 2),
            lastModificationAt: lastModificationAt,
            usageCount: usageCount,
            color: color);
        expect(() async {
          await fieldsDao.mutate(field.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("Invalid update: lastModificationAt is in the future", () async {
      withClock(Clock.fixed(DateTime(2020, 2, 2)), () async {
        var field = Field(
            id: id,
            userAccountId: userAccountId,
            name: name,
            creationAt: creationAt,
            lastModificationAt: DateTime(2020, 3, 3),
            usageCount: usageCount,
            color: color);
        expect(() async {
          await fieldsDao.mutate(field.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
      });
    });

    test("Invalid update: lastModificationAt is before creationAt", () async {
      withClock(Clock.fixed(DateTime(2020, 2, 2)), () async {
        var field = Field(
            id: id,
            userAccountId: userAccountId,
            name: name,
            creationAt: creationAt,
            lastModificationAt: DateTime(2019, 3, 3),
            usageCount: usageCount,
            color: color);
        expect(() async {
          await fieldsDao.mutate(field.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test(
        "Invalid update: usageCount is smaller than ${Fields.MINIMUM_USAGE_COUNT}",
        () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: Fields.MINIMUM_USAGE_COUNT - 1,
          color: color);
      expect(() async {
        await fieldsDao.mutate(field.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("usage_count"))));
    });

    test(
        "Invalid update: usageCount is bigger than ${Fields.MAXIMUM_USAGE_COUNT}",
        () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: Fields.MAXIMUM_USAGE_COUNT + 1,
          color: color);
      expect(() async {
        await fieldsDao.mutate(field.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("usage_count"))));
    });

    test("Invalid update: color is smaller than ${Fields.MINIMUM_COLOR}",
        () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: Fields.MINIMUM_COLOR - 1);
      expect(() async {
        await fieldsDao.mutate(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("color"))));
    });

    test("Invalid update: color is bigger than ${Fields.MAXIMUM_COLOR}",
        () async {
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: Fields.MAXIMUM_COLOR + 1);
      expect(() async {
        await fieldsDao.mutate(field.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("color"))));
    });

    test("Invalid update: trying to update userAccountId", () async {
      final newUserAccoutId = const Uuid().v4();
      var field = Field(
          id: id,
          userAccountId: newUserAccoutId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: color);
      expect(() async {
        await fieldsDao.mutate(field.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("Updating userAccountId"))));
    });

    test("Good case 1", () async {
      var newColor = 0x34567891;
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: newColor);
      await fieldsDao.mutate(field.toCompanion(true));
      var gottenField = await fieldsDao.watchById(id).first;
      gottenField = gottenField!;
      expect(gottenField.id, id);
      expect(gottenField.userAccountId, userAccountId);
      expect(gottenField.name, name);
      expect(gottenField.creationAt, creationAt);
      expect(gottenField.lastModificationAt, lastModificationAt);
      expect(gottenField.usageCount, usageCount);
      expect(gottenField.color, newColor);
    });

    test("Good case 2", () async {
      var newName = "newName";
      var newUsageCount = 69;
      var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: newName,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: newUsageCount,
          color: color);
      await fieldsDao.mutate(field.toCompanion(true));
      var gottenField = await fieldsDao.watchById(id).first;
      gottenField = gottenField!;
      expect(gottenField.id, id);
      expect(gottenField.userAccountId, userAccountId);
      expect(gottenField.name, newName);
      expect(gottenField.creationAt, creationAt);
      expect(gottenField.lastModificationAt, lastModificationAt);
      expect(gottenField.usageCount, newUsageCount);
      expect(gottenField.color, color);
    });
  });

  test("Delete some Field", () async {
    var field = Field(
        id: id,
        userAccountId: userAccountId,
        name: name,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        usageCount: usageCount,
        color: color);
    await fieldsDao.create(field.toCompanion(true));
    await fieldsDao.remove(id);
    var gottenField = await fieldsDao.watchById(id).first;
    expect(gottenField, null);
  });
}
