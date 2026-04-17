import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository_local.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

class MockFieldListsDao extends Mock implements FieldListsDao {}

void main() {
  FieldListsDao fieldListsDao = MockFieldListsDao();
  FieldListsRepository fieldListsRepository = FieldListsRepositoryLocal(
    fieldListsDao,
  );
  FieldListEntity fieldListEntity = FieldListEntity(
    id: "wwoefwwofgwe",
    fieldId: "owefhweo",
    name: "field list name",
    creationAt: DateTime(2020, 1, 1),
    lastModificationAt: DateTime(2020, 1, 1),
  );

  test('watch() throws what fieldListsDao.watchByFieldId() throw', () {
    when(
      () => fieldListsDao.watchByFieldId(fieldListEntity.fieldId),
    ).thenThrow(SqliteException(1, 'sqlexception'));
    expect(
      () => fieldListsRepository.watch(fieldListEntity.fieldId),
      throwsA(
        predicate((e) => e is SqliteException && e.message == 'sqlexception'),
      ),
    );
  });

  test('watch() returns what fieldListsDao.watchByFieldId() return', () {
    when(
      () => fieldListsDao.watchByFieldId(fieldListEntity.fieldId),
    ).thenAnswer(
      (_) => Stream.value([
        FieldList(
          id: fieldListEntity.id!,
          fieldId: fieldListEntity.fieldId,
          name: fieldListEntity.name,
          creationAt: fieldListEntity.creationAt,
          lastModificationAt: fieldListEntity.lastModificationAt,
          checkType: fieldListEntity.checkType.index,
          sortBy: fieldListEntity.sortBy,
          doesReadAnswer: fieldListEntity.doesReadAnswer,
          usageCount: fieldListEntity.usageCount,
          color: fieldListEntity.color,
          testsTimeOfAnswerAction: fieldListEntity.testsTimeOfAnswerAction,
          doesObfuscateQuestion: fieldListEntity.doesObfuscateQuestion,
          studyTillCorrectFindingAnswerDuration:
              fieldListEntity.studyTillCorrectFindingAnswerDuration,
          studyTillCorrectReadingQuestionLetterDuration:
              fieldListEntity.studyTillCorrectReadingQuestionLetterDuration,
          studyTillCorrectTypingAnswerLetterDuration:
              fieldListEntity.studyTillCorrectTypingAnswerLetterDuration,
          testsFindingAnswerDuration:
              fieldListEntity.testsFindingAnswerDuration,
          testsReadingQuestionLetterDuration:
              fieldListEntity.testsReadingQuestionLetterDuration,
          testsTypingAnswerLetterDuration:
              fieldListEntity.testsTypingAnswerLetterDuration,
          languageTag: fieldListEntity.languageTag,
          emulationDays: fieldListEntity.emulationDays,
          emulationNumberOfQuestions:
              fieldListEntity.emulationNumberOfQuestions,
        ),
      ]),
    );
    expect(
      fieldListsRepository.watch(fieldListEntity.fieldId),
      emitsInOrder([
        [fieldListEntity],
      ]),
    );
  });

  test('create() throws what fieldListsDao.create() throw', () {
    when(
      () => fieldListsDao.create(
        FieldListsCompanion(
          fieldId: Value(fieldListEntity.fieldId),
          name: Value(fieldListEntity.name),
          creationAt: Value(fieldListEntity.creationAt),
          lastModificationAt: Value(fieldListEntity.lastModificationAt),
          color: Value(fieldListEntity.color),
          checkType: Value(fieldListEntity.checkType.index),
          sortBy: Value(fieldListEntity.sortBy),
          usageCount: Value(fieldListEntity.usageCount),
          languageTag: Value(fieldListEntity.languageTag),
          doesObfuscateQuestion: Value(fieldListEntity.doesObfuscateQuestion),
          doesReadAnswer: Value(fieldListEntity.doesReadAnswer),
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
          testsTimeOfAnswerAction: Value(
            fieldListEntity.testsTimeOfAnswerAction,
          ),
          emulationDays: Value(fieldListEntity.emulationDays),
          emulationNumberOfQuestions: Value(
            fieldListEntity.emulationNumberOfQuestions,
          ),
        ),
      ),
    ).thenThrow(SqliteException(1, 'sqlexception'));
    expect(
      () => fieldListsRepository.create(fieldListEntity),
      throwsA(
        predicate((e) => e is SqliteException && e.message == 'sqlexception'),
      ),
    );
  });

  test('create() returns what fieldListsDao.create() return', () {
    when(
      () => fieldListsDao.create(
        FieldListsCompanion(
          fieldId: Value(fieldListEntity.fieldId),
          name: Value(fieldListEntity.name),
          creationAt: Value(fieldListEntity.creationAt),
          lastModificationAt: Value(fieldListEntity.lastModificationAt),
          color: Value(fieldListEntity.color),
          checkType: Value(fieldListEntity.checkType.index),
          sortBy: Value(fieldListEntity.sortBy),
          usageCount: Value(fieldListEntity.usageCount),
          languageTag: Value(fieldListEntity.languageTag),
          doesObfuscateQuestion: Value(fieldListEntity.doesObfuscateQuestion),
          doesReadAnswer: Value(fieldListEntity.doesReadAnswer),
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
          testsTimeOfAnswerAction: Value(
            fieldListEntity.testsTimeOfAnswerAction,
          ),
          emulationDays: Value(fieldListEntity.emulationDays),
          emulationNumberOfQuestions: Value(
            fieldListEntity.emulationNumberOfQuestions,
          ),
        ),
      ),
    ).thenAnswer((_) => Future.value(2));
    expectLater(fieldListsRepository.create(fieldListEntity), completion(2));
  });

  test('watchFieldList() throws what FieldListsDao.watchById() throw', () {
    when(
      () => fieldListsDao.watchById(fieldListEntity.id!),
    ).thenThrow(SqliteException(1, 'sqlexception'));
    expect(
      () => fieldListsRepository.watchFieldList(fieldListEntity.id!),
      throwsA(
        predicate((e) => e is SqliteException && e.message == 'sqlexception'),
      ),
    );
  });

  test('watchFieldList() return a stream that emits an error when '
      'FieldListsDao.watchById() stream emits an error', () {
    when(
      () => fieldListsDao.watchById(fieldListEntity.id!),
    ).thenAnswer((_) => Stream.error('Not Found'));
    expect(
      fieldListsRepository.watchFieldList(fieldListEntity.id!),
      emitsError(predicate((e) => e is String && e == 'Not Found')),
    );
  });

  test(
    'watchFieldList() returns what fieldListsDao.watchByFieldId() return',
    () {
      when(() => fieldListsDao.watchById(fieldListEntity.id!)).thenAnswer(
        (_) => Stream.value(
          FieldList(
            id: fieldListEntity.id!,
            fieldId: fieldListEntity.fieldId,
            name: fieldListEntity.name,
            creationAt: fieldListEntity.creationAt,
            lastModificationAt: fieldListEntity.lastModificationAt,
            checkType: fieldListEntity.checkType.index,
            sortBy: fieldListEntity.sortBy,
            doesReadAnswer: fieldListEntity.doesReadAnswer,
            usageCount: fieldListEntity.usageCount,
            color: fieldListEntity.color,
            testsTimeOfAnswerAction: fieldListEntity.testsTimeOfAnswerAction,
            doesObfuscateQuestion: fieldListEntity.doesObfuscateQuestion,
            studyTillCorrectFindingAnswerDuration:
                fieldListEntity.studyTillCorrectFindingAnswerDuration,
            studyTillCorrectReadingQuestionLetterDuration:
                fieldListEntity.studyTillCorrectReadingQuestionLetterDuration,
            studyTillCorrectTypingAnswerLetterDuration:
                fieldListEntity.studyTillCorrectTypingAnswerLetterDuration,
            testsFindingAnswerDuration:
                fieldListEntity.testsFindingAnswerDuration,
            testsReadingQuestionLetterDuration:
                fieldListEntity.testsReadingQuestionLetterDuration,
            testsTypingAnswerLetterDuration:
                fieldListEntity.testsTypingAnswerLetterDuration,
            languageTag: fieldListEntity.languageTag,
            emulationDays: fieldListEntity.emulationDays,
            emulationNumberOfQuestions:
                fieldListEntity.emulationNumberOfQuestions,
          ),
        ),
      );
      expect(
        fieldListsRepository.watchFieldList(fieldListEntity.id!),
        emitsInOrder([fieldListEntity]),
      );
    },
  );
}
