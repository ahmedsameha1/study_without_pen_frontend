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
    if (!((fieldListsCompanion
                    .studyTillCorrectReadingQuestionLetterDuration.value ==
                null &&
            fieldListsCompanion.studyTillCorrectFindingAnswerDuration.value ==
                null &&
            fieldListsCompanion.studyTillCorrectTypingAnswerLetterDuration.value ==
                null) ||
        (fieldListsCompanion
                    .studyTillCorrectReadingQuestionLetterDuration.value !=
                null &&
            fieldListsCompanion.studyTillCorrectFindingAnswerDuration.value !=
                null &&
            fieldListsCompanion
                    .studyTillCorrectTypingAnswerLetterDuration.value !=
                null))) {
      throw InvalidDataException(
          "study till correct durations is not consistant null wise");
    }
    return into(fieldLists).insert(fieldListsCompanion);
  }

  Future<FieldList?> getById(String id) {
    return (select(fieldLists)..where(((tbl) => tbl.id.equals(id))))
        .getSingleOrNull();
  }

  Stream<List<FieldList>> watchByFieldId(String fieldId) {
    return (select(fieldLists)
          ..where((tbl) => tbl.fieldId.equals(fieldId))
          ..orderBy([
            (tbl) => OrderingTerm(
                expression: tbl.usageCount, mode: OrderingMode.desc)
          ]))
        .watch();
  }
}

bool isValidCheckType(int checkType) {
  return checkType >= 0 && checkType < CheckType.MAX.index;
}

bool isValidSortBy(int sortBy) {
  return sortBy >= 0 && sortBy < SortBy.MAX.index;
}
