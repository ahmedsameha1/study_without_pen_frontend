import 'package:clock/clock.dart';
import 'package:drift/drift.dart';

import 'app_database.dart';

part 'entrys_dao.g.dart';

@DriftAccessor(tables: [Entrys])
class EntrysDao extends DatabaseAccessor<AppDatabase> with _$EntrysDaoMixin {
  EntrysDao(AppDatabase appDatabase) : super(appDatabase);

  Future<int> create(EntrysCompanion entrysCompanion) {
    if (entrysCompanion.id.present && !isValid(entrysCompanion.id.value)) {
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
    if (entrysCompanion.creationAt.value.toUtc().isAfter(clock.now().toUtc())) {
      throw InvalidDataException("creationAt");
    }
    if (entrysCompanion.lastModificationAt.value
        .toUtc()
        .isAfter(clock.now().toUtc())) {
      throw InvalidDataException("lastModificationAt");
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

  Future<List<Entry>> getByFieldListId(String fieldListId) {
    return (select(entrys)
          ..where((tbl) => tbl.fieldListId.equals(fieldListId))
          ..orderBy([
            ((tbl) =>
                OrderingTerm(expression: tbl.order, mode: OrderingMode.asc)),
            ((tbl) => OrderingTerm(
                expression: tbl.creationAt, mode: OrderingMode.desc)),
          ]))
        .get();
  }

  Future<Entry?> getById(String id) {
    return (select(entrys)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
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
    if (entrysCompanion.creationAt.value.toUtc().isAfter(clock.now().toUtc())) {
      throw InvalidDataException("creationAt");
    }
    if (entrysCompanion.lastModificationAt.value
        .toUtc()
        .isAfter(clock.now().toUtc())) {
      throw InvalidDataException("lastModificationAt");
    }
    if (entrysCompanion.rank.value != Rank.Normal.index) {
      throw InvalidDataException("rank");
    }
    return update(entrys).replace(entrysCompanion);
  }

  remove(String id) {
    return (delete(entrys)..where((tbl) => tbl.id.equals(id))).go();
  }

  Stream<List<String>?> getHintsByEntryId(String entryId) {
    return Stream.value(null);
  }
}

enum Rank { Normal }
