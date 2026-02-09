import 'package:clock/clock.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:uuid/uuid.dart';

void main() {
  final fieldListId = Uuid().v4();
  final answer = "answer";
  final question = 'question';
  final creationAt = DateTime(2024);
  final lastModificationAt = DateTime(2024);
  final order = 2;
  final didAskedAtCurrentTestRound = false;
  final emulatedCreatedAt = DateTime(2026);
  final rank = Rank.normal;
  final askedCount = 3;
  final wronglyAnsweredCount = 1;
  test(
    'EntryEntity throws AssertionError when created with invalid fieldListId',
    () {
      expect(
        () => EntryEntity(
          fieldListId: 'wohwoet',
          answer: 'answer',
          question: question,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
        ),
        throwsA(
          predicate(
            (e) =>
                e is AssertionError &&
                e.message == 'fieldListId is not a valid UUID v4',
          ),
        ),
      );
    },
  );

  test('EntryEntity fieldListId got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: 'answer',
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
    );
    expect(entry.fieldListId, fieldListId);
  });

  test('EntryEntity throws AssertionError when created with an invalid answer', () {
    expect(
      () => EntryEntity(
        fieldListId: fieldListId,
        answer: '',
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message ==
                  'answer must be between ${Entrys.minimumTextLength} and ${Entrys.maximumTextLength} characters',
        ),
      ),
    );

    expect(
      () => EntryEntity(
        fieldListId: fieldListId,
        answer: ' ',
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message ==
                  'answer must be between ${Entrys.minimumTextLength} and ${Entrys.maximumTextLength} characters',
        ),
      ),
    );

    expect(
      () => EntryEntity(
        fieldListId: fieldListId,
        answer: 'r' * 2001,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message ==
                  'answer must be between ${Entrys.minimumTextLength} and ${Entrys.maximumTextLength} characters',
        ),
      ),
    );
  });

  test('EntryEntity answer got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
    );
    expect(entry.answer, answer);
  });

  test('EntryEntity throws AssertionError when created with an invalid question', () {
    expect(
      () => EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: '',
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message ==
                  'question must be between ${Entrys.minimumTextLength} and ${Entrys.maximumTextLength} characters',
        ),
      ),
    );

    expect(
      () => EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: ' ',
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message ==
                  'question must be between ${Entrys.minimumTextLength} and ${Entrys.maximumTextLength} characters',
        ),
      ),
    );

    expect(
      () => EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: 'r' * 2001,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message ==
                  'question must be between ${Entrys.minimumTextLength} and ${Entrys.maximumTextLength} characters',
        ),
      ),
    );
    expect(
      () => EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: '${'r' * 2000} ',
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message ==
                  'question must be between ${Entrys.minimumTextLength} and ${Entrys.maximumTextLength} characters',
        ),
      ),
    );
  });

  test('EntryEntity question got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
    );
    expect(entry.question, question);
  });

  test('EntryEntity creationAt got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
    );
    expect(entry.creationAt, creationAt);
  });

  test(
    'EntryEntity throws AssertionError when created with invalid lastModificationAt',
    () {
      expect(
        () => EntryEntity(
          fieldListId: fieldListId,
          answer: 'answer',
          question: question,
          creationAt: creationAt,
          lastModificationAt: DateTime(2020),
        ),
        throwsA(
          predicate(
            (e) =>
                e is AssertionError &&
                e.message ==
                    'lastModificationAt must be equal or after creationAt',
          ),
        ),
      );
    },
  );

  test('EntryEntity lastModificationAt got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
    );
    expect(entry.lastModificationAt, lastModificationAt);
  });

  test('EntryEntity throws AssertionError when created with an invalid order', () {
    expect(
      () => EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: Entrys.ORDER_MINIMUM_VALUE - 1,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message ==
                  'order must be between ${Entrys.ORDER_MINIMUM_VALUE} and ${Entrys.ORDER_MAXIMUM_VALUE}',
        ),
      ),
    );

    expect(
      () => EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: Entrys.ORDER_MAXIMUM_VALUE + 1,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message ==
                  'order must be between ${Entrys.ORDER_MINIMUM_VALUE} and ${Entrys.ORDER_MAXIMUM_VALUE}',
        ),
      ),
    );
  });

  test('EntryEntity order got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
    );
    expect(entry.order, order);
  });

  test('EntryEntity order got its default value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
    );
    expect(entry.order, Entrys.ORDER_MINIMUM_VALUE);
  });

  test('EntryEntity didAskedAtCurrentTestRound got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
    );
    expect(entry.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound);
  });

  test('EntryEntity didAskedAtCurrentTestRound got its default value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
    );
    expect(entry.didAskedAtCurrentTestRound, true);
  });

  test('EntryEntity emulatedCreatedAt got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt,
    );
    expect(entry.emulatedCreatedAt, emulatedCreatedAt);
  });

  test('EntryEntity emulatedCreatedAt got its default value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
    );
    expect(entry.emulatedCreatedAt, null);
  });

  test('EntryEntity rank got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt,
      rank: Rank.vital,
    );
    expect(entry.rank, Rank.vital);
  });

  test('EntryEntity rank got its default value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
    );
    expect(entry.rank, Rank.normal);
  });

  test(
    'EntryEntity throws AssertionError when created with an invalid askedCount',
    () {
      expect(
        () => EntryEntity(
          fieldListId: fieldListId,
          answer: answer,
          question: question,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          rank: rank,
          askedCount: Entrys.ASKED_COUNT_MINIMUM_VALUE.toInt() - 1,
        ),
        throwsA(
          predicate(
            (e) =>
                e is AssertionError &&
                e.message == 'askedCount must be zero or bigger',
          ),
        ),
      );
    },
  );

  test('EntryEntity askedCount got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt,
      rank: rank,
      askedCount: askedCount,
    );
    expect(entry.askedCount, askedCount);
  });

  test('EntryEntity askedCount got its default value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
    );
    expect(entry.askedCount, Entrys.ASKED_COUNT_MINIMUM_VALUE.toInt());
  });

  test(
    'EntryEntity throws AssertionError when created with an invalid wronglyAnsweredCount',
    () {
      expect(
        () => EntryEntity(
          fieldListId: fieldListId,
          answer: answer,
          question: question,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          rank: rank,
          wronglyAnsweredCount:
              Entrys.WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE.toInt() - 1,
        ),
        throwsA(
          predicate(
            (e) =>
                e is AssertionError &&
                e.message == 'wronglyAnsweredCount must be zero or bigger',
          ),
        ),
      );
    },
  );

  test('EntryEntity wronglyAnsweredCount got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt,
      rank: rank,
      wronglyAnsweredCount: wronglyAnsweredCount,
    );
    expect(entry.wronglyAnsweredCount, wronglyAnsweredCount);
  });

  test('EntryEntity wronglyAnsweredCount got its default value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
    );
    expect(
      entry.wronglyAnsweredCount,
      Entrys.WRONGLY_ANSWERED_COUNT_MINIMUM_VALUE.toInt(),
    );
  });

  test(
    'EntryEntity throws AssertionError when created with an invalid lastAskedAt',
    () {
      withClock(Clock.fixed(DateTime.utc(2023, 1, 1)), () {
        expect(
          () => EntryEntity(
            fieldListId: fieldListId,
            answer: answer,
            question: question,
            creationAt: creationAt,
            lastModificationAt: lastModificationAt,
            rank: rank,
            lastAskedAt: DateTime.utc(2024, 1, 1),
          ),
          throwsA(
            predicate(
              (e) =>
                  e is AssertionError &&
                  e.message == 'lastAskedAt cannot be in the future',
            ),
          ),
        );
      });
    },
  );

  test('EntryEntity lastAskedAt got the correct value', () {
    withClock(Clock.fixed(DateTime.utc(2023, 1, 1)), () {
      EntryEntity entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: rank,
        lastAskedAt: DateTime.utc(2022, 1, 1),
      );
      expect(entry.lastAskedAt, DateTime.utc(2022, 1, 1));
    });
  });

  test('EntryEntity lastAskedAt got its default value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
    );
    expect(entry.lastAskedAt, isNull);
  });

  test('EntryEntity wrongness got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt,
      rank: rank,
      askedCount: 0,
      wronglyAnsweredCount: 0,
    );
    expect(entry.wrongness, closeTo(0, 0.001));
    entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt,
      rank: rank,
      askedCount: 3,
      wronglyAnsweredCount: 1,
    );
    expect(entry.wrongness, closeTo(1 / 3, 0.001));
  });

  test('EntryEntity score got the correct value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt,
      rank: rank,
      askedCount: 0,
      wronglyAnsweredCount: 0,
    );
    expect(entry.score, closeTo(0, 0.001));

    entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt,
      rank: Rank.low,
      askedCount: 3,
      wronglyAnsweredCount: 1,
      lastAskedAt: null,
    );
    expect(entry.score, closeTo(1 / 3, 0.001));

    entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt,
      rank: Rank.normal,
      askedCount: 3,
      wronglyAnsweredCount: 1,
      lastAskedAt: null,
    );
    expect(entry.score, closeTo(2 / 3, 0.001));

    entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt,
      rank: Rank.important,
      askedCount: 3,
      wronglyAnsweredCount: 1,
      lastAskedAt: null,
    );
    expect(entry.score, closeTo(1, 0.001));

    entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
      emulatedCreatedAt: emulatedCreatedAt,
      rank: Rank.vital,
      askedCount: 3,
      wronglyAnsweredCount: 1,
      lastAskedAt: null,
    );
    expect(entry.score, closeTo(1 + (1 / 3), 0.001));

    withClock(Clock.fixed(DateTime.utc(2023, 1, 31)), () {
      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.low,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 31),
      );
      expect(entry.score, closeTo(1 / 3, 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.normal,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 31),
      );
      expect(entry.score, closeTo(2 / 3, 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.important,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 31),
      );
      expect(entry.score, closeTo(1, 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.vital,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 31),
      );
      expect(entry.score, closeTo(1 + (1 / 3), 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.low,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 30),
      );
      expect(entry.score, closeTo(1 / 3, 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.normal,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 30),
      );
      expect(entry.score, closeTo(2 / 3, 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.important,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 30),
      );
      expect(entry.score, closeTo(1, 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.vital,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 30),
      );
      expect(entry.score, closeTo(1 + (1 / 3), 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.low,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 29),
      );
      expect(entry.score, closeTo(1 / 3, 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.normal,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 29),
      );
      expect(entry.score, closeTo(2 / 3, 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.important,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 29),
      );
      expect(entry.score, closeTo(1, 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.vital,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 29),
      );
      expect(entry.score, closeTo(1 + (1 / 3), 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.low,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 28),
      );
      expect(entry.score, closeTo(0.528320834, 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.normal,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 28),
      );
      expect(entry.score, closeTo(1.056641667, 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.important,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 28),
      );
      expect(entry.score, closeTo(1.584962501, 0.001));

      entry = EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        order: order,
        didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
        emulatedCreatedAt: emulatedCreatedAt,
        rank: Rank.vital,
        askedCount: 3,
        wronglyAnsweredCount: 1,
        lastAskedAt: DateTime.utc(2023, 1, 28),
      );
      expect(entry.score, closeTo(2.113283334, 0.001));
    });
  });
}
