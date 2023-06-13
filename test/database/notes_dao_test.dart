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
}
