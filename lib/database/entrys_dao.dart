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

  Future<List<String>?> getHintsByEntryId(String entryId) async {
    final otherEntrys = alias(entrys, "otherEntrys");
    final query = select(entrys).join([
      innerJoin(
          otherEntrys, otherEntrys.questionId.equalsExp(entrys.questionId)),
      innerJoin(attachedDatabase.entryTexts,
          attachedDatabase.entryTexts.id.equalsExp(otherEntrys.answerId))
    ])
      ..where(entrys.id.equals(entryId));
    final result = await query.get();
    if (result.length == 1) {
      return Future.value(null);
    }
    var thisAnswer;
    var otherAnswers = [];
    result.forEach((row) {
      if (row.readTable(otherEntrys).id == entryId) {
        thisAnswer = row.readTable(attachedDatabase.entryTexts).value;
      } else {
        otherAnswers.add(row.readTable(attachedDatabase.entryTexts).value);
      }
    });
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
      final diffsWithSameLength = <int>[];
      for (var i = 0; i < thisAnswerLength; i++) {
        diffsWithSameLength.add(0);
        final thisLetter = thisAnswer[i];
        for (var k in sameLengthAnswers) {
          if (k.length > i) {
            if (thisLetter != k[i]) {
              diffsWithSameLength[i]++;
            }
          } else {
            diffsWithSameLength[i]++;
          }
        }
      }
      print(diffsWithSameLength);
      var accumelate = 0;
      outerloop:
      for (var k = sameLengthAnswers.length; k > 0; k--) {
        var alldiff = diffsWithSameLength.indexOf(k);
        if (alldiff == -1) {
          continue;
        } else {
          do {
            hints.add("Letter: ${alldiff + 1} is '${thisAnswer[alldiff]}'");
            accumelate += k;
            if (accumelate >= sameLengthAnswers.length) {
              break outerloop;
            }
            alldiff = diffsWithSameLength.indexOf(k, alldiff + 1);
          } while (alldiff != -1);
        }
      }
    }
    return hints;
  }
}

enum Rank { Normal }
