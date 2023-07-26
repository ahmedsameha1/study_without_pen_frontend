import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/session_entrys_dao.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';

void main() {
  late AppDatabase appDatabase;
  late SessionEntrysDao sessionEntrysDao;
  final entryId = Uuid().v4();
  setUp(() {
    appDatabase = AppDatabase(NativeDatabase.memory());
    sessionEntrysDao = SessionEntrysDao(appDatabase);
  });

  tearDown(() async {
    await appDatabase.close();
  });

  group("Create SessionEntry", () {
    test("Invalid SessionEntry: sessionId is an invalid UUID v4", () async {
      final sessionEntry = SessionEntry(sessionId: "wef", entryId: entryId);
      expect(() async {
        await sessionEntrysDao.create(sessionEntry.toCompanion(true));
      },
          throwsA(predicate((e) =>
              e is InvalidDataException && e.message.contains("sessionId"))));
    });
  });
}
