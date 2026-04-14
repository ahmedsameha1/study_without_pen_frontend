import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_bloc.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_event.dart';
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
    checkType: CheckType.DO_NOT_IGNORE_CASE.index,
  );
  List<EntryEntity> entries = [
    EntryEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      answer: 'answer1',
      question: 'question1',
      creationAt: DateTime(2025).subtract(const Duration(days: 4)),
      lastModificationAt: DateTime(2025).subtract(const Duration(days: 3)),
    ),
    EntryEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      answer: 'answer2',
      question: 'question2',
      creationAt: DateTime(2025).subtract(const Duration(days: 2)),
      lastModificationAt: DateTime(2025).subtract(const Duration(days: 1)),
    ),
    EntryEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      answer: 'answer3',
      question: 'question3',
      creationAt: DateTime(2025).subtract(const Duration(days: 6)),
      lastModificationAt: DateTime(2025).subtract(const Duration(days: 5)),
    ),
  ];

  List<EntryCounts> counts = [(0, 0, 0), (0, 0, 0), (0, 0, 0)];

  test('Bloc has a correct initial state', () {
    expect(
      StudyTestBloc(
        StudyTestState(
          fieldList: fieldListEntity,
          entries: entries,
          counts: counts,
        ),
      ).state,
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        counts: counts,
      ),
    );
  });

  blocTest(
    'update currentEntryIndex when entry is changed',
    build: () => StudyTestBloc(
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        counts: counts,
      ),
    ),
    seed: () => StudyTestState(
      fieldList: fieldListEntity,
      entries: entries,
      currentEntryIndex: 1,
      counts: [(1, 2, 0), (3, 4, 0), (5, 6, 0)],
    ),
    act: (bloc) => bloc.add(ChangeEntry(2)),
    expect: () => [
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        currentEntryIndex: 2,
        counts: [(1, 2, 0), (3, 4, 0), (5, 6, 0)],
      ),
    ],
  );

  blocTest(
    'update tab when the tab is changed',
    build: () => StudyTestBloc(
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        counts: counts,
      ),
    ),
    seed: () => StudyTestState(
      fieldList: fieldListEntity,
      entries: entries,
      currentEntryIndex: 1,
      counts: [(1, 2, 0), (3, 4, 0), (5, 6, 0)],
    ),
    act: (bloc) => bloc.add(ChangeTab(1)),
    expect: () => [
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        currentEntryIndex: 1,
        counts: [(1, 2, 0), (3, 4, 1), (5, 6, 0)],
      ),
    ],
  );

  blocTest(
    'userAnswer updated when user changes his answer',
    build: () => StudyTestBloc(
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        counts: counts,
      ),
    ),
    seed: () => StudyTestState(
      fieldList: fieldListEntity,
      entries: entries,
      currentEntryIndex: 1,
      counts: [(1, 2, 0), (3, 4, 0), (5, 6, 0)],
      userAnswer: 'answe',
    ),
    act: (bloc) => bloc.add(ChangeUserAnswer('answer')),
    expect: () => [
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        currentEntryIndex: 1,
        counts: [(1, 2, 0), (3, 4, 0), (5, 6, 0)],
        userAnswer: 'answer',
      ),
    ],
  );

  blocTest(
    'userAnswer updated when user changes tab',
    build: () => StudyTestBloc(
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        counts: counts,
      ),
    ),
    seed: () => StudyTestState(
      fieldList: fieldListEntity,
      entries: entries,
      currentEntryIndex: 1,
      counts: [(1, 2, 0), (3, 4, 0), (5, 6, 0)],
      userAnswer: 'answe',
    ),
    act: (bloc) => bloc.add(ChangeTab(1)),
    expect: () => [
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        currentEntryIndex: 1,
        counts: [(1, 2, 0), (3, 4, 1), (5, 6, 0)],
      ),
    ],
  );

  blocTest(
    'userAnswer updated when user changes entry',
    build: () => StudyTestBloc(
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        counts: counts,
      ),
    ),
    seed: () => StudyTestState(
      fieldList: fieldListEntity,
      entries: entries,
      currentEntryIndex: 1,
      counts: [(1, 2, 0), (3, 4, 0), (5, 6, 0)],
      userAnswer: 'answe',
    ),
    act: (bloc) => bloc.add(ChangeEntry(2)),
    expect: () => [
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        currentEntryIndex: 2,
        counts: [(1, 2, 0), (3, 4, 0), (5, 6, 0)],
      ),
    ],
  );

  blocTest(
    'userAnswer updated when user answer matches the currnet entry answer',
    build: () => StudyTestBloc(
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        counts: counts,
      ),
    ),
    seed: () => StudyTestState(
      fieldList: fieldListEntity,
      entries: entries,
      currentEntryIndex: 1,
      counts: [(1, 2, 0), (3, 4, 0), (5, 6, 0)],
      userAnswer: 'answe',
    ),
    act: (bloc) => bloc.add(ChangeUserAnswer(entries[1].answer)),
    expect: () => [
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        currentEntryIndex: 1,
        counts: [(1, 2, 0), (4, 4, 0), (5, 6, 0)],
      ),
    ],
  );

  blocTest(
    'userAnswer updated when user answer matches the currnet entry answer 2',
    build: () => StudyTestBloc(
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        counts: counts,
      ),
    ),
    seed: () => StudyTestState(
      fieldList: fieldListEntity,
      entries: entries,
      currentEntryIndex: 1,
      counts: [(1, 2, 0), (3, 4, 1), (5, 6, 0)],
      userAnswer: 'answe',
    ),
    act: (bloc) => bloc.add(ChangeUserAnswer(entries[1].answer)),
    expect: () => [
      StudyTestState(
        fieldList: fieldListEntity,
        entries: entries,
        currentEntryIndex: 1,
        counts: [(1, 2, 0), (3, 5, 1), (5, 6, 0)],
      ),
    ],
  );
}
