import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part 'field_list_entity.freezed.dart';

@freezed
abstract class FieldListEntity with _$FieldListEntity {
  FieldListEntity._({
    required this.name,
    required this.checkType,
    required this.sortBy,
    required this.usageCount,
    required this.color,
    required this.emulationNumberOfQuestions,
    required this.testsReadingQuestionLetterDuration,
    required this.testsFindingAnswerDuration,
    required this.testsTypingAnswerLetterDuration,
    required this.studyTillCorrectReadingQuestionLetterDuration,
    required this.studyTillCorrectFindingAnswerDuration,
    required this.studyTillCorrectTypingAnswerLetterDuration,
    required this.testsTimeOfAnswerAction,
  }) : assert(
         name.trim().length >= FieldLists.MINIMUM_LENGTH_OF_NAME &&
             name.length <= FieldLists.MAXIMUM_LENGTH_OF_NAME,
         'FieldList name must be between ${FieldLists.MINIMUM_LENGTH_OF_NAME} and ${FieldLists.MAXIMUM_LENGTH_OF_NAME} characters',
       ),
       assert(
         sortBy >= 0 && sortBy < SortBy.MAX.index,
         'sortBy must be bigger than or equal 0 and smaller than ${SortBy.MAX.index}',
       ),
       assert(
         usageCount >= FieldLists.MINIMUM_USAGE_COUNT &&
             usageCount <= FieldLists.MAXIMUM_USAGE_COUNT,
         'usageCount must be bigger than or equal ${FieldLists.MINIMUM_USAGE_COUNT} '
         'and smaller than or equal ${FieldLists.MAXIMUM_USAGE_COUNT}',
       ),
       assert(
         color >= FieldLists.MINIMUM_COLOR && color <= FieldLists.MAXIMUM_COLOR,
         'color must be bigger than or equal ${FieldLists.MINIMUM_COLOR} '
         'and smaller than or equal ${FieldLists.MAXIMUM_COLOR}',
       ),
       assert(
         (emulationNumberOfQuestions != null &&
                 emulationNumberOfQuestions >=
                     FieldLists.MINIMUM_EMULATION_NUMBER_OF_QUESTIONS &&
                 emulationNumberOfQuestions <=
                     FieldLists.MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS) ||
             emulationNumberOfQuestions == null,
         'emulationNumberOfQuestions must be bigger than or equal ${FieldLists.MINIMUM_EMULATION_NUMBER_OF_QUESTIONS} '
         'and smaller than or equal ${FieldLists.MAXIMUM_EMULATION_NUMBER_OF_QUESTIONS}',
       ),
       assert(
         (testsReadingQuestionLetterDuration != null &&
                 testsReadingQuestionLetterDuration >=
                     FieldLists.MINIMUM_TESTS_DURATIONS) ||
             testsReadingQuestionLetterDuration == null,
         'testsReadingQuestionLetterDuration must be bigger than or equal ${FieldLists.MINIMUM_TESTS_DURATIONS}',
       ),
       assert(
         (testsFindingAnswerDuration != null &&
                 testsFindingAnswerDuration >=
                     FieldLists.MINIMUM_TESTS_DURATIONS) ||
             testsFindingAnswerDuration == null,
         'testsFindingAnswerDuration must be bigger than or equal ${FieldLists.MINIMUM_TESTS_DURATIONS}',
       ),
       assert(
         (testsTypingAnswerLetterDuration != null &&
                 testsTypingAnswerLetterDuration >=
                     FieldLists.MINIMUM_TESTS_DURATIONS) ||
             testsTypingAnswerLetterDuration == null,
         'testsTypingAnswerLetterDuration must be bigger than or equal ${FieldLists.MINIMUM_TESTS_DURATIONS}',
       ),
       assert(
         (studyTillCorrectReadingQuestionLetterDuration != null &&
                 studyTillCorrectReadingQuestionLetterDuration >=
                     FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS) ||
             studyTillCorrectReadingQuestionLetterDuration == null,
         'studyTillCorrectReadingQuestionLetterDuration must be bigger than or equal ${FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS}',
       ),
       assert(
         (studyTillCorrectFindingAnswerDuration != null &&
                 studyTillCorrectFindingAnswerDuration >=
                     FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS) ||
             studyTillCorrectFindingAnswerDuration == null,
         'studyTillCorrectFindingAnswerDuration must be bigger than or equal ${FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS}',
       ),
       assert(
         (studyTillCorrectTypingAnswerLetterDuration != null &&
                 studyTillCorrectTypingAnswerLetterDuration >=
                     FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS) ||
             studyTillCorrectTypingAnswerLetterDuration == null,
         'studyTillCorrectTypingAnswerLetterDuration must be bigger than or equal ${FieldLists.MINIMUM_STUDY_TILL_CORRECT_DURATIONS}',
       ),
       assert(
         testsTimeOfAnswerAction >= 0 && testsTimeOfAnswerAction < 2,
         'testsTimeOfAnswerAction must be bigger than or equal 0 and smaller than 2',
       );
  factory FieldListEntity({
    String? id,
    required String fieldId,
    required String name,
    required DateTime creationAt,
    required DateTime lastModificationAt,
    @Default(CheckType.NON_STRICT_DO_NOT_IGNORE_CASE) CheckType checkType,
    @Default(0) int sortBy,
    @Default(0) int usageCount,
    @Default(FieldLists.MAXIMUM_COLOR) int color,
    int? emulationNumberOfQuestions,
    int? testsReadingQuestionLetterDuration,
    int? testsFindingAnswerDuration,
    int? testsTypingAnswerLetterDuration,
    int? studyTillCorrectReadingQuestionLetterDuration,
    int? studyTillCorrectFindingAnswerDuration,
    int? studyTillCorrectTypingAnswerLetterDuration,
    @Default(1) int testsTimeOfAnswerAction,
    String? languageTag,
    @Default(false) bool doesReadAnswer,
    String? emulationDays,
    @Default(false) bool doesObfuscateQuestion,
  }) = _FieldListEntity;
  @override
  final String name;
  @override
  final CheckType checkType;
  @override
  final int sortBy;
  @override
  final int usageCount;
  @override
  final int color;
  @override
  final int? emulationNumberOfQuestions;
  @override
  final int? testsReadingQuestionLetterDuration;
  @override
  final int? testsFindingAnswerDuration;
  @override
  final int? testsTypingAnswerLetterDuration;
  @override
  final int? studyTillCorrectReadingQuestionLetterDuration;
  @override
  final int? studyTillCorrectFindingAnswerDuration;
  @override
  final int? studyTillCorrectTypingAnswerLetterDuration;
  @override
  final int testsTimeOfAnswerAction;
}
