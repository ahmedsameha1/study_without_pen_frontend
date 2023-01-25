import 'package:drift/drift.dart';

import 'app_database.dart';
import 'entry_texts_dao.dart';

part 'questions_dao.g.dart';

@DriftAccessor(tables: [Questions])
class QuestionsDao extends DatabaseAccessor<AppDatabase>
    with _$QuestionsDaoMixin {
  QuestionsDao(AppDatabase appDatabase) : super(appDatabase);

  Future<int> create(Question question) {
    if (!isValid(question.id)) {
      throw InvalidDataException("id");
    }
    if (question.questionType == QuestionType.EntryTextQuestion.index && !isValid(question.address)) {
      throw InvalidDataException("address");
    }
    return into(questions).insert(question);
  }
}

enum QuestionType {EntryTextQuestion}