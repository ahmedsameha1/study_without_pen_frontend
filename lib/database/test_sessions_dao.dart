import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part 'test_sessions_dao.g.dart';

@DriftAccessor(tables: [TestSessions])
class TestSessionsDao extends DatabaseAccessor<AppDatabase>
    with _$TestSessionsDaoMixin {
  TestSessionsDao(AppDatabase appDatabase) : super(appDatabase);
  Future<int> create(TestSessionsCompanion testSessionsCompanion) {
    if (!isValid(testSessionsCompanion.sessionId.value)) {
      throw InvalidDataException("sessionId");
    }
    return into(testSessions).insert(testSessionsCompanion);
  }
}
