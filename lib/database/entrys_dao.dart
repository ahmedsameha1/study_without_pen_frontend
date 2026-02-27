import 'package:clock/clock.dart';
import 'package:drift/drift.dart';

import 'app_database.dart';

part 'entrys_dao.g.dart';

@DriftAccessor(tables: [Entrys])
class EntrysDao extends DatabaseAccessor<AppDatabase> with _$EntrysDaoMixin {
  EntrysDao(super.appDatabase);

  Future<int> create(EntrysCompanion entrysCompanion) {
    // the following checks are here because it is hard to write them in a check
    // function in the definition of the table
    if (entrysCompanion.id.present && !isValid(entrysCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (!isValid(entrysCompanion.fieldListId.value)) {
      throw InvalidDataException("fieldListId");
    }
    if (entrysCompanion.creationAt.value.toUtc().isAfter(clock.now().toUtc())) {
      throw InvalidDataException("creationAt");
    }
    if (entrysCompanion.lastModificationAt.value.toUtc().isAfter(
      clock.now().toUtc(),
    )) {
      throw InvalidDataException("lastModificationAt");
    }
    if (entrysCompanion.lastAskedAt.value != null &&
        entrysCompanion.lastAskedAt.value!.toUtc().isAfter(
          clock.now().toUtc(),
        )) {
      throw InvalidDataException('lastAskedAt');
    }
    return into(entrys).insert(entrysCompanion);
  }

  Future<List<Entry>> getAll() {
    return (select(entrys)..orderBy([
          ((tbl) =>
              OrderingTerm(expression: tbl.order, mode: OrderingMode.asc)),
          ((tbl) => OrderingTerm(
            expression: tbl.creationAt,
            mode: OrderingMode.desc,
          )),
        ]))
        .get();
  }

  Stream<List<Entry>> watchByFieldListId(String fieldListId) {
    return (select(entrys)
          ..where((tbl) => tbl.fieldListId.equals(fieldListId))
          ..orderBy([
            ((tbl) =>
                OrderingTerm(expression: tbl.order, mode: OrderingMode.asc)),
            ((tbl) => OrderingTerm(
              expression: tbl.creationAt,
              mode: OrderingMode.desc,
            )),
          ]))
        .watch();
  }

  Future<Entry?> getById(String id) {
    return (select(
      entrys,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Stream<List<Entry>> searchByTextInQuestionOrAnswer(
    String fieldListId,
    String text,
  ) {
    final String searchText = '%$text%';
    return (select(entrys)
          ..where(
            (row) =>
                row.fieldListId.equals(fieldListId) &
                (row.question.like(searchText) | row.answer.like(searchText)),
          )
          ..orderBy([
            ((row) =>
                OrderingTerm(expression: row.order, mode: OrderingMode.asc)),
            ((row) => OrderingTerm(
              expression: row.creationAt,
              mode: OrderingMode.desc,
            )),
          ]))
        .watch();
  }

  Future<bool> mutate(EntrysCompanion entrysCompanion) {
    if (!isValid(entrysCompanion.fieldListId.value)) {
      throw InvalidDataException("fieldListId");
    }
    if (entrysCompanion.creationAt.value.toUtc().isAfter(clock.now().toUtc())) {
      throw InvalidDataException("creationAt");
    }
    if (entrysCompanion.lastModificationAt.value.toUtc().isAfter(
      clock.now().toUtc(),
    )) {
      throw InvalidDataException("lastModificationAt");
    }
    return update(entrys).replace(entrysCompanion);
  }

  Future<int> remove(String id) {
    return (delete(entrys)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<String>?> getHintsByEntryId(String entryId) async {
    final otherEntrys = alias(entrys, "otherEntrys");
    final query = select(entrys).join([
      innerJoin(otherEntrys, otherEntrys.question.equalsExp(entrys.question)),
    ])..where(entrys.id.equals(entryId));
    final result = await query.get();
    if (result.length == 1) {
      return Future.value(null);
    }
    late String thisAnswer;
    var otherAnswers = [];
    for (var row in result) {
      if (row.readTable(otherEntrys).id == entryId) {
        thisAnswer = row.readTable(otherEntrys).answer;
      } else {
        otherAnswers.add(row.readTable(otherEntrys).answer);
      }
    }
    final hints = ["Length: ${thisAnswer.length}"];
    final thisAnswerLength = thisAnswer.length;
    final otherLengthAnswers = [];
    final sameLengthAnswers = [];
    for (var other in otherAnswers) {
      final otherLength = other.length;
      if (thisAnswerLength == otherLength) {
        sameLengthAnswers.add(other);
      } else {
        otherLengthAnswers.add(other);
      }
    }
    if (otherLengthAnswers.length == otherAnswers.length) {
      return hints;
    } else {
      for (var k in sameLengthAnswers) {
        var hint = "";
        for (var i = 0; i < thisAnswerLength; i++) {
          if (thisAnswer[i] != k[i]) {
            hint = "Letter: ${i + 1} is '${thisAnswer[i]}'";
            break;
          }
        }
        if (!hints.contains(hint)) {
          hints.add(hint);
        }
      }
    }
    return hints;
  }
}

enum Rank { low, normal, important, vital }
