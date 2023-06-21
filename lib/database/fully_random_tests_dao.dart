import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part "fully_random_tests_dao.g.dart";

@DriftAccessor(tables: [FullyRandomTests])
class FullyRandomTestsDao extends DatabaseAccessor<AppDatabase>
    with _$FullyRandomTestsDaoMixin {
  FullyRandomTestsDao(AppDatabase appDatabase) : super(appDatabase);
  create(FullyRandomTestsCompanion fullyRandomTestsCompanion) {
    if (fullyRandomTestsCompanion.id.present &&
        !isValid(fullyRandomTestsCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (!isValid(fullyRandomTestsCompanion.fieldListId.value)) {
      throw InvalidDataException("fieldListId");
    }
    return into(fullyRandomTests).insert(fullyRandomTestsCompanion);
  }
}
