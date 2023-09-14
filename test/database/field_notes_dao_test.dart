import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/field_notes_dao.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late FieldNotesDao fieldNotesDao;
  late FieldsDao fieldsDao;
  String id = const Uuid().v4();
  String fieldId = const Uuid().v4();
  String texT = "some fieldNote";
  DateTime creationAt = DateTime(2020, 1, 1);
  DateTime lastModificationAt = DateTime(2020, 2, 2);
  String userAccountId = "j0kW7TZPcdZBHLsIUvJOFiAI8VN2";
  String name1 = "name";
  DateTime creationAt1 = DateTime(2019, 1, 1);
  DateTime lastModificationAt1 = DateTime.utc(2019, 2, 2);
  int usageCount1 = 9;
  int color1 = 0xff55ee11;
  var field = Field(
      id: fieldId,
      userAccountId: userAccountId,
      name: name1,
      creationAt: creationAt1,
      lastModificationAt: lastModificationAt1,
      usageCount: usageCount1,
      color: color1);
  setUp(() async {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fieldNotesDao = FieldNotesDao(appDatabase);
    fieldsDao = FieldsDao(appDatabase);
    await fieldsDao.create(field.toCompanion(true));
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a fieldNote", () {
    test("Invalid fieldNote: id is an invalid UUID v4", () async {
      var fieldNote = FieldNote(
          id: "wew",
          fieldId: fieldId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldNotesDao.create(fieldNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No Notes with the same id", () async {
      var fieldNote1 = FieldNote(
          id: id,
          fieldId: fieldId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      var fieldNote2 = FieldNote(
          id: id,
          fieldId: fieldId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldNotesDao.create(fieldNote1.toCompanion(true));
        await fieldNotesDao.create(fieldNote2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid fieldNote: fieldId is an invalid UUID v4", () async {
      var fieldNote = FieldNote(
          id: id,
          fieldId: "efww",
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldNotesDao.create(fieldNote.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldId"))));
    });

    test(
        "Invalid fieldNote: text length is smaller than ${FieldNotes.MINIMUM_LENGTH_OF_TEXT}",
        () async {
      var fieldNote = FieldNote(
          id: id,
          fieldId: fieldId,
          texT: "",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldNotesDao.create(fieldNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
      fieldNote = FieldNote(
          id: id,
          fieldId: fieldId,
          texT: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldNotesDao.create(fieldNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
    });

    test(
        "Invalid fieldNote: text length is bigger than ${FieldNotes.MAXIMUM_LENGTH_OF_TEXT}",
        () async {
      var fieldNote = FieldNote(
          id: id,
          fieldId: fieldId,
          texT: "f" * (FieldNotes.MAXIMUM_LENGTH_OF_TEXT + 1),
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldNotesDao.create(fieldNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
    });

    test("Invalid fieldNote: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () async {
        var fieldNote = FieldNote(
            id: id,
            fieldId: fieldId,
            texT: texT,
            creationAt: DateTime(2020, 2, 2),
            lastModificationAt: lastModificationAt);
        expect(() async {
          await fieldNotesDao.create(fieldNote.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("Invalid fieldNote: lastModificationAt is in the future", () {
      withClock(Clock.fixed(DateTime(2021, 1, 1)), () async {
        var fieldNote = FieldNote(
            id: id,
            fieldId: fieldId,
            texT: texT,
            creationAt: creationAt,
            lastModificationAt: DateTime(2022, 1, 1));
        expect(() async {
          await fieldNotesDao.create(fieldNote.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
      });
    });

    test("Invalid fieldNote: lastModificationAt is before creationAt", () {
      withClock(Clock.fixed(DateTime(2021, 1, 1)), () async {
        var fieldNote = FieldNote(
            id: id,
            fieldId: fieldId,
            texT: texT,
            creationAt: DateTime(2020, 1, 1),
            lastModificationAt: DateTime(2019, 1, 1));
        expect(() async {
          await fieldNotesDao.create(fieldNote.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Good case: create Note without 'id'", () async {
      var fieldNotesCompanion = FieldNotesCompanion(
          fieldId: Value(fieldId),
          texT: Value(texT),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await fieldNotesDao.create(fieldNotesCompanion);
    });
  });

  group("Getting a specific Note by id", () {
    test("Good case: this specific Note is found", () async {
      var fieldNote = FieldNote(
          id: id,
          fieldId: fieldId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await fieldNotesDao.create(fieldNote.toCompanion(true));
      FieldNote? gottenNote = await fieldNotesDao.getById(id);
      gottenNote = gottenNote!;
      expect(gottenNote.id, id);
      expect(gottenNote.fieldId, fieldId);
      expect(gottenNote.texT, texT);
      expect(gottenNote.creationAt, creationAt);
      expect(gottenNote.lastModificationAt, lastModificationAt);
    });

    test("Good case: this specific Note is not found", () async {
      FieldNote? gottenNote = await fieldNotesDao.getById(const Uuid().v4());
      expect(gottenNote, null);
    });
  });

  test("Getting all fieldNotes by fieldId", () async {
    var fieldNoteId1 = const Uuid().v4();
    var fieldNoteId2 = const Uuid().v4();
    var fieldNoteId3 = const Uuid().v4();
    var fieldNoteId4 = const Uuid().v4();
    var fieldNoteId5 = const Uuid().v4();
    var fieldNoteId6 = const Uuid().v4();
    var fieldId2 = const Uuid().v4();
    var fieldId3 = const Uuid().v4();
    var texT1 = "text1";
    var texT2 = "text2";
    var texT3 = "text3";
    var texT4 = "text4";
    var texT5 = "text5";
    var texT6 = "text6";
    DateTime creationAt1 = DateTime(2020, 1, 1);
    DateTime creationAt2 = DateTime(2020, 2, 2);
    DateTime creationAt3 = DateTime(2020, 3, 3);
    DateTime creationAt4 = DateTime(2020, 4, 4);
    DateTime creationAt5 = DateTime(2020, 5, 5);
    DateTime creationAt6 = DateTime(2020, 6, 6);
    DateTime lastModificationAt1 = DateTime(2021, 1, 1);
    DateTime lastModificationAt2 = DateTime(2021, 2, 2);
    DateTime lastModificationAt3 = DateTime(2021, 3, 3);
    DateTime lastModificationAt4 = DateTime(2021, 4, 4);
    DateTime lastModificationAt5 = DateTime(2021, 5, 5);
    DateTime lastModificationAt6 = DateTime(2021, 6, 6);
    var field2 = Field(
        id: fieldId2,
        userAccountId: userAccountId,
        name: name1 + "y",
        creationAt: creationAt1.add(Duration(days: 7)),
        lastModificationAt: lastModificationAt1.add(Duration(days: 8)),
        usageCount: 5,
        color: 0xff005577);
    await fieldsDao.create(field2.toCompanion(true));
    var field3 = Field(
        id: fieldId3,
        userAccountId: userAccountId,
        name: name1 + "t",
        creationAt: creationAt1.add(Duration(days: 2)),
        lastModificationAt: lastModificationAt1.add(Duration(days: 3)),
        usageCount: 5,
        color: 0xff005577);
    await fieldsDao.create(field3.toCompanion(true));
    var fieldNote1 = FieldNote(
        id: fieldNoteId1,
        fieldId: fieldId,
        texT: texT1,
        creationAt: creationAt1,
        lastModificationAt: lastModificationAt1);
    var fieldNote2 = FieldNote(
        id: fieldNoteId2,
        fieldId: fieldId2,
        texT: texT2,
        creationAt: creationAt2,
        lastModificationAt: lastModificationAt2);
    var fieldNote3 = FieldNote(
        id: fieldNoteId3,
        fieldId: fieldId3,
        texT: texT3,
        creationAt: creationAt3,
        lastModificationAt: lastModificationAt3);
    var fieldNote4 = FieldNote(
        id: fieldNoteId4,
        fieldId: fieldId,
        texT: texT4,
        creationAt: creationAt4,
        lastModificationAt: lastModificationAt4);
    var fieldNote5 = FieldNote(
        id: fieldNoteId5,
        fieldId: fieldId2,
        texT: texT5,
        creationAt: creationAt5,
        lastModificationAt: lastModificationAt5);
    var fieldNote6 = FieldNote(
        id: fieldNoteId6,
        fieldId: fieldId,
        texT: texT6,
        creationAt: creationAt6,
        lastModificationAt: lastModificationAt6);
    await fieldNotesDao.create(fieldNote1.toCompanion(true));
    await fieldNotesDao.create(fieldNote2.toCompanion(true));
    await fieldNotesDao.create(fieldNote3.toCompanion(true));
    await fieldNotesDao.create(fieldNote4.toCompanion(true));
    await fieldNotesDao.create(fieldNote5.toCompanion(true));
    await fieldNotesDao.create(fieldNote6.toCompanion(true));
    Stream<List<FieldNote>> streamNotes = fieldNotesDao.watchByFieldId(fieldId);
    List<FieldNote> fieldNotes = await streamNotes.first;
    expect(fieldNotes.length, 3);
    var gottenNote = fieldNotes[0];
    expect(gottenNote.id, fieldNoteId6);
    expect(gottenNote.fieldId, fieldId);
    expect(gottenNote.texT, texT6);
    expect(gottenNote.creationAt, creationAt6);
    expect(gottenNote.lastModificationAt, lastModificationAt6);
    gottenNote = fieldNotes[1];
    expect(gottenNote.id, fieldNoteId4);
    expect(gottenNote.fieldId, fieldId);
    expect(gottenNote.texT, texT4);
    expect(gottenNote.creationAt, creationAt4);
    expect(gottenNote.lastModificationAt, lastModificationAt4);
    gottenNote = fieldNotes[2];
    expect(gottenNote.id, fieldNoteId1);
    expect(gottenNote.fieldId, fieldId);
    expect(gottenNote.texT, texT1);
    expect(gottenNote.creationAt, creationAt1);
    expect(gottenNote.lastModificationAt, lastModificationAt1);
    streamNotes = fieldNotesDao.watchByFieldId(fieldId2);
    fieldNotes = await streamNotes.first;
    expect(fieldNotes.length, 2);
    gottenNote = fieldNotes[0];
    expect(gottenNote.id, fieldNoteId5);
    expect(gottenNote.fieldId, fieldId2);
    expect(gottenNote.texT, texT5);
    expect(gottenNote.creationAt, creationAt5);
    expect(gottenNote.lastModificationAt, lastModificationAt5);
    gottenNote = fieldNotes[1];
    expect(gottenNote.id, fieldNoteId2);
    expect(gottenNote.fieldId, fieldId2);
    expect(gottenNote.texT, texT2);
    expect(gottenNote.creationAt, creationAt2);
    expect(gottenNote.lastModificationAt, lastModificationAt2);
    streamNotes = fieldNotesDao.watchByFieldId(fieldId3);
    fieldNotes = await streamNotes.first;
    expect(fieldNotes.length, 1);
    gottenNote = fieldNotes[0];
    expect(gottenNote.id, fieldNoteId3);
    expect(gottenNote.fieldId, fieldId3);
    expect(gottenNote.texT, texT3);
    expect(gottenNote.creationAt, creationAt3);
    expect(gottenNote.lastModificationAt, lastModificationAt3);
  });

  group("Update a Note", () {
    setUp(() async {
      var fieldNote = FieldNote(
          id: id,
          fieldId: fieldId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await fieldNotesDao.create(fieldNote.toCompanion(true));
    });

    test("Invalid update: fieldId is an invalid UUID v4", () async {
      var fieldNote = FieldNote(
          id: id,
          fieldId: "ehowf",
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldNotesDao.mutate(fieldNote.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldId"))));
    });

    test("Invalid update: fieldId doesn't exist in Fields table", () async {
      var fieldNote = FieldNote(
          id: id,
          fieldId: const Uuid().v4(),
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldNotesDao.mutate(fieldNote.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test(
        "Invalid update: text length is smaller than ${FieldNotes.MINIMUM_LENGTH_OF_TEXT}",
        () async {
      var fieldNote = FieldNote(
          id: id,
          fieldId: fieldId,
          texT: "",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldNotesDao.mutate(fieldNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
      fieldNote = FieldNote(
          id: id,
          fieldId: fieldId,
          texT: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldNotesDao.mutate(fieldNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
    });

    test(
        "Invalid update: text length is bigger than ${FieldNotes.MAXIMUM_LENGTH_OF_TEXT}",
        () async {
      var fieldNote = FieldNote(
          id: id,
          fieldId: fieldId,
          texT: "f" * (FieldNotes.MAXIMUM_LENGTH_OF_TEXT + 1),
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldNotesDao.mutate(fieldNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
    });

    test("Invalid update: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () async {
        var fieldNote = FieldNote(
            id: id,
            fieldId: fieldId,
            texT: texT,
            creationAt: DateTime(2020, 2, 2),
            lastModificationAt: lastModificationAt);
        expect(() async {
          await fieldNotesDao.mutate(fieldNote.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("Invalid update: lastModificationAt is in the future", () {
      withClock(Clock.fixed(DateTime(2021, 1, 1)), () async {
        var fieldNote = FieldNote(
            id: id,
            fieldId: fieldId,
            texT: texT,
            creationAt: creationAt,
            lastModificationAt: DateTime(2022, 1, 1));
        expect(() async {
          await fieldNotesDao.mutate(fieldNote.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
      });
    });

    test("Invalid update: lastModificationAt is before creationAt", () {
      withClock(Clock.fixed(DateTime(2021, 1, 1)), () async {
        var fieldNote = FieldNote(
            id: id,
            fieldId: fieldId,
            texT: texT,
            creationAt: DateTime(2020, 1, 1),
            lastModificationAt: DateTime(2019, 1, 1));
        expect(() async {
          await fieldNotesDao.mutate(fieldNote.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Good case 1", () async {
      final fieldId1 = const Uuid().v4();
      var field1 = Field(
          id: fieldId1,
          userAccountId: userAccountId,
          name: name1,
          creationAt: creationAt1.add(Duration(days: 2)),
          lastModificationAt: lastModificationAt1.add(Duration(days: 3)),
          usageCount: 5,
          color: 0xff005577);
      await fieldsDao.create(field1.toCompanion(true));
      var fieldNote = FieldNote(
          id: id,
          fieldId: fieldId1,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await fieldNotesDao.mutate(fieldNote.toCompanion(true));
      FieldNote? gottenNote = await fieldNotesDao.getById(id);
      gottenNote = gottenNote!;
      expect(gottenNote.id, id);
      expect(gottenNote.fieldId, fieldId1);
      expect(gottenNote.texT, texT);
      expect(gottenNote.creationAt, creationAt);
      expect(gottenNote.lastModificationAt, lastModificationAt);
    });

    test("Good case 2", () async {
      const newText = "wofwoef";
      var newLastModificationAt = lastModificationAt.add(Duration(days: 13));
      var fieldNote = FieldNote(
          id: id,
          fieldId: fieldId,
          texT: newText,
          creationAt: creationAt,
          lastModificationAt: newLastModificationAt);
      await fieldNotesDao.mutate(fieldNote.toCompanion(true));
      FieldNote? gottenNote = await fieldNotesDao.getById(id);
      gottenNote = gottenNote!;
      expect(gottenNote.id, id);
      expect(gottenNote.fieldId, fieldId);
      expect(gottenNote.texT, newText);
      expect(gottenNote.creationAt, creationAt);
      expect(gottenNote.lastModificationAt, newLastModificationAt);
    });
  });

  test("Delete some Note", () async {
    var fieldNote = FieldNote(
        id: id,
        fieldId: fieldId,
        texT: texT,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt);
    await fieldNotesDao.create(fieldNote.toCompanion(true));
    await fieldNotesDao.remove(id);
    var gottenNote = await fieldNotesDao.getById(id);
    expect(gottenNote, null);
  });
}
