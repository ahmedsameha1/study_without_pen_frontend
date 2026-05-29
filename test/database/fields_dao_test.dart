import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
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
        color: color,
      );
      expect(
        () async {
          await fieldsDao.create(field.toCompanion(true));
        },
        throwsA(
          predicate(
            (e) => e is InvalidDataException && e.message.contains("id"),
          ),
        ),
      );
    });

    test("No Field with the same id", () async {
      var field1 = Field(
        id: id,
        userAccountId: userAccountId,
        name: name,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        usageCount: usageCount,
        color: color,
      );
      var field2 = Field(
        id: id,
        userAccountId: userAccountId,
        name: name,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        usageCount: usageCount,
        color: color,
      );
      expect(
        () async {
          await fieldsDao.create(field1.toCompanion(true));
          await fieldsDao.create(field2.toCompanion(true));
        },
        throwsA(
          predicate((e) => e is SqliteException && e.message.contains("id")),
        ),
      );
    });

    test("Invalid Field: userAccountId is an empty String", () {
      var field = Field(
        id: id,
        userAccountId: "",
        name: name,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        usageCount: usageCount,
        color: color,
      );
      expect(
        () async {
          await fieldsDao.create(field.toCompanion(true));
        },
        throwsA(
          predicate(
            (e) =>
                e is SqliteException && e.message.contains("user_account_id"),
          ),
        ),
      );
      field = Field(
        id: id,
        userAccountId: " " * Fields.MINIMUM_LENGTH_OF_USER_ACCOUNT_ID,
        name: name,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        usageCount: usageCount,
        color: color,
      );
      expect(
        () async {
          await fieldsDao.create(field.toCompanion(true));
        },
        throwsA(
          predicate(
            (e) =>
                e is SqliteException && e.message.contains("user_account_id"),
          ),
        ),
      );
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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.create(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("name"),
            ),
          ),
        );
        field = Field(
          id: id,
          userAccountId: userAccountId,
          name: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: color,
        );
        expect(
          () async {
            await fieldsDao.create(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("name"),
            ),
          ),
        );
      },
    );

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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.create(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("name"),
            ),
          ),
        );
      },
    );

    test("Invalid Field: userAccountId & name aren't unique", () async {
      var field = Field(
        id: id,
        userAccountId: userAccountId,
        name: name,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        usageCount: usageCount,
        color: color,
      );
      var field2 = Field(
        id: const Uuid().v4(),
        userAccountId: userAccountId,
        name: name,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        usageCount: usageCount,
        color: color,
      );
      await fieldsDao.create(field.toCompanion(true));
      expect(
        () async {
          await fieldsDao.create(field2.toCompanion(true));
        },
        throwsA(
          predicate(
            (e) => e is SqliteException && e.message.contains("UNIQUE"),
          ),
        ),
      );
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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.create(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) =>
                  e is InvalidDataException && e.message.contains("creationAt"),
            ),
          ),
        );
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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.create(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) =>
                  e is InvalidDataException &&
                  e.message.contains("lastModificationAt"),
            ),
          ),
        );
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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.create(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) =>
                  e is SqliteException &&
                  e.message.contains("last_modification_at"),
            ),
          ),
        );
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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.create(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("usage_count"),
            ),
          ),
        );
      },
    );

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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.create(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("usage_count"),
            ),
          ),
        );
      },
    );

    test(
      "Invalid Field: color is smaller than ${Fields.MINIMUM_COLOR}",
      () async {
        var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: Fields.MINIMUM_COLOR - 1,
        );
        expect(
          () async {
            await fieldsDao.create(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("color"),
            ),
          ),
        );
      },
    );

    test(
      "Invalid Field: color is bigger than ${Fields.MAXIMUM_COLOR}",
      () async {
        var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: Fields.MAXIMUM_COLOR + 1,
        );
        expect(
          () async {
            await fieldsDao.create(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("color"),
            ),
          ),
        );
      },
    );

    test("Good case 1: create Field without 'id'", () async {
      var fieldCompanion = FieldsCompanion(
        userAccountId: Value(userAccountId),
        name: Value(name),
        creationAt: Value(creationAt),
        lastModificationAt: Value(lastModificationAt),
        usageCount: Value(usageCount),
        color: Value(color),
      );
      await fieldsDao.create(fieldCompanion);
    });

    test("Good case 2: create Field without usageCount", () async {
      var fieldCompanion = FieldsCompanion(
        id: Value(id),
        userAccountId: Value(userAccountId),
        name: Value(name),
        creationAt: Value(creationAt),
        lastModificationAt: Value(lastModificationAt),
        color: Value(color),
      );
      await fieldsDao.create(fieldCompanion);
    });

    test("Good case 3: create Field without color", () async {
      var fieldCompanion = FieldsCompanion(
        id: Value(id),
        userAccountId: Value(userAccountId),
        name: Value(name),
        creationAt: Value(creationAt),
        lastModificationAt: Value(lastModificationAt),
        usageCount: Value(usageCount),
      );
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
        color: color,
      );
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
        lastModificationAt: Value(lastModificationAt),
      );
      await fieldsDao.create(fieldCompanion);
      Field? gottenField = await fieldsDao.watchById(id).first;
      gottenField = gottenField!;
      expect(gottenField.usageCount, Fields.DEFAULT_USAGE_COUNT);
      expect(gottenField.color, Fields.DEFAULT_COLOR);
    });
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
        color: color,
      );
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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.mutate(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("name"),
            ),
          ),
        );
        field = Field(
          id: id,
          userAccountId: userAccountId,
          name: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: color,
        );
        expect(
          () async {
            await fieldsDao.mutate(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("name"),
            ),
          ),
        );
      },
    );

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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.mutate(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("name"),
            ),
          ),
        );
      },
    );

    test("Invalid update: creationAt is in the future", () async {
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () async {
        var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: DateTime(2020, 2, 2),
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: color,
        );
        expect(
          () async {
            await fieldsDao.mutate(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) =>
                  e is InvalidDataException && e.message.contains("creationAt"),
            ),
          ),
        );
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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.mutate(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) =>
                  e is InvalidDataException &&
                  e.message.contains("lastModificationAt"),
            ),
          ),
        );
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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.mutate(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) =>
                  e is SqliteException &&
                  e.message.contains("last_modification_at"),
            ),
          ),
        );
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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.mutate(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("usage_count"),
            ),
          ),
        );
      },
    );

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
          color: color,
        );
        expect(
          () async {
            await fieldsDao.mutate(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("usage_count"),
            ),
          ),
        );
      },
    );

    test(
      "Invalid update: color is smaller than ${Fields.MINIMUM_COLOR}",
      () async {
        var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: Fields.MINIMUM_COLOR - 1,
        );
        expect(
          () async {
            await fieldsDao.mutate(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("color"),
            ),
          ),
        );
      },
    );

    test(
      "Invalid update: color is bigger than ${Fields.MAXIMUM_COLOR}",
      () async {
        var field = Field(
          id: id,
          userAccountId: userAccountId,
          name: name,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          usageCount: usageCount,
          color: Fields.MAXIMUM_COLOR + 1,
        );
        expect(
          () async {
            await fieldsDao.mutate(field.toCompanion(true));
          },
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message.contains("color"),
            ),
          ),
        );
      },
    );

    test("Invalid update: trying to update userAccountId", () async {
      final newUserAccoutId = const Uuid().v4();
      var field = Field(
        id: id,
        userAccountId: newUserAccoutId,
        name: name,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        usageCount: usageCount,
        color: color,
      );
      expect(
        () async {
          await fieldsDao.mutate(field.toCompanion(true));
        },
        throwsA(
          predicate(
            (e) =>
                e is InvalidDataException &&
                e.message.contains("Updating userAccountId"),
          ),
        ),
      );
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
        color: newColor,
      );
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
        color: color,
      );
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
      color: color,
    );
    await fieldsDao.create(field.toCompanion(true));
    await fieldsDao.remove(id);
    var gottenField = await fieldsDao.watchById(id).first;
    expect(gottenField, null);
  });

  test('giveUserTheUserlessData()', () async {
    final anotherUserAccountId = const Uuid().v4();
    final field1 = Field(
      id: id,
      userAccountId: userAccountId,
      name: name,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      usageCount: usageCount,
      color: color,
    );
    await fieldsDao.create(field1.toCompanion(true));
    final field2 = Field(
      id: const Uuid().v4(),
      userAccountId: migrationUserAccountId,
      name: '${name}2',
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      usageCount: usageCount,
      color: color,
    );
    await fieldsDao.create(field2.toCompanion(true));
    await fieldsDao.giveUserTheUserlessData(anotherUserAccountId);
    expect(
      await fieldsDao
          .watchWithFieldListsCountByUserAccountId(migrationUserAccountId)
          .first,
      isEmpty,
    );
    expect(
      await fieldsDao
          .watchWithFieldListsCountByUserAccountId(userAccountId)
          .first,
      [(field1, 0)],
    );
    expect(
      await fieldsDao
          .watchWithFieldListsCountByUserAccountId(anotherUserAccountId)
          .first,
      [(field2.copyWith(userAccountId: anotherUserAccountId), 0)],
    );
  });

  test('watchWithFieldListsCountByUserAccountId()', () async {
    final fieldListsDao = FieldListsDao(appDatabase);
    final userAccountId2 = const Uuid().v4();
    var fieldId = const Uuid().v4();
    var fieldId2 = const Uuid().v4();
    var fieldId3 = const Uuid().v4();
    var fieldListId1 = const Uuid().v4();
    var fieldListId2 = const Uuid().v4();
    var fieldListId3 = const Uuid().v4();
    var fieldListId4 = const Uuid().v4();
    var fieldListId5 = const Uuid().v4();
    var fieldListId6 = const Uuid().v4();
    String name1 = "fieldList1";
    String name2 = "fieldList2";
    String name3 = "fieldList3";
    String name4 = "fieldList4";
    String name5 = "fieldList5";
    String name6 = "fieldList6";
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
    String languageTag1 = "es";
    String languageTag2 = "en-US";
    String languageTag3 = "fr";
    String languageTag4 = "de";
    String languageTag5 = "it";
    String languageTag6 = "pt";
    int checkType1 = CheckType.NON_STRICT_IGNORE_CASE.index;
    int checkType2 = CheckType.NON_STRICT_DO_NOT_IGNORE_CASE.index;
    int checkType3 = CheckType.DO_NOT_IGNORE_CASE.index;
    int checkType4 = CheckType.IGNORE_CASE.index;
    int checkType5 = CheckType.NON_STRICT_IGNORE_CASE.index;
    int checkType6 = CheckType.NON_STRICT_DO_NOT_IGNORE_CASE.index;
    int sortBy1 = SortBy.CREATION_DATE_DESC.index;
    int sortBy2 = SortBy.ANSWER_ASC.index;
    int sortBy3 = SortBy.ANSWER_DESC.index;
    int sortBy4 = SortBy.ORDER_ASC.index;
    int sortBy5 = SortBy.ORDER_DESC.index;
    int sortBy6 = SortBy.QUESTION_ASC.index;
    bool doesReadAnswer1 = true;
    bool doesReadAnswer2 = true;
    bool doesReadAnswer3 = true;
    bool doesReadAnswer4 = false;
    bool doesReadAnswer5 = false;
    bool doesReadAnswer6 = false;
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
    int emulationNumberOfQuestions1 = 0;
    int emulationNumberOfQuestions2 = 1;
    int emulationNumberOfQuestions3 = 2;
    int emulationNumberOfQuestions4 = 3;
    int emulationNumberOfQuestions5 = 5;
    int emulationNumberOfQuestions6 = 6;
    String emulationDays1 = "01234";
    String emulationDays2 = "0134";
    String emulationDays3 = "0124";
    String emulationDays4 = "12345";
    String emulationDays5 = "01236";
    String emulationDays6 = "01245";
    int testsReadingQuestionLetterDuration1 = 200;
    int testsReadingQuestionLetterDuration2 = 300;
    int testsReadingQuestionLetterDuration3 = 500;
    int testsReadingQuestionLetterDuration4 = 600;
    int testsReadingQuestionLetterDuration5 = 700;
    int testsReadingQuestionLetterDuration6 = 800;
    int testsFindingAnswerDuration1 = 1000;
    int testsFindingAnswerDuration2 = 1100;
    int testsFindingAnswerDuration3 = 1200;
    int testsFindingAnswerDuration4 = 1300;
    int testsFindingAnswerDuration5 = 900;
    int testsFindingAnswerDuration6 = 800;
    int testsTypingAnswerLetterDuration1 = 100;
    int testsTypingAnswerLetterDuration2 = 200;
    int testsTypingAnswerLetterDuration3 = 300;
    int testsTypingAnswerLetterDuration4 = 400;
    int testsTypingAnswerLetterDuration5 = 600;
    int testsTypingAnswerLetterDuration6 = 700;
    int studyTillCorrectReadingQuestionLetterDuration1 = 200;
    int studyTillCorrectReadingQuestionLetterDuration2 = 300;
    int studyTillCorrectReadingQuestionLetterDuration3 = 400;
    int studyTillCorrectReadingQuestionLetterDuration4 = 500;
    int studyTillCorrectReadingQuestionLetterDuration5 = 600;
    int studyTillCorrectReadingQuestionLetterDuration6 = 700;
    int studyTillCorrectFindingAnswerDuration1 = 1000;
    int studyTillCorrectFindingAnswerDuration2 = 1100;
    int studyTillCorrectFindingAnswerDuration3 = 1200;
    int studyTillCorrectFindingAnswerDuration4 = 1300;
    int studyTillCorrectFindingAnswerDuration5 = 1400;
    int studyTillCorrectFindingAnswerDuration6 = 1500;
    int studyTillCorrectTypingAnswerLetterDuration1 = 100;
    int studyTillCorrectTypingAnswerLetterDuration2 = 200;
    int studyTillCorrectTypingAnswerLetterDuration3 = 300;
    int studyTillCorrectTypingAnswerLetterDuration4 = 400;
    int studyTillCorrectTypingAnswerLetterDuration5 = 500;
    int studyTillCorrectTypingAnswerLetterDuration6 = 600;
    int testsTimeOfAnswerAction1 = TimeOfAnswerAction.NEXT.index;
    int testsTimeOfAnswerAction2 = TimeOfAnswerAction.NEXT.index;
    int testsTimeOfAnswerAction3 = TimeOfAnswerAction.NEXT.index;
    int testsTimeOfAnswerAction4 = TimeOfAnswerAction.NOTIFY.index;
    int testsTimeOfAnswerAction5 = TimeOfAnswerAction.NOTIFY.index;
    int testsTimeOfAnswerAction6 = TimeOfAnswerAction.NOTIFY.index;
    bool doesObfuscateQuestion1 = true;
    bool doesObfuscateQuestion2 = true;
    bool doesObfuscateQuestion3 = true;
    bool doesObfuscateQuestion4 = false;
    bool doesObfuscateQuestion5 = false;
    bool doesObfuscateQuestion6 = false;
    final field1 = Field(
      id: fieldId,
      userAccountId: userAccountId,
      name: name1,
      creationAt: creationAt1,
      lastModificationAt: lastModificationAt1,
      usageCount: usageCount1 + 3,
      color: color1,
    );
    await fieldsDao.create(field1.toCompanion(true));
    final field2 = Field(
      id: fieldId2,
      userAccountId: userAccountId,
      name: name1 + "2",
      creationAt: creationAt1,
      lastModificationAt: lastModificationAt1,
      usageCount: usageCount1 + 2,
      color: color1,
    );
    await fieldsDao.create(field2.toCompanion(true));
    final field3 = Field(
      id: fieldId3,
      userAccountId: userAccountId,
      name: name1 + "3",
      creationAt: creationAt1,
      lastModificationAt: lastModificationAt1,
      usageCount: usageCount1 + 1,
      color: color1,
    );
    await fieldsDao.create(field3.toCompanion(true));
    final field4 = Field(
      id: const Uuid().v4(),
      userAccountId: userAccountId,
      name: name1 + "4",
      creationAt: creationAt1,
      lastModificationAt: lastModificationAt1,
      usageCount: usageCount1,
      color: color1,
    );
    await fieldsDao.create(field4.toCompanion(true));
    final field5 = Field(
      id: const Uuid().v4(),
      userAccountId: userAccountId2,
      name: name1 + "5",
      creationAt: creationAt1,
      lastModificationAt: lastModificationAt1,
      usageCount: usageCount1,
      color: color1,
    );
    await fieldsDao.create(field5.toCompanion(true));
    var fieldList1 = FieldList(
      id: fieldListId1,
      fieldId: fieldId,
      name: name1,
      creationAt: creationAt1,
      lastModificationAt: lastModificationAt1,
      languageTag: languageTag1,
      checkType: checkType1,
      sortBy: sortBy1,
      doesReadAnswer: doesReadAnswer1,
      usageCount: usageCount1,
      color: color1,
      emulationNumberOfQuestions: emulationNumberOfQuestions1,
      emulationDays: emulationDays1,
      testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration1,
      testsFindingAnswerDuration: testsFindingAnswerDuration1,
      testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration1,
      studyTillCorrectReadingQuestionLetterDuration:
          studyTillCorrectReadingQuestionLetterDuration1,
      studyTillCorrectFindingAnswerDuration:
          studyTillCorrectFindingAnswerDuration1,
      studyTillCorrectTypingAnswerLetterDuration:
          studyTillCorrectTypingAnswerLetterDuration1,
      testsTimeOfAnswerAction: testsTimeOfAnswerAction1,
      doesObfuscateQuestion: doesObfuscateQuestion1,
    );
    var fieldList2 = FieldList(
      id: fieldListId2,
      fieldId: fieldId2,
      name: name2,
      creationAt: creationAt2,
      lastModificationAt: lastModificationAt2,
      languageTag: languageTag2,
      checkType: checkType2,
      sortBy: sortBy2,
      doesReadAnswer: doesReadAnswer2,
      usageCount: usageCount2,
      color: color2,
      emulationNumberOfQuestions: emulationNumberOfQuestions2,
      emulationDays: emulationDays2,
      testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration2,
      testsFindingAnswerDuration: testsFindingAnswerDuration2,
      testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration2,
      studyTillCorrectReadingQuestionLetterDuration:
          studyTillCorrectReadingQuestionLetterDuration2,
      studyTillCorrectFindingAnswerDuration:
          studyTillCorrectFindingAnswerDuration2,
      studyTillCorrectTypingAnswerLetterDuration:
          studyTillCorrectTypingAnswerLetterDuration2,
      testsTimeOfAnswerAction: testsTimeOfAnswerAction2,
      doesObfuscateQuestion: doesObfuscateQuestion2,
    );
    var fieldList3 = FieldList(
      id: fieldListId3,
      fieldId: fieldId3,
      name: name3,
      creationAt: creationAt3,
      lastModificationAt: lastModificationAt3,
      languageTag: languageTag3,
      checkType: checkType3,
      sortBy: sortBy3,
      doesReadAnswer: doesReadAnswer3,
      usageCount: usageCount3,
      color: color3,
      emulationNumberOfQuestions: emulationNumberOfQuestions3,
      emulationDays: emulationDays3,
      testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration3,
      testsFindingAnswerDuration: testsFindingAnswerDuration3,
      testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration3,
      studyTillCorrectReadingQuestionLetterDuration:
          studyTillCorrectReadingQuestionLetterDuration3,
      studyTillCorrectFindingAnswerDuration:
          studyTillCorrectFindingAnswerDuration3,
      studyTillCorrectTypingAnswerLetterDuration:
          studyTillCorrectTypingAnswerLetterDuration3,
      testsTimeOfAnswerAction: testsTimeOfAnswerAction3,
      doesObfuscateQuestion: doesObfuscateQuestion3,
    );
    var fieldList4 = FieldList(
      id: fieldListId4,
      fieldId: fieldId,
      name: name4,
      creationAt: creationAt4,
      lastModificationAt: lastModificationAt4,
      languageTag: languageTag4,
      checkType: checkType4,
      sortBy: sortBy4,
      doesReadAnswer: doesReadAnswer4,
      usageCount: usageCount4,
      color: color4,
      emulationNumberOfQuestions: emulationNumberOfQuestions4,
      emulationDays: emulationDays4,
      testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration4,
      testsFindingAnswerDuration: testsFindingAnswerDuration4,
      testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration4,
      studyTillCorrectReadingQuestionLetterDuration:
          studyTillCorrectReadingQuestionLetterDuration4,
      studyTillCorrectFindingAnswerDuration:
          studyTillCorrectFindingAnswerDuration4,
      studyTillCorrectTypingAnswerLetterDuration:
          studyTillCorrectTypingAnswerLetterDuration4,
      testsTimeOfAnswerAction: testsTimeOfAnswerAction4,
      doesObfuscateQuestion: doesObfuscateQuestion4,
    );
    var fieldList5 = FieldList(
      id: fieldListId5,
      fieldId: fieldId2,
      name: name5,
      creationAt: creationAt5,
      lastModificationAt: lastModificationAt5,
      languageTag: languageTag5,
      checkType: checkType5,
      sortBy: sortBy5,
      doesReadAnswer: doesReadAnswer5,
      usageCount: usageCount5,
      color: color5,
      emulationNumberOfQuestions: emulationNumberOfQuestions5,
      emulationDays: emulationDays5,
      testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration5,
      testsFindingAnswerDuration: testsFindingAnswerDuration5,
      testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration5,
      studyTillCorrectReadingQuestionLetterDuration:
          studyTillCorrectReadingQuestionLetterDuration5,
      studyTillCorrectFindingAnswerDuration:
          studyTillCorrectFindingAnswerDuration5,
      studyTillCorrectTypingAnswerLetterDuration:
          studyTillCorrectTypingAnswerLetterDuration5,
      testsTimeOfAnswerAction: testsTimeOfAnswerAction5,
      doesObfuscateQuestion: doesObfuscateQuestion5,
    );
    var fieldList6 = FieldList(
      id: fieldListId6,
      fieldId: fieldId,
      name: name6,
      creationAt: creationAt6,
      lastModificationAt: lastModificationAt6,
      languageTag: languageTag6,
      checkType: checkType6,
      sortBy: sortBy6,
      doesReadAnswer: doesReadAnswer6,
      usageCount: usageCount6,
      color: color6,
      emulationNumberOfQuestions: emulationNumberOfQuestions6,
      emulationDays: emulationDays6,
      testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration6,
      testsFindingAnswerDuration: testsFindingAnswerDuration6,
      testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration6,
      studyTillCorrectReadingQuestionLetterDuration:
          studyTillCorrectReadingQuestionLetterDuration6,
      studyTillCorrectFindingAnswerDuration:
          studyTillCorrectFindingAnswerDuration6,
      studyTillCorrectTypingAnswerLetterDuration:
          studyTillCorrectTypingAnswerLetterDuration6,
      testsTimeOfAnswerAction: testsTimeOfAnswerAction6,
      doesObfuscateQuestion: doesObfuscateQuestion6,
    );
    await fieldListsDao.create(fieldList1.toCompanion(true));
    await fieldListsDao.create(fieldList2.toCompanion(true));
    await fieldListsDao.create(fieldList3.toCompanion(true));
    await fieldListsDao.create(fieldList4.toCompanion(true));
    await fieldListsDao.create(fieldList5.toCompanion(true));
    await fieldListsDao.create(fieldList6.toCompanion(true));
    final result = await fieldsDao
        .watchWithFieldListsCountByUserAccountId(userAccountId)
        .first;
    expect(result, [(field1, 3), (field2, 2), (field3, 1), (field4, 0)]);
    final gottenField = result[0].$1;
    expect(gottenField.id, field1.id);
    expect(gottenField.userAccountId, field1.userAccountId);
    expect(gottenField.name, field1.name);
    expect(gottenField.creationAt, field1.creationAt);
    expect(gottenField.lastModificationAt, field1.lastModificationAt);
    expect(gottenField.usageCount, field1.usageCount);
    expect(gottenField.color, field1.color);
  });
}
