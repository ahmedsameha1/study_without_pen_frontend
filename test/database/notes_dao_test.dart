import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/notes_dao.dart';
import 'package:uuid/uuid.dart';

void main() {
  late AppDatabase appDatabase;
  late NotesDao notesDao;
  String id = const Uuid().v4();
  String relationalId = const Uuid().v4();
  String texT = "some note";
  DateTime creationAt = DateTime(2020, 1, 1);
  DateTime lastModificationAt = DateTime(2020, 2, 2);

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    notesDao = NotesDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a note", () {
    test("Invalid note: id is an invalid UUID v4", () async {
      var note = Note(
          id: "wew",
          relationalId: relationalId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await notesDao.create(note.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No Notes with the same id", () async {
      var note1 = Note(
          id: id,
          relationalId: relationalId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      var note2 = Note(
          id: id,
          relationalId: relationalId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await notesDao.create(note1.toCompanion(true));
        await notesDao.create(note2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid note: relationalId is an invalid UUID v4", () async {
      var note = Note(
          id: id,
          relationalId: "efww",
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await notesDao.create(note.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("relationalId"))));
    });

    test(
        "Invalid note: text length is smaller than ${Notes.MINIMUM_LENGTH_OF_TEXT}",
        () async {
      var note = Note(
          id: id,
          relationalId: relationalId,
          texT: "",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await notesDao.create(note.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
      note = Note(
          id: id,
          relationalId: relationalId,
          texT: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await notesDao.create(note.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
    });

    test(
        "Invalid note: text length is bigger than ${Notes.MAXIMUM_LENGTH_OF_TEXT}",
        () async {
      var note = Note(
          id: id,
          relationalId: relationalId,
          texT: "f" * (Notes.MAXIMUM_LENGTH_OF_TEXT + 1),
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await notesDao.create(note.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
    });

    test("Invalid note: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () async {
        var note = Note(
            id: id,
            relationalId: relationalId,
            texT: texT,
            creationAt: DateTime(2020, 2, 2),
            lastModificationAt: lastModificationAt);
        expect(() async {
          await notesDao.create(note.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });

    test("Invalid note: lastModificationAt is in the future", () {
      withClock(Clock.fixed(DateTime(2021, 1, 1)), () async {
        var note = Note(
            id: id,
            relationalId: relationalId,
            texT: texT,
            creationAt: creationAt,
            lastModificationAt: DateTime(2022, 1, 1));
        expect(() async {
          await notesDao.create(note.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("lastModificationAt"))));
      });
    });

    test("Invalid note: lastModificationAt is before creationAt", () {
      withClock(Clock.fixed(DateTime(2021, 1, 1)), () async {
        var note = Note(
            id: id,
            relationalId: relationalId,
            texT: texT,
            creationAt: DateTime(2020, 1, 1),
            lastModificationAt: DateTime(2019, 1, 1));
        expect(() async {
          await notesDao.create(note.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is SqliteException &&
                e.message.contains("last_modification_at"))));
      });
    });

    test("Good case: create Note without 'id'", () async {
      var notesCompanion = NotesCompanion(
          relationalId: Value(relationalId),
          texT: Value(texT),
          creationAt: Value(creationAt),
          lastModificationAt: Value(lastModificationAt));
      await notesDao.create(notesCompanion);
    });
  });

  group("Getting a specific Note by id", () {
    test("Good case: this specific Note is found", () async {
      var note = Note(
          id: id,
          relationalId: relationalId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await notesDao.create(note.toCompanion(true));
      Note? gottenNote = await notesDao.getById(id);
      gottenNote = gottenNote!;
      expect(gottenNote.id, id);
      expect(gottenNote.relationalId, relationalId);
      expect(gottenNote.texT, texT);
    });

    test("Good case: this specific Note is not found", () async {
      Note? gottenNote = await notesDao.getById(const Uuid().v4());
      expect(gottenNote, null);
    });
  });

  test("Getting all notes by relationalId", () async {
    var noteId1 = const Uuid().v4();
    var noteId2 = const Uuid().v4();
    var noteId3 = const Uuid().v4();
    var noteId4 = const Uuid().v4();
    var noteId5 = const Uuid().v4();
    var noteId6 = const Uuid().v4();
    var relationalId1 = const Uuid().v4();
    var relationalId2 = const Uuid().v4();
    var relationalId3 = const Uuid().v4();
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
    var note1 = Note(
        id: noteId1,
        relationalId: relationalId1,
        texT: texT1,
        creationAt: creationAt1,
        lastModificationAt: lastModificationAt1);
    var note2 = Note(
        id: noteId2,
        relationalId: relationalId2,
        texT: texT2,
        creationAt: creationAt2,
        lastModificationAt: lastModificationAt2);
    var note3 = Note(
        id: noteId3,
        relationalId: relationalId3,
        texT: texT3,
        creationAt: creationAt3,
        lastModificationAt: lastModificationAt3);
    var note4 = Note(
        id: noteId4,
        relationalId: relationalId1,
        texT: texT4,
        creationAt: creationAt4,
        lastModificationAt: lastModificationAt4);
    var note5 = Note(
        id: noteId5,
        relationalId: relationalId2,
        texT: texT5,
        creationAt: creationAt5,
        lastModificationAt: lastModificationAt5);
    var note6 = Note(
        id: noteId6,
        relationalId: relationalId1,
        texT: texT6,
        creationAt: creationAt6,
        lastModificationAt: lastModificationAt6);
    await notesDao.create(note1.toCompanion(true));
    await notesDao.create(note2.toCompanion(true));
    await notesDao.create(note3.toCompanion(true));
    await notesDao.create(note4.toCompanion(true));
    await notesDao.create(note5.toCompanion(true));
    await notesDao.create(note6.toCompanion(true));
    Stream<List<Note>> streamNotes =
        notesDao.watchByRelationalId(relationalId1);
    List<Note> notes = await streamNotes.first;
    expect(notes.length, 3);
    var gottenNote = notes[0];
    expect(gottenNote.id, noteId6);
    expect(gottenNote.relationalId, relationalId1);
    expect(gottenNote.texT, texT6);
    expect(gottenNote.creationAt, creationAt6);
    expect(gottenNote.lastModificationAt, lastModificationAt6);
    gottenNote = notes[1];
    expect(gottenNote.id, noteId4);
    expect(gottenNote.relationalId, relationalId1);
    expect(gottenNote.texT, texT4);
    expect(gottenNote.creationAt, creationAt4);
    expect(gottenNote.lastModificationAt, lastModificationAt4);
    gottenNote = notes[2];
    expect(gottenNote.id, noteId1);
    expect(gottenNote.relationalId, relationalId1);
    expect(gottenNote.texT, texT1);
    expect(gottenNote.creationAt, creationAt1);
    expect(gottenNote.lastModificationAt, lastModificationAt1);
    streamNotes = notesDao.watchByRelationalId(relationalId2);
    notes = await streamNotes.first;
    expect(notes.length, 2);
    gottenNote = notes[0];
    expect(gottenNote.id, noteId5);
    expect(gottenNote.relationalId, relationalId2);
    expect(gottenNote.texT, texT5);
    expect(gottenNote.creationAt, creationAt5);
    expect(gottenNote.lastModificationAt, lastModificationAt5);
    gottenNote = notes[1];
    expect(gottenNote.id, noteId2);
    expect(gottenNote.relationalId, relationalId2);
    expect(gottenNote.texT, texT2);
    expect(gottenNote.creationAt, creationAt2);
    expect(gottenNote.lastModificationAt, lastModificationAt2);
    streamNotes = notesDao.watchByRelationalId(relationalId3);
    notes = await streamNotes.first;
    expect(notes.length, 1);
    gottenNote = notes[0];
    expect(gottenNote.id, noteId3);
    expect(gottenNote.relationalId, relationalId3);
    expect(gottenNote.texT, texT3);
    expect(gottenNote.creationAt, creationAt3);
    expect(gottenNote.lastModificationAt, lastModificationAt3);
  });

  group("Update a Note", () {
    setUp(() async {
      var note = Note(
          id: id,
          relationalId: relationalId,
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      await notesDao.create(note.toCompanion(true));
    });

    test("Invalid update: relationalId is an invalid UUID v4", () async {
      var note = Note(
          id: id,
          relationalId: "ehowf",
          texT: texT,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await notesDao.mutate(note.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("relationalId"))));
    });

    test(
        "Invalid update: text length is smaller than ${Notes.MINIMUM_LENGTH_OF_TEXT}",
        () async {
      var note = Note(
          id: id,
          relationalId: relationalId,
          texT: "",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await notesDao.mutate(note.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
      note = Note(
          id: id,
          relationalId: relationalId,
          texT: " ",
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await notesDao.mutate(note.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
    });

    test(
        "Invalid update: text length is bigger than ${Notes.MAXIMUM_LENGTH_OF_TEXT}",
        () async {
      var note = Note(
          id: id,
          relationalId: relationalId,
          texT: "f" * (Notes.MAXIMUM_LENGTH_OF_TEXT + 1),
          creationAt: creationAt,
          lastModificationAt: lastModificationAt);
      expect(() async {
        await notesDao.mutate(note.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("tex_t"))));
    });

    test("Invalid update: creationAt is in the future", () {
      withClock(Clock.fixed(DateTime(2020, 1, 1)), () async {
        var note = Note(
            id: id,
            relationalId: relationalId,
            texT: texT,
            creationAt: DateTime(2020, 2, 2),
            lastModificationAt: lastModificationAt);
        expect(() async {
          await notesDao.mutate(note.toCompanion(true));
        },
            throwsA(predicate((e) =>
                e is InvalidDataException &&
                e.message.contains("creationAt"))));
      });
    });
  });
}
