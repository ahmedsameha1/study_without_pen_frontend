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

  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    notesDao = NotesDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create a note", () {
    test("Invalid note: id is an invalid UUID v4", () async {
      var note = Note(id: "wew", relationalId: relationalId);
      expect(() async {
        await notesDao.create(note.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is InvalidDataException && e.message.contains("id"))));
    });

    test("No Notes with the same id", () async {
      var note1 = Note(id: id, relationalId: relationalId);
      var note2 = Note(id: id, relationalId: relationalId);
      expect(() async {
        await notesDao.create(note1.toCompanion(true));
        await notesDao.create(note2.toCompanion(true));
      },
          throwsA(predicate(
              (e) => e is SqliteException && e.message.contains("id"))));
    });

    test("Invalid note: relationalId is an invalid UUID v4", () async {
      var note = Note(id: id, relationalId: "efww");
      expect(() async {
        await notesDao.create(note.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException &&
              e.message.contains("relationalId"))));
    });

    test("Good case: create Note without 'id'", () async {
      var notesCompanion = NotesCompanion(relationalId: Value(relationalId));
      await notesDao.create(notesCompanion);
    });
  });
}
