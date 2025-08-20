import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

class FieldListsRepositoryLocal implements FieldListsRepository {
  FieldListsRepositoryLocal(this._fieldListsDao);
  final FieldListsDao _fieldListsDao;
  @override
  Stream<List<FieldListEntity>> watch(String fieldId) {
    return _fieldListsDao.watchByFieldId(fieldId).map((list) => list
        .map((fieldList) => FieldListEntity(
            id: fieldList.id,
            fieldId: fieldList.fieldId,
            name: fieldList.name,
            creationAt: fieldList.creationAt,
            lastModificationAt: fieldList.lastModificationAt,
            color: fieldList.color,
            checkType: fieldList.checkType,
            sortBy: fieldList.sortBy,
            usageCount: fieldList.usageCount,
            languageTag: fieldList.languageTag,
            doesObfuscateQuestion: fieldList.doesObfuscateQuestion,
            doesReadAnswer: fieldList.doesReadAnswer,
            testsFindingAnswerDuration: fieldList.testsFindingAnswerDuration,
            testsReadingQuestionLetterDuration:
                fieldList.testsReadingQuestionLetterDuration,
            testsTypingAnswerLetterDuration:
                fieldList.testsTypingAnswerLetterDuration,
            studyTillCorrectFindingAnswerDuration:
                fieldList.studyTillCorrectFindingAnswerDuration,
            studyTillCorrectReadingQuestionLetterDuration:
                fieldList.studyTillCorrectReadingQuestionLetterDuration,
            studyTillCorrectTypingAnswerLetterDuration:
                fieldList.studyTillCorrectTypingAnswerLetterDuration,
            testsTimeOfAnswerAction: fieldList.testsTimeOfAnswerAction,
            emulationDays: fieldList.emulationDays,
            emulationNumberOfQuestions: fieldList.emulationNumberOfQuestions))
        .toList());
  }
}
