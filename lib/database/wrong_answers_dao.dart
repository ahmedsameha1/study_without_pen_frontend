import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part 'wrong_answers_dao.g.dart';

@DriftAccessor(tables: [WrongAnswers])
class WrongAnswersDao extends DatabaseAccessor<AppDatabase>
    with _$WrongAnswersDaoMixin {
  WrongAnswersDao(AppDatabase appDatabase) : super(appDatabase);
  Future<int> create(WrongAnswersCompanion wrongAnswersCompanion) {
    if (!isValid(wrongAnswersCompanion.sessionId.value)) {
      throw InvalidDataException("sessionId");
    }
    if (!isValid(wrongAnswersCompanion.entryId.value)) {
      throw InvalidDataException("entryId");
    }
    return into(wrongAnswers).insert(wrongAnswersCompanion);
  }
}
