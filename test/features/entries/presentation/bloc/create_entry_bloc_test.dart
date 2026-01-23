import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/usecases/create_entry_usecase.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/create_entry_bloc.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/create_entry_event.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/create_entry_state.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:uuid/uuid.dart';

class MockCreateEntryUsecase extends Mock implements CreateEntryUsecase {}

void main() {
  late CreateEntryUsecase createEntryUsecase;
  final DateTime creationAt = DateTime(2024);
  EntryEntity entry = EntryEntity(
    fieldListId: const Uuid().v4(),
    answer: 'answer',
    question: 'question',
    rank: 3,
    order: 9,
    creationAt: creationAt,
    lastModificationAt: creationAt,
  );

  FieldListEntity fieldListEntity = FieldListEntity(
    id: const Uuid().v4(),
    fieldId: const Uuid().v4(),
    name: 'fieldListName',
    creationAt: creationAt.subtract(Duration(days: 2)),
    lastModificationAt: creationAt.subtract(Duration(days: 1)),
  );

  FieldListEntity fieldListEntity2 = FieldListEntity(
    id: const Uuid().v4(),
    fieldId: const Uuid().v4(),
    name: 'fieldListName',
    creationAt: creationAt.subtract(Duration(days: 2)),
    lastModificationAt: creationAt.subtract(Duration(days: 1)),
  );
  setUp(() {
    createEntryUsecase = MockCreateEntryUsecase();
  });

  CreateEntryBloc buildBloc() {
    return CreateEntryBloc(createEntryUsecase, entry.fieldListId);
  }

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Emit new state with updated rank',
    build: buildBloc,
    seed: () => CreateEntryState(status: CreateEntryStatus.initial),
    act: (bloc) => bloc.add(const CreateEntryRankChanged(0)),
    expect: () => [
      CreateEntryState(status: CreateEntryStatus.initial, rank: 0),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Emit new state with updated rank 2',
    build: buildBloc,
    seed: () => CreateEntryState(
      status: CreateEntryStatus.initial,
      question: entry.question,
      answer: entry.answer,
      rank: 2,
      order: '${entry.order}',
    ),
    act: (bloc) => bloc.add(const CreateEntryRankChanged(0)),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.initial,
        rank: 0,
        question: entry.question,
        answer: entry.answer,
        order: '${entry.order}',
      ),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Emit new state with updated question',
    build: buildBloc,
    seed: () => CreateEntryState(status: CreateEntryStatus.initial),
    act: (bloc) => bloc.add(const CreateEntryQuestionChanged('question')),
    expect: () => [
      CreateEntryState(status: CreateEntryStatus.initial, question: 'question'),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Emit new state with updated question 2',
    build: buildBloc,
    seed: () => CreateEntryState(
      status: CreateEntryStatus.initial,
      question: 'QUESTION',
      answer: entry.answer,
      rank: entry.rank,
      order: '${entry.order}',
    ),
    act: (bloc) => bloc.add(const CreateEntryQuestionChanged('question')),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.initial,
        question: 'question',
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Emit new state with updated answer',
    build: buildBloc,
    seed: () => CreateEntryState(status: CreateEntryStatus.initial),
    act: (bloc) => bloc.add(const CreateEntryAnswerChanged('answer')),
    expect: () => [
      CreateEntryState(status: CreateEntryStatus.initial, answer: 'answer'),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Emit new state with updated answer 2',
    build: buildBloc,
    seed: () => CreateEntryState(
      status: CreateEntryStatus.initial,
      question: entry.question,
      answer: 'ANSWER',
      rank: entry.rank,
      order: '${entry.order}',
    ),
    act: (bloc) => bloc.add(const CreateEntryAnswerChanged('answer')),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.initial,
        answer: 'answer',
        question: entry.question,
        rank: entry.rank,
        order: '${entry.order}',
      ),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Emit new state with updated order',
    build: buildBloc,
    seed: () => CreateEntryState(status: CreateEntryStatus.initial),
    act: (bloc) => bloc.add(const CreateEntryOrderChanged('10')),
    expect: () => [
      CreateEntryState(status: CreateEntryStatus.initial, order: '10'),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Emit new state with updated order 2',
    build: buildBloc,
    seed: () => CreateEntryState(
      status: CreateEntryStatus.initial,
      question: entry.question,
      answer: entry.answer,
      rank: entry.rank,
      order: '3',
    ),
    act: (bloc) => bloc.add(const CreateEntryOrderChanged('10')),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.initial,
        order: '10',
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
      ),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Calls the usecase with the current state when submission: succesful case 1',
    setUp: () {
      when(
        () => createEntryUsecase.call(
          fieldListId: entry.fieldListId,
          question: entry.question,
          answer: entry.answer,
          rank: entry.rank,
          order: entry.order,
        ),
      ).thenAnswer((_) => Future.value(1));
    },
    build: buildBloc,
    seed: () => CreateEntryState(
      status: CreateEntryStatus.initial,
      question: entry.question,
      answer: entry.answer,
      rank: entry.rank,
      order: '${entry.order}',
      fieldList: fieldListEntity,
    ),
    act: (bloc) => bloc.add(const CreateEntrySubmitted()),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.loading,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
        fieldList: fieldListEntity,
      ),
      CreateEntryState(
        status: CreateEntryStatus.success,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
        fieldList: fieldListEntity,
      ),
      CreateEntryState(
        status: CreateEntryStatus.initial,
        fieldList: fieldListEntity,
      ),
    ],
    verify: (bloc) {
      verify(
        () => createEntryUsecase.call(
          fieldListId: entry.fieldListId,
          answer: entry.answer,
          question: entry.question,
          rank: entry.rank,
          order: entry.order,
        ),
      ).called(1);
    },
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Calls the usecase with the current state when submission: succesful case 2',
    setUp: () {
      when(
        () => createEntryUsecase.call(
          fieldListId: entry.fieldListId,
          question: entry.question,
          answer: entry.answer,
          rank: entry.rank,
          order: 0,
        ),
      ).thenAnswer((_) => Future.value(1));
    },
    build: buildBloc,
    seed: () => CreateEntryState(
      status: CreateEntryStatus.initial,
      question: entry.question,
      answer: entry.answer,
      rank: entry.rank,
      order: '',
      fieldList: fieldListEntity,
    ),
    act: (bloc) => bloc.add(const CreateEntrySubmitted()),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.loading,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '',
        fieldList: fieldListEntity,
      ),
      CreateEntryState(
        status: CreateEntryStatus.success,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '',
        fieldList: fieldListEntity,
      ),
      CreateEntryState(
        status: CreateEntryStatus.initial,
        fieldList: fieldListEntity,
      ),
    ],
    verify: (bloc) {
      verify(
        () => createEntryUsecase.call(
          fieldListId: entry.fieldListId,
          answer: entry.answer,
          question: entry.question,
          rank: entry.rank,
          order: 0,
        ),
      ).called(1);
    },
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Calls the usecase with the current state when submission: failure case 1',
    setUp: () {
      when(
        () => createEntryUsecase.call(
          fieldListId: entry.fieldListId,
          question: entry.question,
          answer: entry.answer,
          rank: entry.rank,
          order: entry.order,
        ),
      ).thenThrow((_) => SqliteException(1, 'sqliteexception'));
    },
    build: buildBloc,
    seed: () => CreateEntryState(
      status: CreateEntryStatus.initial,
      question: entry.question,
      answer: entry.answer,
      rank: entry.rank,
      order: '${entry.order}',
    ),
    act: (bloc) => bloc.add(const CreateEntrySubmitted()),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.loading,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
      CreateEntryState(
        status: CreateEntryStatus.failure,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
      CreateEntryState(
        status: CreateEntryStatus.initial,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
    ],
    verify: (bloc) {
      verify(
        () => createEntryUsecase.call(
          fieldListId: entry.fieldListId,
          answer: entry.answer,
          question: entry.question,
          rank: entry.rank,
          order: entry.order,
        ),
      ).called(1);
    },
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Calls the usecase with the current state when submission: failure case 2',
    setUp: () {
      when(
        () => createEntryUsecase.call(
          fieldListId: entry.fieldListId,
          question: entry.question,
          answer: entry.answer,
          rank: entry.rank,
          order: entry.order,
        ),
      ).thenAnswer((_) => Future.error(SqliteException(1, 'sqliteexception')));
    },
    build: buildBloc,
    seed: () => CreateEntryState(
      status: CreateEntryStatus.initial,
      question: entry.question,
      answer: entry.answer,
      rank: entry.rank,
      order: '${entry.order}',
    ),
    act: (bloc) => bloc.add(const CreateEntrySubmitted()),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.loading,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
      CreateEntryState(
        status: CreateEntryStatus.failure,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
      CreateEntryState(
        status: CreateEntryStatus.initial,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
    ],
    verify: (bloc) {
      verify(
        () => createEntryUsecase.call(
          fieldListId: entry.fieldListId,
          answer: entry.answer,
          question: entry.question,
          rank: entry.rank,
          order: entry.order,
        ),
      ).called(1);
    },
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'Calls the usecase with the current state when submission: failure case duplication',
    setUp: () {
      when(
        () => createEntryUsecase.call(
          fieldListId: entry.fieldListId,
          question: entry.question,
          answer: entry.answer,
          rank: entry.rank,
          order: entry.order,
        ),
      ).thenThrow(SqliteException(1, 'UNIQUE constraint'));
    },
    build: buildBloc,
    seed: () => CreateEntryState(
      status: CreateEntryStatus.initial,
      question: entry.question,
      answer: entry.answer,
      rank: entry.rank,
      order: '${entry.order}',
    ),
    act: (bloc) => bloc.add(const CreateEntrySubmitted()),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.loading,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
      CreateEntryState(
        status: CreateEntryStatus.duplicationFailure,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
      CreateEntryState(
        status: CreateEntryStatus.initial,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
    ],
    verify: (bloc) {
      verify(
        () => createEntryUsecase.call(
          fieldListId: entry.fieldListId,
          answer: entry.answer,
          question: entry.question,
          rank: entry.rank,
          order: entry.order,
        ),
      ).called(1);
    },
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'When CreateEntrySubscriptionRequested is added createEntryUsecase.watchFieldList() is called',
    setUp: () {
      when(
        () => createEntryUsecase.watchFieldList(fieldListEntity.id!),
      ).thenAnswer((_) => Stream.value(fieldListEntity));
    },
    build: buildBloc,
    act: (bloc) =>
        bloc.add(CreateEntrySubscriptionRequested(fieldListEntity.id!)),
    verify: (bloc) {
      verify(
        () => createEntryUsecase.watchFieldList(fieldListEntity.id!),
      ).called(1);
    },
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'emits state when createEntryUsecase.watchFieldList() stream return value 1',
    setUp: () {
      when(
        () => createEntryUsecase.watchFieldList(fieldListEntity.id!),
      ).thenAnswer((_) => Stream.value(fieldListEntity));
    },
    seed: () => CreateEntryState(
      status: CreateEntryStatus.loading,
      question: entry.question,
      answer: entry.answer,
      rank: entry.rank,
      order: '${entry.order}',
    ),
    build: buildBloc,
    act: (bloc) =>
        bloc.add(CreateEntrySubscriptionRequested(fieldListEntity.id!)),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.initial,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
        fieldList: fieldListEntity,
      ),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'emits state when createEntryUsecase.watchFieldList() stream return value 2',
    setUp: () {
      when(
        () => createEntryUsecase.watchFieldList(fieldListEntity.id!),
      ).thenAnswer((_) => Stream.value(fieldListEntity2));
    },
    seed: () => CreateEntryState(
      status: CreateEntryStatus.initial,
      question: entry.question,
      answer: entry.answer,
      rank: entry.rank,
      order: '${entry.order}',
      fieldList: fieldListEntity,
    ),
    build: buildBloc,
    act: (bloc) =>
        bloc.add(CreateEntrySubscriptionRequested(fieldListEntity.id!)),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.initial,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
        fieldList: fieldListEntity2,
      ),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'emits state when createEntryUsecase.watchFieldList() stream return error 1',
    setUp: () {
      when(
        () => createEntryUsecase.watchFieldList(fieldListEntity.id!),
      ).thenAnswer((_) => Stream.error(SqliteException(1, 'sqlexception')));
    },
    seed: () => CreateEntryState(
      status: CreateEntryStatus.loading,
      question: entry.question,
      answer: entry.answer,
      rank: entry.rank,
      order: '${entry.order}',
    ),
    build: buildBloc,
    act: (bloc) =>
        bloc.add(CreateEntrySubscriptionRequested(fieldListEntity.id!)),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.failure,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'emits state when createEntryUsecase.watchFieldList() stream return error 2',
    setUp: () {
      when(
        () => createEntryUsecase.watchFieldList(fieldListEntity.id!),
      ).thenAnswer((_) => Stream.error(SqliteException(1, 'sqlexception')));
    },
    seed: () => CreateEntryState(
      status: CreateEntryStatus.initial,
      question: entry.question,
      answer: entry.answer,
      rank: entry.rank,
      order: '${entry.order}',
      fieldList: fieldListEntity,
    ),
    build: buildBloc,
    act: (bloc) =>
        bloc.add(CreateEntrySubscriptionRequested(fieldListEntity.id!)),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.failure,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'emits state when createEntryUsecase.watchFieldList() throws 1',
    setUp: () {
      when(
        () => createEntryUsecase.watchFieldList(fieldListEntity.id!),
      ).thenThrow(SqliteException(1, 'sqlexception'));
    },
    seed: () => CreateEntryState(
      status: CreateEntryStatus.loading,
      question: entry.question,
      answer: entry.answer,
      rank: entry.rank,
      order: '${entry.order}',
    ),
    build: buildBloc,
    act: (bloc) =>
        bloc.add(CreateEntrySubscriptionRequested(fieldListEntity.id!)),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.failure,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
    ],
  );

  blocTest<CreateEntryBloc, CreateEntryState>(
    'emits state when createEntryUsecase.watchFieldList() throws 2',
    setUp: () {
      when(
        () => createEntryUsecase.watchFieldList(fieldListEntity.id!),
      ).thenThrow(SqliteException(1, 'sqlexception'));
    },
    seed: () => CreateEntryState(
      status: CreateEntryStatus.initial,
      question: entry.question,
      answer: entry.answer,
      rank: entry.rank,
      order: '${entry.order}',
      fieldList: fieldListEntity,
    ),
    build: buildBloc,
    act: (bloc) =>
        bloc.add(CreateEntrySubscriptionRequested(fieldListEntity.id!)),
    expect: () => [
      CreateEntryState(
        status: CreateEntryStatus.failure,
        question: entry.question,
        answer: entry.answer,
        rank: entry.rank,
        order: '${entry.order}',
      ),
    ],
  );
}
