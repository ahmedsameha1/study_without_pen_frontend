import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:study_without_pen_by_flutter/database/entry_texts_dao.dart';
import 'package:study_without_pen_by_flutter/database/questions_dao.dart';
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

class EntryTexts extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  TextColumn get value => text()
      .withLength(max: 2000)
      .check(value.trim().length.isBiggerOrEqualValue(1))
      .unique()();

  @override
  Set<Column> get primaryKey => {id};
}

class Questions extends Table {
  TextColumn get id => text().clientDefault(() => const Uuid().v4())();
  IntColumn get questionType => integer()();
  TextColumn get address => text()();

  @override
  Set<Column> get primaryKey => {id};

  @override
  List<Set<Column<Object>>>? get uniqueKeys => <Set<Column<Object>>>[
        {questionType, address}
      ];
}

@DriftDatabase(
    tables: [EntryTexts, Questions], daos: [EntryTextsDao, QuestionsDao])
class AppDatabase extends _$AppDatabase {
  static const databaseFileName = "db.sqlite";
  static LazyDatabase openConnection() {
    return LazyDatabase(() async {
      final dbDirectory = await getApplicationDocumentsDirectory();
      final file = File(join(dbDirectory.path, databaseFileName));
      return NativeDatabase(file);
    });
  }

  AppDatabase(QueryExecutor queryExecutor) : super(queryExecutor);

  @override
  int get schemaVersion => 1;
}
