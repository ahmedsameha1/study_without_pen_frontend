import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part "sessions_dao.g.dart";

@DriftAccessor(tables: [Sessions])
class SessionsDao extends DatabaseAccessor<AppDatabase>
    with _$SessionsDaoMixin {
  SessionsDao(AppDatabase appDatabase) : super(appDatabase);
  Future<int> create(SessionsCompanion sessionsCompanion) {
    if (sessionsCompanion.id.present && !isValid(sessionsCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (!isValid(sessionsCompanion.fieldListId.value)) {
      throw InvalidDataException("fieldListId");
    }
    if (sessionsCompanion.creationAt.value
        .toUtc()
        .isAfter(clock.now().toUtc())) {
      throw InvalidDataException("creationAt");
    }
    if (sessionsCompanion.lastModificationAt.value
        .toUtc()
        .isAfter(clock.now().toUtc())) {
      throw InvalidDataException("lastModificationAt");
    }
    return into(sessions).insert(sessionsCompanion);
  }

  Future<Session?> getById(String id) {
    return (select(sessions)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<Session>> getByFieldListId(String fieldListId) {
    return (select(sessions)
          ..where(
            (tbl) => tbl.fieldListId.equals(fieldListId),
          )
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: tbl.isCompleted, mode: OrderingMode.asc),
            (tbl) => OrderingTerm(
                expression: tbl.lastModificationAt, mode: OrderingMode.desc)
          ]))
        .get();
  }

  Future<bool> mutate(SessionsCompanion sessionsCompanion) async {
    if (sessionsCompanion.creationAt.value
        .toUtc()
        .isAfter(clock.now().toUtc())) {
      throw InvalidDataException("creationAt");
    }
    if (sessionsCompanion.lastModificationAt.value
        .toUtc()
        .isAfter(clock.now().toUtc())) {
      throw InvalidDataException("lastModificationAt");
    }
    var gotten = await getById(sessionsCompanion.id.value);
    if (gotten != null &&
        (gotten.fieldListId != sessionsCompanion.fieldListId.value)) {
      throw InvalidDataException("Updating fieldListId");
    }
    return update(sessions).replace(sessionsCompanion);
  }

  Future<int> remove(String id) {
    return (delete(sessions)
          ..where(
            (tbl) => tbl.id.equals(id),
          ))
        .go();
  }
}
