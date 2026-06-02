import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';
import '../../../../database/field_lists_dao.dart';
import '../../domain/models/field_list_entity.dart';
import 'field_lists_repository.dart';

class FieldListsRepositoryLocal implements FieldListsRepository {
  FieldListsRepositoryLocal(this._fieldListsDao);
  final FieldListsDao _fieldListsDao;
  @override
  Stream<List<(FieldListEntity, int)>> watchWithEntriesCountByFieldId(
    String fieldId,
  ) => _fieldListsDao
      .watchWithEntriesCountByFieldId(fieldId)
      .map(
        (List<(FieldList, int)> list) => list
            .map(
              (record) => (
                FieldListEntity(
                  id: record.$1.id,
                  fieldId: record.$1.fieldId,
                  name: record.$1.name,
                  creationAt: record.$1.creationAt,
                  lastModificationAt: record.$1.lastModificationAt,
                  color: record.$1.color,
                  checkType: switch (record.$1.checkType) {
                    0 => CheckType.NON_STRICT_IGNORE_CASE,
                    1 => CheckType.NON_STRICT_DO_NOT_IGNORE_CASE,
                    2 => CheckType.IGNORE_CASE,
                    3 => CheckType.DO_NOT_IGNORE_CASE,
                    _ => throw ArgumentError(),
                  },
                  sortBy: record.$1.sortBy,
                  usageCount: record.$1.usageCount,
                  languageTag: record.$1.languageTag,
                  doesObfuscateQuestion: record.$1.doesObfuscateQuestion,
                  doesReadAnswer: record.$1.doesReadAnswer,
                  testsFindingAnswerDuration:
                      record.$1.testsFindingAnswerDuration,
                  testsReadingQuestionLetterDuration:
                      record.$1.testsReadingQuestionLetterDuration,
                  testsTypingAnswerLetterDuration:
                      record.$1.testsTypingAnswerLetterDuration,
                  studyTillCorrectFindingAnswerDuration:
                      record.$1.studyTillCorrectFindingAnswerDuration,
                  studyTillCorrectReadingQuestionLetterDuration:
                      record.$1.studyTillCorrectReadingQuestionLetterDuration,
                  studyTillCorrectTypingAnswerLetterDuration:
                      record.$1.studyTillCorrectTypingAnswerLetterDuration,
                  testsTimeOfAnswerAction: record.$1.testsTimeOfAnswerAction,
                  emulationDays: record.$1.emulationDays,
                  emulationNumberOfQuestions:
                      record.$1.emulationNumberOfQuestions,
                ),
                record.$2,
              ),
            )
            .toList(),
      );

  @override
  Future<int> create(FieldListEntity fieldListEntity) => _fieldListsDao.create(
    FieldListsCompanion(
      fieldId: Value(fieldListEntity.fieldId),
      name: Value(fieldListEntity.name),
      checkType: Value(fieldListEntity.checkType.index),
      doesReadAnswer: Value(fieldListEntity.doesReadAnswer),
      color: Value(fieldListEntity.color),
      creationAt: Value(fieldListEntity.creationAt),
      lastModificationAt: Value(fieldListEntity.lastModificationAt),
      sortBy: Value(fieldListEntity.sortBy),
      usageCount: Value(fieldListEntity.usageCount),
      languageTag: Value(fieldListEntity.languageTag),
      doesObfuscateQuestion: Value(fieldListEntity.doesObfuscateQuestion),
      testsFindingAnswerDuration: Value(
        fieldListEntity.testsFindingAnswerDuration,
      ),
      testsReadingQuestionLetterDuration: Value(
        fieldListEntity.testsReadingQuestionLetterDuration,
      ),
      testsTypingAnswerLetterDuration: Value(
        fieldListEntity.testsTypingAnswerLetterDuration,
      ),
      studyTillCorrectFindingAnswerDuration: Value(
        fieldListEntity.studyTillCorrectFindingAnswerDuration,
      ),
      studyTillCorrectReadingQuestionLetterDuration: Value(
        fieldListEntity.studyTillCorrectReadingQuestionLetterDuration,
      ),
      studyTillCorrectTypingAnswerLetterDuration: Value(
        fieldListEntity.studyTillCorrectTypingAnswerLetterDuration,
      ),
      testsTimeOfAnswerAction: Value(fieldListEntity.testsTimeOfAnswerAction),
      emulationDays: Value(fieldListEntity.emulationDays),
      emulationNumberOfQuestions: Value(
        fieldListEntity.emulationNumberOfQuestions,
      ),
    ),
  );

  @override
  Stream<FieldListEntity> watchFieldList(String fieldListId) => _fieldListsDao
      .watchById(fieldListId)
      .map(
        (fieldList) => FieldListEntity(
          id: fieldList.id,
          fieldId: fieldList.fieldId,
          name: fieldList.name,
          creationAt: fieldList.creationAt,
          lastModificationAt: fieldList.lastModificationAt,
          languageTag: fieldList.languageTag,
          checkType: switch (fieldList.checkType) {
            0 => CheckType.NON_STRICT_IGNORE_CASE,
            1 => CheckType.NON_STRICT_DO_NOT_IGNORE_CASE,
            2 => CheckType.IGNORE_CASE,
            3 => CheckType.DO_NOT_IGNORE_CASE,
            _ => throw ArgumentError(),
          },
          sortBy: fieldList.sortBy,
          doesReadAnswer: fieldList.doesReadAnswer,
          usageCount: fieldList.usageCount,
          color: fieldList.color,
          emulationNumberOfQuestions: fieldList.emulationNumberOfQuestions,
          emulationDays: fieldList.emulationDays,
          testsReadingQuestionLetterDuration:
              fieldList.testsReadingQuestionLetterDuration,
          testsFindingAnswerDuration: fieldList.testsFindingAnswerDuration,
          testsTypingAnswerLetterDuration:
              fieldList.testsTypingAnswerLetterDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              fieldList.studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectFindingAnswerDuration:
              fieldList.studyTillCorrectFindingAnswerDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              fieldList.studyTillCorrectTypingAnswerLetterDuration,
          testsTimeOfAnswerAction: fieldList.testsTimeOfAnswerAction,
          doesObfuscateQuestion: fieldList.doesObfuscateQuestion,
        ),
      );
}
