import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_bloc.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_event.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_state.dart';
import 'package:uuid/uuid.dart';

void main() {
  List<EntryEntity> entries = [
    EntryEntity(
      id: const Uuid().v4(),
      fieldListId: const Uuid().v4(),
      answer: 'answer1',
      question: 'question1',
      creationAt: DateTime(2025).subtract(const Duration(days: 4)),
      lastModificationAt: DateTime(2025).subtract(const Duration(days: 3)),
    ),
    EntryEntity(
      id: const Uuid().v4(),
      fieldListId: const Uuid().v4(),
      answer: 'answer2',
      question: 'question2',
      creationAt: DateTime(2025).subtract(const Duration(days: 2)),
      lastModificationAt: DateTime(2025).subtract(const Duration(days: 1)),
    ),
    EntryEntity(
      id: const Uuid().v4(),
      fieldListId: const Uuid().v4(),
      answer: 'answer3',
      question: 'question3',
      creationAt: DateTime(2025).subtract(const Duration(days: 6)),
      lastModificationAt: DateTime(2025).subtract(const Duration(days: 5)),
    ),
  ];

  test('Bloc has a correct initial state', () {
    expect(StudyTestBloc(StudyTestState()).state, StudyTestState());
  });

  blocTest(
    'update currentEntryIndex when entry is changed',
    build: () => StudyTestBloc(StudyTestState()),
    seed: () => StudyTestState(
      entries: entries,
      currentEntryIndex: 1,
      counts: [(1, 2, 0), (3, 4, 0), (5, 6, 0)],
    ),
    act: (bloc) => bloc.add(ChangeEntry(2)),
    expect: () => [
      StudyTestState(
        entries: entries,
        currentEntryIndex: 2,
        counts: [(1, 2, 0), (3, 4, 0), (5, 6, 0)],
      ),
    ],
  );

  blocTest(
    'update tab when the tab is changed',
    build: () => StudyTestBloc(StudyTestState()),
    seed: () => StudyTestState(
      entries: entries,
      currentEntryIndex: 1,
      counts: [(1, 2, 0), (3, 4, 0), (5, 6, 0)],
    ),
    act: (bloc) => bloc.add(ChangeTab(1)),
    expect: () => [
      StudyTestState(
        entries: entries,
        currentEntryIndex: 1,
        counts: [(1, 2, 0), (3, 4, 1), (5, 6, 0)],
      ),
    ],
  );
}
