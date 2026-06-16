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
  String id = const Uuid().v4();
  EntryEntity entryEntity = EntryEntity(
    id: id,
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

  EntryEntity entryEntity2 = EntryEntity(
    id: id,
    fieldListId: Uuid().v4(),
    answer: 'answer2',
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
      ).thenThrow(
        SqliteException(extendedResultCode: 1, message: 'sqlexception'),
      );
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
        ).thenThrow(
          SqliteException(extendedResultCode: 1, message: 'sqlexception'),
        );
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

  group('create()', () {
    test('throws what EntrysDao.create() throw', () {
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
      ).thenThrow(
        SqliteException(extendedResultCode: 1, message: 'sqlexception'),
      );
      expect(
        () => entriesRepository.create(entryEntity),
        throwsA(
          predicate((e) => e is SqliteException && e.message == 'sqlexception'),
        ),
      );
    });

    test('returns what EntrysDao.create() return', () {
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
  });

  group('update()', () {
    test('throws what EntrysDao.mutate() throw 1', () {
      when(
        () => entrysDao.mutate(
          EntrysCompanion(
            id: Value(entryEntity2.id!),
            fieldListId: Value(entryEntity2.fieldListId),
            answer: Value(entryEntity2.answer),
            question: Value(entryEntity2.question),
            creationAt: Value(entryEntity2.creationAt),
            lastModificationAt: Value(entryEntity2.lastModificationAt),
            order: Value(entryEntity2.order),
            didAskedAtCurrentTestRound: Value(
              entryEntity2.didAskedAtCurrentTestRound,
            ),
            emulatedCreatedAt: Value(entryEntity2.emulatedCreatedAt),
            rank: Value(entryEntity2.rank.index),
            askedCount: Value(BigInt.from(entryEntity2.askedCount)),
            wronglyAnsweredCount: Value(
              BigInt.from(entryEntity2.wronglyAnsweredCount),
            ),
          ),
        ),
      ).thenThrow(
        SqliteException(extendedResultCode: 1, message: 'sqlexception'),
      );
      expect(
        () => entriesRepository.update(entryEntity2),
        throwsA(
          predicate((e) => e is SqliteException && e.message == 'sqlexception'),
        ),
      );
    });

    test('throws what EntrysDao.mutate() throw 2', () {
      when(
        () => entrysDao.mutate(
          EntrysCompanion(
            id: Value(entryEntity2.id!),
            fieldListId: Value(entryEntity2.fieldListId),
            answer: Value(entryEntity2.answer),
            question: Value(entryEntity2.question),
            creationAt: Value(entryEntity2.creationAt),
            lastModificationAt: Value(entryEntity2.lastModificationAt),
            order: Value(entryEntity2.order),
            didAskedAtCurrentTestRound: Value(
              entryEntity2.didAskedAtCurrentTestRound,
            ),
            emulatedCreatedAt: Value(entryEntity2.emulatedCreatedAt),
            rank: Value(entryEntity2.rank.index),
            askedCount: Value(BigInt.from(entryEntity2.askedCount)),
            wronglyAnsweredCount: Value(
              BigInt.from(entryEntity2.wronglyAnsweredCount),
            ),
          ),
        ),
      ).thenAnswer((_) => Future.error('Opps'));
      expect(entriesRepository.update(entryEntity2), throwsA('Opps'));
    });

    test('returns what EntrysDao.mutate() return', () {
      when(
        () => entrysDao.mutate(
          EntrysCompanion(
            id: Value(entryEntity2.id!),
            fieldListId: Value(entryEntity2.fieldListId),
            answer: Value(entryEntity2.answer),
            question: Value(entryEntity2.question),
            creationAt: Value(entryEntity2.creationAt),
            lastModificationAt: Value(entryEntity2.lastModificationAt),
            order: Value(entryEntity2.order),
            didAskedAtCurrentTestRound: Value(
              entryEntity2.didAskedAtCurrentTestRound,
            ),
            emulatedCreatedAt: Value(entryEntity2.emulatedCreatedAt),
            rank: Value(entryEntity2.rank.index),
            askedCount: Value(BigInt.from(entryEntity2.askedCount)),
            wronglyAnsweredCount: Value(
              BigInt.from(entryEntity2.wronglyAnsweredCount),
            ),
          ),
        ),
      ).thenAnswer((_) => Future.value(true));
      expectLater(entriesRepository.update(entryEntity2), completion(true));
    });
  });
}
