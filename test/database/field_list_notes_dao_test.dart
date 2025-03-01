import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/field_list_notes_dao.dart';
import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late FieldListNotesDao fieldListNotesDao;
  late FieldsDao fieldsDao;
  late FieldListsDao fieldListsDao;
  String id = const Uuid().v4();
  String fieldId = const Uuid().v4();
  String fieldListId = const Uuid().v4();
  String fieldName = "field name";
  String fieldListName = "field list name";
  String texT = "some fieldListNote";
  DateTime creationAt = DateTime(2020, 1, 1);
  DateTime lastModificationAt = DateTime(2020, 2, 2);
  String languageTag = "en-US";
  int checkType = CheckType.NON_STRICT_IGNORE_CASE.index;
  int sortBy = SortBy.CREATION_DATE_DESC.index;
  bool doesReadAnswer = true;
  int usageCount = 20;
  int color = 0x55554433;
  int emulationNumberOfQuestions = 0;
  String emulationDays = "01234";
  int testsReadingQuestionLetterDuration = 200;
  int testsFindingAnswerDuration = 1000;
  int testsTypingAnswerLetterDuration = 100;
  int studyTillCorrectReadingQuestionLetterDuration = 200;
  int studyTillCorrectFindingAnswerDuration = 1000;
  int studyTillCorrectTypingAnswerLetterDuration = 100;
  int testsTimeOfAnswerAction = TimeOfAnswerAction.NEXT.index;
  bool doesObfuscateQuestion = true;
  String userAccountId = "j0kW7TZPcdZBHLsIUvJOFiAI8VN2";
  String name1 = "name";
  DateTime creationAt1 = DateTime(2019, 1, 1);
  DateTime lastModificationAt1 = DateTime.utc(2019, 2, 2);
  int usageCount1 = 9;
  int color1 = 0xff55ee11;
  var field = Field(
      id: fieldId,
      userAccountId: userAccountId,
      name: fieldName,
      creationAt: creationAt1,
      lastModificationAt: lastModificationAt1,
      usageCount: usageCount1,
      color: color1);
  var fieldList = FieldList(
      id: fieldListId,
      fieldId: fieldId,
      name: fieldListName,
      creationAt: creationAt1,
      lastModificationAt: lastModificationAt1,
      languageTag: languageTag,
      checkType: checkType,
      sortBy: sortBy,
      doesReadAnswer: doesReadAnswer,
      usageCount: usageCount,
      color: color,
      emulationNumberOfQuestions: emulationNumberOfQuestions,
      emulationDays: emulationDays,
      testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration,
      testsFindingAnswerDuration: testsFindingAnswerDuration,
      testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
      studyTillCorrectReadingQuestionLetterDuration:
          studyTillCorrectReadingQuestionLetterDuration,
      studyTillCorrectFindingAnswerDuration:
          studyTillCorrectFindingAnswerDuration,
      studyTillCorrectTypingAnswerLetterDuration:
          studyTillCorrectTypingAnswerLetterDuration,
      testsTimeOfAnswerAction: testsTimeOfAnswerAction,
      doesObfuscateQuestion: doesObfuscateQuestion);
  setUp(() async {
    appDatabase = AppDatabase(NativeDatabase.memory());
    fieldListNotesDao = FieldListNotesDao(appDatabase);
    fieldListsDao = FieldListsDao(appDatabase);
    fieldsDao = FieldsDao(appDatabase);
    await fieldsDao.create(field.toCompanion(true));
    await fieldListsDao.create(fieldList.toCompanion(true));
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a fieldListNote", () {
    test("Invalid fieldListNote: id is an invalid UUID v4", () async {
      var fieldListNote = FieldListNote(
          id: "wew",
          fieldListId: fieldListId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldListNotesDao.create(fieldListNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No Notes with the same id", () async {
      var fieldListNote1 = FieldListNote(
          id: id,
          fieldListId: fieldListId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      var fieldListNote2 = FieldListNote(
          id: id,
          fieldListId: fieldListId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldListNotesDao.create(fieldListNote1.toCompanion(true));
        await fieldListNotesDao.create(fieldListNote2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid fieldListNote: fieldListId is an invalid UUID v4", () async {
      var fieldListNote = FieldListNote(
          id: id,
          fieldListId: "efww",
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldListNotesDao.create(fieldListNote.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldListId"))));
    });

    test(
        "Invalid fieldListNote: text length is smaller than ${FieldListNotes.MINIMUM_LENGTH_OF_TEXT}",
        () async {
      var fieldListNote = FieldListNote(
          id: id,
          fieldListId: fieldListId,
          texT: "",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldListNotesDao.create(fieldListNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
      fieldListNote = FieldListNote(
          id: id,
          fieldListId: fieldListId,
          texT: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldListNotesDao.create(fieldListNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
    });

    test(
        "Invalid fieldListNote: text length is bigger than ${FieldListNotes.MAXIMUM_LENGTH_OF_TEXT}",
        () async {
      var fieldListNote = FieldListNote(
          id: id,
          fieldListId: fieldListId,
          texT: "f" * (FieldListNotes.MAXIMUM_LENGTH_OF_TEXT + 1),
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldListNotesDao.create(fieldListNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
    });

    test("Invalid fieldListNote: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () async {
        var fieldListNote = FieldListNote(
            id: id,
            fieldListId: fieldListId,
            texT: texT,
            creationAt: DateTime(2020, 2, 2),
            lastModificationAt: lastModificationAt);
        expect(() async {
          await fieldListNotesDao.create(fieldListNote.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("Invalid fieldListNote: lastModificationAt is in the future", () {
      withClock(Clock.fixed(DateTime(2021, 1, 1)), () async {
        var fieldListNote = FieldListNote(
            id: id,
            fieldListId: fieldListId,
            texT: texT,
            creationAt: creationAt,
            lastModificationAt: DateTime(2022, 1, 1));
        expect(() async {
          await fieldListNotesDao.create(fieldListNote.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
      });
    });

    test("Invalid fieldListNote: lastModificationAt is before creationAt", () {
      withClock(Clock.fixed(DateTime(2021, 1, 1)), () async {
        var fieldListNote = FieldListNote(
            id: id,
            fieldListId: fieldListId,
            texT: texT,
            creationAt: DateTime(2020, 1, 1),
            lastModificationAt: DateTime(2019, 1, 1));
        expect(() async {
          await fieldListNotesDao.create(fieldListNote.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Good case: create Note without 'id'", () async {
      var fieldListNotesCompanion = FieldListNotesCompanion(
          fieldListId: Value(fieldListId),
          texT: Value(texT),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await fieldListNotesDao.create(fieldListNotesCompanion);
    });
  });

  group("Getting a specific Note by id", () {
    test("Good case: this specific Note is found", () async {
      var fieldListNote = FieldListNote(
          id: id,
          fieldListId: fieldListId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await fieldListNotesDao.create(fieldListNote.toCompanion(true));
      FieldListNote? gottenNote = await fieldListNotesDao.getById(id);
      gottenNote = gottenNote!;
      expect(gottenNote.id, id);
      expect(gottenNote.fieldListId, fieldListId);
      expect(gottenNote.texT, texT);
      expect(gottenNote.creationAt, creationAt);
      expect(gottenNote.lastModificationAt, lastModificationAt);
    });

    test("Good case: this specific Note is not found", () async {
      FieldListNote? gottenNote =
          await fieldListNotesDao.getById(const Uuid().v4());
      expect(gottenNote, null);
    });
  });

  test("Getting all fieldListNotes by fieldListId", () async {
    var fieldListNoteId1 = const Uuid().v4();
    var fieldListNoteId2 = const Uuid().v4();
    var fieldListNoteId3 = const Uuid().v4();
    var fieldListNoteId4 = const Uuid().v4();
    var fieldListNoteId5 = const Uuid().v4();
    var fieldListNoteId6 = const Uuid().v4();
    var fieldListId2 = const Uuid().v4();
    var fieldListId3 = const Uuid().v4();
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
    var fieldList2 = FieldList(
        id: fieldListId2,
        fieldId: fieldId,
        name: fieldListName + "n",
        creationAt: creationAt1,
        lastModificationAt: lastModificationAt1,
        languageTag: languageTag,
        checkType: checkType,
        sortBy: sortBy,
        doesReadAnswer: doesReadAnswer,
        usageCount: usageCount,
        color: color,
        emulationNumberOfQuestions: emulationNumberOfQuestions,
        emulationDays: emulationDays,
        testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration,
        testsFindingAnswerDuration: testsFindingAnswerDuration,
        testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
        studyTillCorrectReadingQuestionLetterDuration:
            studyTillCorrectReadingQuestionLetterDuration,
        studyTillCorrectFindingAnswerDuration:
            studyTillCorrectFindingAnswerDuration,
        studyTillCorrectTypingAnswerLetterDuration:
            studyTillCorrectTypingAnswerLetterDuration,
        testsTimeOfAnswerAction: testsTimeOfAnswerAction,
        doesObfuscateQuestion: doesObfuscateQuestion);
    var fieldList3 = FieldList(
        id: fieldListId3,
        fieldId: fieldId,
        name: fieldListName + "t",
        creationAt: creationAt1,
        lastModificationAt: lastModificationAt1,
        languageTag: languageTag,
        checkType: checkType,
        sortBy: sortBy,
        doesReadAnswer: doesReadAnswer,
        usageCount: usageCount,
        color: color,
        emulationNumberOfQuestions: emulationNumberOfQuestions,
        emulationDays: emulationDays,
        testsReadingQuestionLetterDuration: testsReadingQuestionLetterDuration,
        testsFindingAnswerDuration: testsFindingAnswerDuration,
        testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
        studyTillCorrectReadingQuestionLetterDuration:
            studyTillCorrectReadingQuestionLetterDuration,
        studyTillCorrectFindingAnswerDuration:
            studyTillCorrectFindingAnswerDuration,
        studyTillCorrectTypingAnswerLetterDuration:
            studyTillCorrectTypingAnswerLetterDuration,
        testsTimeOfAnswerAction: testsTimeOfAnswerAction,
        doesObfuscateQuestion: doesObfuscateQuestion);
    await fieldListsDao.create(fieldList2.toCompanion(true));
    await fieldListsDao.create(fieldList3.toCompanion(true));
    var fieldListNote1 = FieldListNote(
        id: fieldListNoteId1,
        fieldListId: fieldListId,
        texT: texT1,
        creationAt: creationAt1,
        lastModificationAt: lastModificationAt1);
    var fieldListNote2 = FieldListNote(
        id: fieldListNoteId2,
        fieldListId: fieldListId2,
        texT: texT2,
        creationAt: creationAt2,
        lastModificationAt: lastModificationAt2);
    var fieldListNote3 = FieldListNote(
        id: fieldListNoteId3,
        fieldListId: fieldListId3,
        texT: texT3,
        creationAt: creationAt3,
        lastModificationAt: lastModificationAt3);
    var fieldListNote4 = FieldListNote(
        id: fieldListNoteId4,
        fieldListId: fieldListId,
        texT: texT4,
        creationAt: creationAt4,
        lastModificationAt: lastModificationAt4);
    var fieldListNote5 = FieldListNote(
        id: fieldListNoteId5,
        fieldListId: fieldListId2,
        texT: texT5,
        creationAt: creationAt5,
        lastModificationAt: lastModificationAt5);
    var fieldListNote6 = FieldListNote(
        id: fieldListNoteId6,
        fieldListId: fieldListId,
        texT: texT6,
        creationAt: creationAt6,
        lastModificationAt: lastModificationAt6);
    await fieldListNotesDao.create(fieldListNote1.toCompanion(true));
    await fieldListNotesDao.create(fieldListNote2.toCompanion(true));
    await fieldListNotesDao.create(fieldListNote3.toCompanion(true));
    await fieldListNotesDao.create(fieldListNote4.toCompanion(true));
    await fieldListNotesDao.create(fieldListNote5.toCompanion(true));
    await fieldListNotesDao.create(fieldListNote6.toCompanion(true));
    Stream<List<FieldListNote>> streamNotes =
        fieldListNotesDao.watchByFieldListId(fieldListId);
    List<FieldListNote> fieldListNotes = await streamNotes.first;
    expect(fieldListNotes.length, 3);
    var gottenNote = fieldListNotes[0];
    expect(gottenNote.id, fieldListNoteId6);
    expect(gottenNote.fieldListId, fieldListId);
    expect(gottenNote.texT, texT6);
    expect(gottenNote.creationAt, creationAt6);
    expect(gottenNote.lastModificationAt, lastModificationAt6);
    gottenNote = fieldListNotes[1];
    expect(gottenNote.id, fieldListNoteId4);
    expect(gottenNote.fieldListId, fieldListId);
    expect(gottenNote.texT, texT4);
    expect(gottenNote.creationAt, creationAt4);
    expect(gottenNote.lastModificationAt, lastModificationAt4);
    gottenNote = fieldListNotes[2];
    expect(gottenNote.id, fieldListNoteId1);
    expect(gottenNote.fieldListId, fieldListId);
    expect(gottenNote.texT, texT1);
    expect(gottenNote.creationAt, creationAt1);
    expect(gottenNote.lastModificationAt, lastModificationAt1);
    streamNotes = fieldListNotesDao.watchByFieldListId(fieldListId2);
    fieldListNotes = await streamNotes.first;
    expect(fieldListNotes.length, 2);
    gottenNote = fieldListNotes[0];
    expect(gottenNote.id, fieldListNoteId5);
    expect(gottenNote.fieldListId, fieldListId2);
    expect(gottenNote.texT, texT5);
    expect(gottenNote.creationAt, creationAt5);
    expect(gottenNote.lastModificationAt, lastModificationAt5);
    gottenNote = fieldListNotes[1];
    expect(gottenNote.id, fieldListNoteId2);
    expect(gottenNote.fieldListId, fieldListId2);
    expect(gottenNote.texT, texT2);
    expect(gottenNote.creationAt, creationAt2);
    expect(gottenNote.lastModificationAt, lastModificationAt2);
    streamNotes = fieldListNotesDao.watchByFieldListId(fieldListId3);
    fieldListNotes = await streamNotes.first;
    expect(fieldListNotes.length, 1);
    gottenNote = fieldListNotes[0];
    expect(gottenNote.id, fieldListNoteId3);
    expect(gottenNote.fieldListId, fieldListId3);
    expect(gottenNote.texT, texT3);
    expect(gottenNote.creationAt, creationAt3);
    expect(gottenNote.lastModificationAt, lastModificationAt3);
  });

  group("Update a Note", () {
    setUp(() async {
      var fieldListNote = FieldListNote(
          id: id,
          fieldListId: fieldListId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await fieldListNotesDao.create(fieldListNote.toCompanion(true));
    });

    test("Invalid update: fieldListId is an invalid UUID v4", () async {
      var fieldListNote = FieldListNote(
          id: id,
          fieldListId: "ehowf",
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldListNotesDao.mutate(fieldListNote.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("fieldListId"))));
    });

    test("Invalid update: fieldListId doesn't exist in Fields table", () async {
      var fieldListNote = FieldListNote(
          id: id,
          fieldListId: const Uuid().v4(),
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldListNotesDao.mutate(fieldListNote.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is SqliteException && e.message.contains("FOREIGN KEY"))));
    });

    test(
        "Invalid update: text length is smaller than ${FieldListNotes.MINIMUM_LENGTH_OF_TEXT}",
        () async {
      var fieldListNote = FieldListNote(
          id: id,
          fieldListId: fieldListId,
          texT: "",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldListNotesDao.mutate(fieldListNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
      fieldListNote = FieldListNote(
          id: id,
          fieldListId: fieldListId,
          texT: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldListNotesDao.mutate(fieldListNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
    });

    test(
        "Invalid update: text length is bigger than ${FieldListNotes.MAXIMUM_LENGTH_OF_TEXT}",
        () async {
      var fieldListNote = FieldListNote(
          id: id,
          fieldListId: fieldListId,
          texT: "f" * (FieldListNotes.MAXIMUM_LENGTH_OF_TEXT + 1),
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await fieldListNotesDao.mutate(fieldListNote.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
    });

    test("Invalid update: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () async {
        var fieldListNote = FieldListNote(
            id: id,
            fieldListId: fieldListId,
            texT: texT,
            creationAt: DateTime(2020, 2, 2),
            lastModificationAt: lastModificationAt);
        expect(() async {
          await fieldListNotesDao.mutate(fieldListNote.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("Invalid update: lastModificationAt is in the future", () {
      withClock(Clock.fixed(DateTime(2021, 1, 1)), () async {
        var fieldListNote = FieldListNote(
            id: id,
            fieldListId: fieldListId,
            texT: texT,
            creationAt: creationAt,
            lastModificationAt: DateTime(2022, 1, 1));
        expect(() async {
          await fieldListNotesDao.mutate(fieldListNote.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
      });
    });

    test("Invalid update: lastModificationAt is before creationAt", () {
      withClock(Clock.fixed(DateTime(2021, 1, 1)), () async {
        var fieldListNote = FieldListNote(
            id: id,
            fieldListId: fieldListId,
            texT: texT,
            creationAt: DateTime(2020, 1, 1),
            lastModificationAt: DateTime(2019, 1, 1));
        expect(() async {
          await fieldListNotesDao.mutate(fieldListNote.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Good case 1", () async {
      final fieldListId1 = const Uuid().v4();
      var fieldList2 = FieldList(
          id: fieldListId1,
          fieldId: fieldId,
          name: fieldListName + "n",
          creationAt: creationAt1,
          lastModificationAt: lastModificationAt1,
          languageTag: languageTag,
          checkType: checkType,
          sortBy: sortBy,
          doesReadAnswer: doesReadAnswer,
          usageCount: usageCount,
          color: color,
          emulationNumberOfQuestions: emulationNumberOfQuestions,
          emulationDays: emulationDays,
          testsReadingQuestionLetterDuration:
              testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration: testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: testsTimeOfAnswerAction,
          doesObfuscateQuestion: doesObfuscateQuestion);
      await fieldListsDao.create(fieldList2.toCompanion(true));
      var field1 = Field(
          id: fieldListId1,
          userAccountId: userAccountId,
          name: name1,
          creationAt: creationAt1.add(Duration(days: 2)),
          lastModificationAt: lastModificationAt1.add(Duration(days: 3)),
          usageCount: 5,
          color: 0xff005577);
      await fieldsDao.create(field1.toCompanion(true));
      var fieldListNote = FieldListNote(
          id: id,
          fieldListId: fieldListId1,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await fieldListNotesDao.mutate(fieldListNote.toCompanion(true));
      FieldListNote? gottenNote = await fieldListNotesDao.getById(id);
      gottenNote = gottenNote!;
      expect(gottenNote.id, id);
      expect(gottenNote.fieldListId, fieldListId1);
      expect(gottenNote.texT, texT);
      expect(gottenNote.creationAt, creationAt);
      expect(gottenNote.lastModificationAt, lastModificationAt);
    });

    test("Good case 2", () async {
      const newText = "wofwoef";
      var newLastModificationAt = lastModificationAt.add(Duration(days: 13));
      var fieldListNote = FieldListNote(
          id: id,
          fieldListId: fieldListId,
          texT: newText,
          creationAt: creationAt,
          lastModificationAt: newLastModificationAt);
      await fieldListNotesDao.mutate(fieldListNote.toCompanion(true));
      FieldListNote? gottenNote = await fieldListNotesDao.getById(id);
      gottenNote = gottenNote!;
      expect(gottenNote.id, id);
      expect(gottenNote.fieldListId, fieldListId);
      expect(gottenNote.texT, newText);
      expect(gottenNote.creationAt, creationAt);
      expect(gottenNote.lastModificationAt, newLastModificationAt);
    });
  });

  test("Delete some Note", () async {
    var fieldListNote = FieldListNote(
        id: id,
        fieldListId: fieldListId,
        texT: texT,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt);
    await fieldListNotesDao.create(fieldListNote.toCompanion(true));
    await fieldListNotesDao.remove(id);
    var gottenNote = await fieldListNotesDao.getById(id);
    expect(gottenNote, null);
  });
}
