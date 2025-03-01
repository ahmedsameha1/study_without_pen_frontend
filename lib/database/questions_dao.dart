import 'package:drift/drift.dart';
import 'package:study_without_pen_by_flutter/database/entry_texts_dao.dart';

import 'app_database.dart';

part 'questions_dao.g.dart';

@DriftAccessor(tables: [Questions])
class QuestionsDao extends DatabaseAccessor<AppDatabase>
    with _$QuestionsDaoMixin {
  QuestionsDao(AppDatabase appDatabase) : super(appDatabase);

  Future<int> create(QuestionsCompanion questionsCompanion) async {
    EntryTextsDao entryTextsDao = EntryTextsDao(attachedDatabase);
    if (questionsCompanion.id.present &&
        !isValid(questionsCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (questionsCompanion.questionType.value !=
        QuestionType.EntryTextQuestion.index) {
      throw InvalidDataException("questionType");
    }
    if (!isValid(questionsCompanion.address.value)) {
      throw InvalidDataException("address");
    }
    final entryText =
        await entryTextsDao.getById(questionsCompanion.address.value);
    if (entryText == null) {
      throw InvalidDataException("address");
    }
    return into(questions).insert(questionsCompanion);
  }

  Future<int> remove(String id) {
    return (delete(questions)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<Question?> getById(String id) {
    return (select(questions)..where(((tbl) => tbl.id.equals(id))))
        .getSingleOrNull();
  }

  Future<List<Question>> getAll() {
    return select(questions).get();
  }
}

enum QuestionType { EntryTextQuestion }
