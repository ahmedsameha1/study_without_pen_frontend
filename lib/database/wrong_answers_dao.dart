import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/sessions_dao.dart';

part 'wrong_answers_dao.g.dart';

@DriftAccessor(tables: [WrongAnswers])
class WrongAnswersDao extends DatabaseAccessor<AppDatabase>
    with _$WrongAnswersDaoMixin {
  WrongAnswersDao(AppDatabase appDatabase) : super(appDatabase);
  Future<int> create(WrongAnswersCompanion wrongAnswersCompanion) async {
    if (wrongAnswersCompanion.id.present &&
        !isValid(wrongAnswersCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (!isValid(wrongAnswersCompanion.sessionId.value)) {
      throw InvalidDataException("sessionId");
    }
    if (!isValid(wrongAnswersCompanion.entryId.value)) {
      throw InvalidDataException("entryId");
    }
    final sessionsDao = SessionsDao(attachedDatabase);
    final session =
        await sessionsDao.getById(wrongAnswersCompanion.sessionId.value);
    if (session != null &&
        wrongAnswersCompanion.creationAt.value
            .toUtc()
            .isBefore(session.creationAt)) {
      throw InvalidDataException("creationAt is before the session creationAt");
    }
    return into(wrongAnswers).insert(wrongAnswersCompanion);
  }

  Future<List<WrongAnswer>> getBySessionIdAndEntryId(
      String sessionId, String entryId) {
    return (select(wrongAnswers)
          ..where((tbl) =>
              tbl.sessionId.equals(sessionId) & tbl.entryId.equals(entryId))
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: tbl.creationAt, mode: OrderingMode.asc),
          ]))
        .get();
  }
}
