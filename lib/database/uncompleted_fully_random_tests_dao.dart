import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part "uncompleted_fully_random_tests_dao.g.dart";

@DriftAccessor(tables: [UncompletedFullyRandomTests])
class UncompletedFullyRandomTestsDao extends DatabaseAccessor<AppDatabase>
    with _$UncompletedFullyRandomTestsDaoMixin {
  UncompletedFullyRandomTestsDao(AppDatabase appDatabase) : super(appDatabase);
  Future<int> create(UncompletedFullyRandomTestsCompanion uncompletedFullyRandomTestsCompanion) {
    if (uncompletedFullyRandomTestsCompanion.id.present &&
        !isValid(uncompletedFullyRandomTestsCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (!isValid(uncompletedFullyRandomTestsCompanion.fieldListId.value)) {
      throw InvalidDataException("fieldListId");
    }
    return into(uncompletedFullyRandomTests).insert(uncompletedFullyRandomTestsCompanion);
  }
}
