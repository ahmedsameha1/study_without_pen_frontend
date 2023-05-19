import 'package:drift/drift.dart';

import 'app_database.dart';

part 'field_lists_dao.g.dart';

@DriftAccessor(tables: [FieldLists])
class FieldListsDao extends DatabaseAccessor<AppDatabase>
    with _$FieldListsDaoMixin {
  FieldListsDao(AppDatabase appDatabase) : super(appDatabase);
  create(FieldListsCompanion fieldListsCompanion) {
    if (fieldListsCompanion.id.present &&
        !isValid(fieldListsCompanion.id.value)) {
      throw InvalidDataException("id");
    }
    if (!isValid(fieldListsCompanion.fieldId.value)) {
      throw InvalidDataException("fieldId");
    }
    if (!isValidCheckType(fieldListsCompanion.checkType.value)) {
      throw InvalidDataException("checkType");
    }
    if (!isValidSortBy(fieldListsCompanion.sortBy.value)) {
      throw InvalidDataException("sortBy");
    }
    if ((fieldListsCompanion.emulationNumberOfQuestions.value == null &&
            fieldListsCompanion.emulationDays.value != null) ||
        (fieldListsCompanion.emulationNumberOfQuestions.value != null &&
            fieldListsCompanion.emulationDays.value == null)) {
      throw InvalidDataException("non consistent emulation");
    }
    if (fieldListsCompanion.emulationDays.present &&
        fieldListsCompanion.emulationDays.value != null) {
      var regex = RegExp(r"(?=[0-6]{1,7})^0?1?2?3?4?5?6?$");
      if (!regex.hasMatch(fieldListsCompanion.emulationDays.value!)) {
        throw InvalidDataException("emulationDays");
      }
    }
    if (!((fieldListsCompanion.testsReadingQuestionLetterDuration.value ==
                null &&
            fieldListsCompanion.testsFindingAnswerDuration.value == null &&
            fieldListsCompanion.testsTypingAnswerLetterDuration.value ==
                null) ||
        (fieldListsCompanion.testsReadingQuestionLetterDuration.value != null &&
            fieldListsCompanion.testsFindingAnswerDuration.value != null &&
            fieldListsCompanion.testsTypingAnswerLetterDuration.value !=
                null))) {
      throw InvalidDataException("tests durations is not consistant null wise");
    }
    return into(fieldLists).insert(fieldListsCompanion);
  }
}

enum CheckType {
  NON_STRICT_IGNORE_CASE,
  NON_STRICT_DO_NOT_IGNORE_CASE,
  IGNORE_CASE,
  DO_NOT_IGNORE_CASE,
  MAX
}

bool isValidCheckType(int checkType) {
  return checkType >= 0 && checkType < CheckType.MAX.index;
}

enum SortBy {
  CREATION_DATE_DESC,
  ANSWER_DESC,
  QUESTION_ASC,
  ANSWER_ASC,
  DATE_DESC,
  DATE_ASC,
  QUESTION_DESC,
  CREATION_DATE_ASC,
  ORDER_ASC,
  ORDER_DESC,
  RANK_ASC,
  RANK_DESC,
  WRONGNESS_ASC,
  WRONGNESS_DESC,
  MAX
}

bool isValidSortBy(int sortBy) {
  return sortBy >= 0 && sortBy < SortBy.MAX.index;
}
