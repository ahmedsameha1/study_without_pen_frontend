import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_state.dart';
import 'package:uuid/uuid.dart';

void main() {
  DateTime creationAt = DateTime(2024);
  FieldListEntity fieldListEntity = FieldListEntity(
    id: const Uuid().v4(),
    fieldId: const Uuid().v4(),
    name: 'name',
    creationAt: creationAt,
    lastModificationAt: creationAt,
  );
  test('entries lenght must be equal to counts length', () {
    expect(
      () => StudyTestState(
        fieldList: fieldListEntity,
        entries: [
          EntryEntity(
            id: const Uuid().v4(),
            fieldListId: const Uuid().v4(),
            answer: 'answer1',
            question: 'question1',
            creationAt: DateTime(2025).subtract(const Duration(days: 4)),
            lastModificationAt: DateTime(
              2025,
            ).subtract(const Duration(days: 3)),
          ),
          EntryEntity(
            id: const Uuid().v4(),
            fieldListId: const Uuid().v4(),
            answer: 'answer2',
            question: 'question2',
            creationAt: DateTime(2025).subtract(const Duration(days: 2)),
            lastModificationAt: DateTime(
              2025,
            ).subtract(const Duration(days: 1)),
          ),
          EntryEntity(
            id: const Uuid().v4(),
            fieldListId: const Uuid().v4(),
            answer: 'answer3',
            question: 'question3',
            creationAt: DateTime(2025).subtract(const Duration(days: 6)),
            lastModificationAt: DateTime(
              2025,
            ).subtract(const Duration(days: 5)),
          ),
        ],
        currentEntryIndex: 1,
        counts: [(1, 2, 0)],
      ),
      throwsA(
        isA<AssertionError>().having(
          (e) => e.message,
          'message',
          'entries length must be equal to counts length',
        ),
      ),
    );
  });
}
