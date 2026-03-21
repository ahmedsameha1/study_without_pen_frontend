import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/features/entries/data/repositories/entries_repository.dart';
import 'package:study_without_pen_by_flutter/features/entries/data/repositories/entries_repository_local.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:uuid/uuid.dart';

class MockEntrysDao extends Mock implements EntrysDao {}

void main() {
  EntrysDao entrysDao = MockEntrysDao();
  EntriesRepository entriesRepository = EntriesRepositoryLocal(entrysDao);
  EntryEntity entryEntity = EntryEntity(
    id: Uuid().v4(),
    fieldListId: Uuid().v4(),
    answer: 'answer',
    question: 'question',
    creationAt: DateTime(2025),
    lastModificationAt: DateTime(2025),
    rank: Rank.normal,
    askedCount: 8,
    wronglyAnsweredCount: 2,
    lastAskedAt: DateTime(2025, 2, 2),
  );

  group('watch()', () {
    test('Throws what entrysDao.watchByFieldListId() throw', () {
      when(
        () => entrysDao.watchByFieldListId(entryEntity.fieldListId),
      ).thenThrow(SqliteException(1, 'sqlexception'));
      expect(
        () => entriesRepository.watch(entryEntity.fieldListId),
        throwsA(
          predicate((e) => e is SqliteException && e.message == 'sqlexception'),
        ),
      );
    });

    test('Returns what entrysDao.watchByFieldListId() return: rank normal', () {
      when(
        () => entrysDao.watchByFieldListId(entryEntity.fieldListId),
      ).thenAnswer(
        (_) => Stream.value([
          Entry(
            id: entryEntity.id!,
            fieldListId: entryEntity.fieldListId,
            answer: entryEntity.answer,
            question: entryEntity.question,
            creationAt: entryEntity.creationAt,
            lastModificationAt: entryEntity.lastModificationAt,
            order: entryEntity.order,
            didAskedAtCurrentTestRound: entryEntity.didAskedAtCurrentTestRound,
            rank: entryEntity.rank.index,
            askedCount: BigInt.from(entryEntity.askedCount),
            wronglyAnsweredCount: BigInt.from(entryEntity.wronglyAnsweredCount),
            lastAskedAt: entryEntity.lastAskedAt,
          ),
        ]),
      );
      expect(
        entriesRepository.watch(entryEntity.fieldListId),
        emitsInOrder([
          [entryEntity],
        ]),
      );
    });

    test('Returns what entrysDao.watchByFieldListId() return: rank low', () {
      when(
        () => entrysDao.watchByFieldListId(entryEntity.fieldListId),
      ).thenAnswer(
        (_) => Stream.value([
          Entry(
            id: entryEntity.id!,
            fieldListId: entryEntity.fieldListId,
            answer: entryEntity.answer,
            question: entryEntity.question,
            creationAt: entryEntity.creationAt,
            lastModificationAt: entryEntity.lastModificationAt,
            order: entryEntity.order,
            didAskedAtCurrentTestRound: entryEntity.didAskedAtCurrentTestRound,
            rank: Rank.low.index,
            askedCount: BigInt.from(entryEntity.askedCount),
            wronglyAnsweredCount: BigInt.from(entryEntity.wronglyAnsweredCount),
            lastAskedAt: entryEntity.lastAskedAt,
          ),
        ]),
      );
      expect(
        entriesRepository.watch(entryEntity.fieldListId),
        emitsInOrder([
          [entryEntity.copyWith(rank: Rank.low)],
        ]),
      );
    });

    test(
      'Returns what entrysDao.watchByFieldListId() return: rank important',
      () {
        when(
          () => entrysDao.watchByFieldListId(entryEntity.fieldListId),
        ).thenAnswer(
          (_) => Stream.value([
            Entry(
              id: entryEntity.id!,
              fieldListId: entryEntity.fieldListId,
              answer: entryEntity.answer,
              question: entryEntity.question,
              creationAt: entryEntity.creationAt,
              lastModificationAt: entryEntity.lastModificationAt,
              order: entryEntity.order,
              didAskedAtCurrentTestRound:
                  entryEntity.didAskedAtCurrentTestRound,
              rank: Rank.important.index,
              askedCount: BigInt.from(entryEntity.askedCount),
              wronglyAnsweredCount: BigInt.from(
                entryEntity.wronglyAnsweredCount,
              ),
              lastAskedAt: entryEntity.lastAskedAt,
            ),
          ]),
        );
        expect(
          entriesRepository.watch(entryEntity.fieldListId),
          emitsInOrder([
            [entryEntity.copyWith(rank: Rank.important)],
          ]),
        );
      },
    );

    test('Returns what entrysDao.watchByFieldListId() return: rank vital', () {
      when(
        () => entrysDao.watchByFieldListId(entryEntity.fieldListId),
      ).thenAnswer(
        (_) => Stream.value([
          Entry(
            id: entryEntity.id!,
            fieldListId: entryEntity.fieldListId,
            answer: entryEntity.answer,
            question: entryEntity.question,
            creationAt: entryEntity.creationAt,
            lastModificationAt: entryEntity.lastModificationAt,
            order: entryEntity.order,
            didAskedAtCurrentTestRound: entryEntity.didAskedAtCurrentTestRound,
            rank: Rank.vital.index,
            askedCount: BigInt.from(entryEntity.askedCount),
            wronglyAnsweredCount: BigInt.from(entryEntity.wronglyAnsweredCount),
            lastAskedAt: entryEntity.lastAskedAt,
          ),
        ]),
      );
      expect(
        entriesRepository.watch(entryEntity.fieldListId),
        emitsInOrder([
          [entryEntity.copyWith(rank: Rank.vital)],
        ]),
      );
    });

    group('search()', () {
      final String text = 'text';
      test('Throws what entrysDao.searchByTextInQuestionOrAnswer() throw', () {
        when(
          () => entrysDao.searchByTextInQuestionOrAnswer(
            entryEntity.fieldListId,
            text,
          ),
        ).thenThrow(SqliteException(1, 'sqlexception'));
        expect(
          () => entriesRepository.search(entryEntity.fieldListId, text),
          throwsA(
            predicate(
              (e) => e is SqliteException && e.message == 'sqlexception',
            ),
          ),
        );
      });

      test(
        'Returns what entrysDao.searchByTextInQuestionOrAnswer() return: rank normal',
        () {
          when(
            () => entrysDao.searchByTextInQuestionOrAnswer(
              entryEntity.fieldListId,
              text,
            ),
          ).thenAnswer(
            (_) => Stream.value([
              Entry(
                id: entryEntity.id!,
                fieldListId: entryEntity.fieldListId,
                answer: entryEntity.answer,
                question: entryEntity.question,
                creationAt: entryEntity.creationAt,
                lastModificationAt: entryEntity.lastModificationAt,
                order: entryEntity.order,
                didAskedAtCurrentTestRound:
                    entryEntity.didAskedAtCurrentTestRound,
                rank: entryEntity.rank.index,
                askedCount: BigInt.from(entryEntity.askedCount),
                wronglyAnsweredCount: BigInt.from(
                  entryEntity.wronglyAnsweredCount,
                ),
                lastAskedAt: entryEntity.lastAskedAt,
              ),
            ]),
          );
          expect(
            entriesRepository.search(entryEntity.fieldListId, text),
            emitsInOrder([
              [entryEntity],
            ]),
          );
        },
      );

      test(
        'Returns what entrysDao.searchByTextInQuestionOrAnswer() return: rank low',
        () {
          when(
            () => entrysDao.searchByTextInQuestionOrAnswer(
              entryEntity.fieldListId,
              text,
            ),
          ).thenAnswer(
            (_) => Stream.value([
              Entry(
                id: entryEntity.id!,
                fieldListId: entryEntity.fieldListId,
                answer: entryEntity.answer,
                question: entryEntity.question,
                creationAt: entryEntity.creationAt,
                lastModificationAt: entryEntity.lastModificationAt,
                order: entryEntity.order,
                didAskedAtCurrentTestRound:
                    entryEntity.didAskedAtCurrentTestRound,
                rank: Rank.low.index,
                askedCount: BigInt.from(entryEntity.askedCount),
                wronglyAnsweredCount: BigInt.from(
                  entryEntity.wronglyAnsweredCount,
                ),
                lastAskedAt: entryEntity.lastAskedAt,
              ),
            ]),
          );
          expect(
            entriesRepository.search(entryEntity.fieldListId, text),
            emitsInOrder([
              [entryEntity.copyWith(rank: Rank.low)],
            ]),
          );
        },
      );

      test(
        'Returns what entrysDao.searchByTextInQuestionOrAnswer() return: rank important',
        () {
          when(
            () => entrysDao.searchByTextInQuestionOrAnswer(
              entryEntity.fieldListId,
              text,
            ),
          ).thenAnswer(
            (_) => Stream.value([
              Entry(
                id: entryEntity.id!,
                fieldListId: entryEntity.fieldListId,
                answer: entryEntity.answer,
                question: entryEntity.question,
                creationAt: entryEntity.creationAt,
                lastModificationAt: entryEntity.lastModificationAt,
                order: entryEntity.order,
                didAskedAtCurrentTestRound:
                    entryEntity.didAskedAtCurrentTestRound,
                rank: Rank.important.index,
                askedCount: BigInt.from(entryEntity.askedCount),
                wronglyAnsweredCount: BigInt.from(
                  entryEntity.wronglyAnsweredCount,
                ),
                lastAskedAt: entryEntity.lastAskedAt,
              ),
            ]),
          );
          expect(
            entriesRepository.search(entryEntity.fieldListId, text),
            emitsInOrder([
              [entryEntity.copyWith(rank: Rank.important)],
            ]),
          );
        },
      );

      test(
        'Returns what entrysDao.searchByTextInQuestionOrAnswer() return: rank vital',
        () {
          when(
            () => entrysDao.searchByTextInQuestionOrAnswer(
              entryEntity.fieldListId,
              text,
            ),
          ).thenAnswer(
            (_) => Stream.value([
              Entry(
                id: entryEntity.id!,
                fieldListId: entryEntity.fieldListId,
                answer: entryEntity.answer,
                question: entryEntity.question,
                creationAt: entryEntity.creationAt,
                lastModificationAt: entryEntity.lastModificationAt,
                order: entryEntity.order,
                didAskedAtCurrentTestRound:
                    entryEntity.didAskedAtCurrentTestRound,
                rank: Rank.vital.index,
                askedCount: BigInt.from(entryEntity.askedCount),
                wronglyAnsweredCount: BigInt.from(
                  entryEntity.wronglyAnsweredCount,
                ),
                lastAskedAt: entryEntity.lastAskedAt,
              ),
            ]),
          );
          expect(
            entriesRepository.search(entryEntity.fieldListId, text),
            emitsInOrder([
              [entryEntity.copyWith(rank: Rank.vital)],
            ]),
          );
        },
      );
    });
  });

  test('create() throws what EntrysDao.create() throw', () {
    when(
      () => entrysDao.create(
        EntrysCompanion(
          fieldListId: Value(entryEntity.fieldListId),
          answer: Value(entryEntity.answer),
          question: Value(entryEntity.question),
          creationAt: Value(entryEntity.creationAt),
          lastModificationAt: Value(entryEntity.lastModificationAt),
          order: Value(entryEntity.order),
          didAskedAtCurrentTestRound: Value(
            entryEntity.didAskedAtCurrentTestRound,
          ),
          emulatedCreatedAt: Value(entryEntity.emulatedCreatedAt),
          rank: Value(entryEntity.rank.index),
          askedCount: Value(BigInt.from(entryEntity.askedCount)),
          wronglyAnsweredCount: Value(
            BigInt.from(entryEntity.wronglyAnsweredCount),
          ),
        ),
      ),
    ).thenThrow(SqliteException(1, 'sqlexception'));
    expect(
      () => entriesRepository.create(entryEntity),
      throwsA(
        predicate((e) => e is SqliteException && e.message == 'sqlexception'),
      ),
    );
  });

  test('create() returns what EntrysDao.create() return', () {
    when(
      () => entrysDao.create(
        EntrysCompanion(
          fieldListId: Value(entryEntity.fieldListId),
          answer: Value(entryEntity.answer),
          question: Value(entryEntity.question),
          creationAt: Value(entryEntity.creationAt),
          lastModificationAt: Value(entryEntity.lastModificationAt),
          order: Value(entryEntity.order),
          didAskedAtCurrentTestRound: Value(
            entryEntity.didAskedAtCurrentTestRound,
          ),
          emulatedCreatedAt: Value(entryEntity.emulatedCreatedAt),
          rank: Value(entryEntity.rank.index),
          askedCount: Value(BigInt.from(entryEntity.askedCount)),
          wronglyAnsweredCount: Value(
            BigInt.from(entryEntity.wronglyAnsweredCount),
          ),
        ),
      ),
    ).thenAnswer((_) => Future.value(2));
    expectLater(entriesRepository.create(entryEntity), completion(2));
  });
}
