import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

void main() {
  test(
      'FieldListEntity fieldId, creationAt, and lastModificationAt have the correct values',
      () {
    final fieldListEntity = FieldListEntity(
      fieldId: "woehwfgehfg",
      name: "field list name",
      creationAt: DateTime(2020, 2, 20),
      lastModificationAt: DateTime(2020, 2, 20),
    );
    expect(
      fieldListEntity.fieldId,
      "woehwfgehfg",
    );
    expect(fieldListEntity.creationAt, DateTime(2020, 2, 20));
    expect(fieldListEntity.lastModificationAt, DateTime(2020, 2, 20));
  });

  test('FieldListEntity throws AssertionError when created with invalid name',
      () {
    expect(
        () => FieldListEntity(
              fieldId: "woehwfgehfg",
              name: "",
              creationAt: DateTime(2020, 2, 20),
              lastModificationAt: DateTime(2020, 2, 20),
            ),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'FieldList name must be between ${FieldLists.MINIMUM_LENGTH_OF_NAME} and ${FieldLists.MAXIMUM_LENGTH_OF_NAME} characters')));
    expect(
        () => FieldListEntity(
              fieldId: "woehwfgehfg",
              name: "r" * 65,
              creationAt: DateTime(2020, 2, 20),
              lastModificationAt: DateTime(2020, 2, 20),
            ),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'FieldList name must be between ${FieldLists.MINIMUM_LENGTH_OF_NAME} and ${FieldLists.MAXIMUM_LENGTH_OF_NAME} characters')));
  });
  test('FieldListEntity name has the correct value', () {
    final fieldListEntity = FieldListEntity(
      fieldId: "woehwfgehfg",
      name: "field list name",
      creationAt: DateTime(2020, 2, 20),
      lastModificationAt: DateTime(2020, 2, 20),
    );
    expect(fieldListEntity.name, "field list name");
  });

  test(
      'FieldListEntity throws AssertionError when created with invalid checkType',
      () {
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            checkType: CheckType.MAX.index),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'checkType must be bigger than or equal 0 and smaller than ${CheckType.MAX.index}')));
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            checkType: -1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'checkType must be bigger than or equal 0 and smaller than ${CheckType.MAX.index}')));
  });
  test('FieldListEntity checkType default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.checkType, 0);
  });
  test('FieldListEntity checkType has the correct value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        checkType: 1);
    expect(fieldListEntity.checkType, 1);
  });

  test('FieldListEntity throws AssertionError when created with invalid sortBy',
      () {
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            sortBy: SortBy.MAX.index),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'sortBy must be bigger than or equal 0 and smaller than ${SortBy.MAX.index}')));
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            sortBy: -1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'sortBy must be bigger than or equal 0 and smaller than ${SortBy.MAX.index}')));
  });
  test('FieldListEntity sortBy default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.sortBy, 0);
  });
  test('FieldListEntity sortBy has the correct value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        sortBy: 12);
    expect(fieldListEntity.sortBy, 12);
  });

  test(
      'FieldListEntity throws AssertionError when created with invalid usageCount',
      () {
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            usageCount: FieldLists.MAXIMUM_USAGE_COUNT + 1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'usageCount must be bigger than or equal ${FieldLists.MINIMUM_USAGE_COUNT} '
                    'and smaller than or equal ${FieldLists.MAXIMUM_USAGE_COUNT}')));
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            usageCount: FieldLists.MINIMUM_USAGE_COUNT - 1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'usageCount must be bigger than or equal ${FieldLists.MINIMUM_USAGE_COUNT} '
                    'and smaller than or equal ${FieldLists.MAXIMUM_USAGE_COUNT}')));
  });
  test('FieldListEntity usageCount default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.usageCount, 0);
  });
  test('FieldListEntity usageCount has the correct value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        usageCount: 12);
    expect(fieldListEntity.usageCount, 12);
  });

  test('FieldListEntity throws AssertionError when created with invalid color',
      () {
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            color: FieldLists.MAXIMUM_COLOR + 1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'color must be bigger than or equal ${FieldLists.MINIMUM_COLOR} '
                    'and smaller than or equal ${FieldLists.MAXIMUM_COLOR}')));
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            color: FieldLists.MINIMUM_COLOR - 1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'color must be bigger than or equal ${FieldLists.MINIMUM_COLOR} '
                    'and smaller than or equal ${FieldLists.MAXIMUM_COLOR}')));
  });
  test('FieldListEntity color default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.color, FieldLists.MAXIMUM_COLOR);
  });
  test('FieldListEntity color has the correct value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        color: 0x22222222);
    expect(fieldListEntity.color, 0x22222222);
  });

  test(
      'FieldListEntity throws AssertionError when created with invalid emulationNumberOfQuestions',
      () {
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            emulationNumberOfQuestions:
                FieldLists.MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS + 1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'emulationNumberOfQuestions must be bigger than or equal ${FieldLists.MINIMUM_EMULATION_NUMBER_OF_QUESTIONS} '
                    'and smaller than or equal ${FieldLists.MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS}')));
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            emulationNumberOfQuestions:
                FieldLists.MINIMUM_EMULATION_NUMBER_OF_QUESTIONS - 1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'emulationNumberOfQuestions must be bigger than or equal ${FieldLists.MINIMUM_EMULATION_NUMBER_OF_QUESTIONS} '
                    'and smaller than or equal ${FieldLists.MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS}')));
  });
  test('FieldListEntity emulationNumberOfQuestions default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.emulationNumberOfQuestions, null);
  });
  test('FieldListEntity emulationNumberOfQuestions has the correct value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        emulationNumberOfQuestions: 12);
    expect(fieldListEntity.emulationNumberOfQuestions, 12);
  });

  test(
      'FieldListEntity throws AssertionError when created with invalid testsReadingQuestionLetterDuration',
      () {
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            testsReadingQuestionLetterDuration:
                FieldLists.MINIMUM_TESTS_DURATIONS - 1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'testsReadingQuestionLetterDuration must be bigger than or equal ${FieldLists.MINIMUM_TESTS_DURATIONS}')));
  });
  test('FieldListEntity testsReadingQuestionLetterDuration default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.testsReadingQuestionLetterDuration, null);
  });
  test(
      'FieldListEntity testsReadingQuestionLetterDuration has the correct value',
      () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        testsReadingQuestionLetterDuration: 12);
    expect(fieldListEntity.testsReadingQuestionLetterDuration, 12);
  });
  test(
      'FieldListEntity throws AssertionError when created with invalid testsFindingAnswerDuration',
      () {
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            testsFindingAnswerDuration: FieldLists.MINIMUM_TESTS_DURATIONS - 1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'testsFindingAnswerDuration must be bigger than or equal ${FieldLists.MINIMUM_TESTS_DURATIONS}')));
  });
  test('FieldListEntity testsFindingAnswerDuration default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.testsFindingAnswerDuration, null);
  });
  test('FieldListEntity testsFindingAnswerDuration has the correct value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        testsFindingAnswerDuration: 12);
    expect(fieldListEntity.testsFindingAnswerDuration, 12);
  });
  test(
      'FieldListEntity throws AssertionError when created with invalid testsTypingAnswerLetterDuration',
      () {
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            testsTypingAnswerLetterDuration:
                FieldLists.MINIMUM_TESTS_DURATIONS - 1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'testsTypingAnswerLetterDuration must be bigger than or equal ${FieldLists.MINIMUM_TESTS_DURATIONS}')));
  });
  test('FieldListEntity testsTypingAnswerLetterDuration default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.testsTypingAnswerLetterDuration, null);
  });
  test('FieldListEntity testsTypingAnswerLetterDuration has the correct value',
      () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        testsTypingAnswerLetterDuration: 12);
    expect(fieldListEntity.testsTypingAnswerLetterDuration, 12);
  });
  test(
      'FieldListEntity throws AssertionError when created with invalid studyTillCorrectReadingQuestionLetterDuration',
      () {
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            studyTillCorrectReadingQuestionLetterDuration:
                FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS - 1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'studyTillCorrectReadingQuestionLetterDuration must be bigger than or equal ${FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS}')));
  });
  test(
      'FieldListEntity studyTillCorrectReadingQuestionLetterDuration default value',
      () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.studyTillCorrectReadingQuestionLetterDuration, null);
  });
  test(
      'FieldListEntity studyTillCorrectReadingQuestionLetterDuration has the correct value',
      () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        studyTillCorrectReadingQuestionLetterDuration: 12);
    expect(fieldListEntity.studyTillCorrectReadingQuestionLetterDuration, 12);
  });
  test(
      'FieldListEntity throws AssertionError when created with invalid studyTillCorrectFindingAnswerDuration',
      () {
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            studyTillCorrectFindingAnswerDuration:
                FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS - 1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'studyTillCorrectFindingAnswerDuration must be bigger than or equal ${FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS}')));
  });
  test('FieldListEntity studyTillCorrectFindingAnswerDuration default value',
      () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.studyTillCorrectFindingAnswerDuration, null);
  });
  test(
      'FieldListEntity studyTillCorrectFindingAnswerDuration has the correct value',
      () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        studyTillCorrectFindingAnswerDuration: 12);
    expect(fieldListEntity.studyTillCorrectFindingAnswerDuration, 12);
  });
  test(
      'FieldListEntity throws AssertionError when created with invalid studyTillCorrectTypingAnswerLetterDuration',
      () {
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            studyTillCorrectTypingAnswerLetterDuration:
                FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS - 1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'studyTillCorrectTypingAnswerLetterDuration must be bigger than or equal ${FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS}')));
  });
  test(
      'FieldListEntity studyTillCorrectTypingAnswerLetterDuration default value',
      () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.studyTillCorrectTypingAnswerLetterDuration, null);
  });
  test(
      'FieldListEntity studyTillCorrectTypingAnswerLetterDuration has the correct value',
      () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        studyTillCorrectTypingAnswerLetterDuration: 12);
    expect(fieldListEntity.studyTillCorrectTypingAnswerLetterDuration, 12);
  });
  test(
      'FieldListEntity throws AssertionError when created with invalid testsTimeOfAnswerAction',
      () {
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            testsTimeOfAnswerAction: 2),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'testsTimeOfAnswerAction must be bigger than or equal 0 '
                    'and smaller than ${TimeOfAnswerAction.MAX.index}')));
    expect(
        () => FieldListEntity(
            fieldId: "woehwfgehfg",
            name: "field list name",
            creationAt: DateTime(2020, 2, 20),
            lastModificationAt: DateTime(2020, 2, 20),
            testsTimeOfAnswerAction: -1),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message ==
                'testsTimeOfAnswerAction must be bigger than or equal 0 '
                    'and smaller than ${TimeOfAnswerAction.MAX.index}')));
  });
  test('FieldListEntity testsTimeOfAnswerAction default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.testsTimeOfAnswerAction, 1);
  });
  test('FieldListEntity testsTimeOfAnswerAction has the correct value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        testsTimeOfAnswerAction: 0);
    expect(fieldListEntity.testsTimeOfAnswerAction, 0);
  });

  test('FieldListEntity languageTag default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.languageTag, null);
  });
  test('FieldListEntity languageTag has the correct value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        languageTag: "es");
    expect(fieldListEntity.languageTag, "es");
  });

  test('FieldListEntity doesReadAnswer default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.doesReadAnswer, false);
  });
  test('FieldListEntity doesReadAnswer has the correct value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        doesReadAnswer: true);
    expect(fieldListEntity.doesReadAnswer, true);
  });

  test('FieldListEntity emulationDays default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.emulationDays, null);
  });
  test('FieldListEntity emulationDays has the correct value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        emulationDays: "wefhn");
    expect(fieldListEntity.emulationDays, "wefhn");
  });

  test('FieldListEntity doesObfuscateQuestion default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.doesObfuscateQuestion, false);
  });
  test('FieldListEntity doesObfuscateQuestion has the correct value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        doesObfuscateQuestion: true);
    expect(fieldListEntity.doesObfuscateQuestion, true);
  });

  test('FieldListEntity id default value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20));
    expect(fieldListEntity.id, null);
  });
  test('FieldListEntity id has the correct value', () {
    final fieldListEntity = FieldListEntity(
        fieldId: "woehwfgehfg",
        name: "field list name",
        creationAt: DateTime(2020, 2, 20),
        lastModificationAt: DateTime(2020, 2, 20),
        id: "woeghegh");
    expect(fieldListEntity.id, "woeghegh");
  });
}
