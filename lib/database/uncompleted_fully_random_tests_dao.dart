import 'package:clock/clock.dart';
import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part "uncompleted_fully_random_tests_dao.g.dart";

@DriftAccessor(tables: [UncompletedFullyRandomTests])
class UncompletedFullyRandomTestsDao extends DatabaseAccessor<AppDatabase>
    with _$UncompletedFullyRandomTestsDaoMixin {
  UncompletedFullyRandomTestsDao(AppDatabase appDatabase) : super(appDatabase);
  Future<int> create(
      UncompletedFullyRandomTestsCompanion
          uncompletedFullyRandomTestsCompanion) {
    if (uncompletedFullyRandomTestsCompanion.id.present &&
        !isValid(uncompletedFullyRandomTestsCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (!isValid(uncompletedFullyRandomTestsCompanion.fieldListId.value)) {
      throw InvalidDataException("fieldListId");
    }
    if (uncompletedFullyRandomTestsCompanion.creationAt.value
        .toUtc()
        .isAfter(clock.now().toUtc())) {
      throw InvalidDataException("creationAt");
    }
    if (uncompletedFullyRandomTestsCompanion.lastModificationAt.value
        .toUtc()
        .isAfter(clock.now().toUtc())) {
      throw InvalidDataException("lastModificationAt");
    }
    return into(uncompletedFullyRandomTests)
        .insert(uncompletedFullyRandomTestsCompanion);
  }

  Future<UncompletedFullyRandomTest?> getById(String id) {
    return (select(uncompletedFullyRandomTests)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<UncompletedFullyRandomTest>> getByFieldListId(
      String fieldListId) {
    return (select(uncompletedFullyRandomTests)
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

  Future mutate(
      UncompletedFullyRandomTestsCompanion
          uncompletedFullyRandomTestsCompanion) {
    return (update(uncompletedFullyRandomTests)
          ..where((tbl) =>
              tbl.id.equals(uncompletedFullyRandomTestsCompanion.id.value)))
        .write(uncompletedFullyRandomTestsCompanion);
  }
}
