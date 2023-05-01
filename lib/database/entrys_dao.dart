import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/entry_texts_dao.dart';

import 'app_database.dart';

part 'entrys_dao.g.dart';

@DriftAccessor(tables: [Entrys])
class EntrysDao extends DatabaseAccessor<AppDatabase> with _$EntrysDaoMixin {
  EntrysDao(AppDatabase appDatabase) : super(appDatabase);

  Future<int> create(EntrysCompanion entrysCompanion) {
    if (!isValid(entrysCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (!isValid(entrysCompanion.fieldListId.value)) {
      throw InvalidDataException("fieldListId");
    }
    if (!isValid(entrysCompanion.answerId.value)) {
      throw InvalidDataException("answerId");
    }
    if (!isValid(entrysCompanion.questionId.value)) {
      throw InvalidDataException("questionId");
    }
    if (entrysCompanion.rank.value != Rank.Normal.index) {
      throw InvalidDataException("rank");
    }
    return into(entrys).insert(entrysCompanion);
  }

  Future<List<Entry>> getAll() {
    return (select(entrys)
          ..orderBy([
            ((tbl) =>
                OrderingTerm(expression: tbl.order, mode: OrderingMode.asc)),
            ((tbl) => OrderingTerm(
                expression: tbl.creationAt, mode: OrderingMode.desc)),
          ]))
        .get();
  }

  Future<Entry> getById(String id) {
    return (select(entrys)..where(((tbl) => tbl.id.equals(id)))).getSingle();
  }

  Future<bool> mutate(EntrysCompanion entrysCompanion) {
    if (!isValid(entrysCompanion.fieldListId.value)) {
      throw InvalidDataException("fieldListId");
    }
    if (!isValid(entrysCompanion.answerId.value)) {
      throw InvalidDataException("answerId");
    }
    if (!isValid(entrysCompanion.questionId.value)) {
      throw InvalidDataException("questionId");
    }
    if (entrysCompanion.rank.value != Rank.Normal.index) {
      throw InvalidDataException("rank");
    }
    return update(entrys).replace(entrysCompanion);
  }
}

enum Rank { Normal }
