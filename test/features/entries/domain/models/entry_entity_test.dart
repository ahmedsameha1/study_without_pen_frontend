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
  final rank = Rank.normal.index;
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

  test('EntryEntity throws AssertionError when created with an invalid rank', () {
    expect(
      () => EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        creationAt: creationAt,
        lastModificationAt: lastModificationAt,
        rank: Rank.low.index - 1,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message ==
                  'rank must be between ${Rank.low.index} and ${Rank.vital.index}',
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
        rank: Rank.vital.index + 1,
      ),
      throwsA(
        predicate(
          (e) =>
              e is AssertionError &&
              e.message ==
                  'rank must be between ${Rank.low.index} and ${Rank.vital.index}',
        ),
      ),
    );
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
      rank: rank,
    );
    expect(entry.rank, rank);
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
    expect(entry.rank, Rank.normal.index);
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
    'EntryEntity throws AssertionError when created with an invalid wrongness 1',
    () {
      expect(
        () => EntryEntity(
          fieldListId: fieldListId,
          answer: answer,
          question: question,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          rank: rank,
          wrongness: -1,
        ),
        throwsA(
          predicate(
            (e) =>
                e is AssertionError &&
                e.message == 'wrongness must be zero or bigger',
          ),
        ),
      );
    },
  );

  test(
    'EntryEntity throws AssertionError when created with an invalid wrongness 2',
    () {
      expect(
        () => EntryEntity(
          fieldListId: fieldListId,
          answer: answer,
          question: question,
          creationAt: creationAt,
          lastModificationAt: lastModificationAt,
          rank: rank,
          askedCount: 8,
          wronglyAnsweredCount: 2,
          wrongness: 1,
        ),
        throwsA(
          predicate(
            (e) =>
                e is AssertionError &&
                e.message == 'wrongness calculated wrongly',
          ),
        ),
      );
    },
  );

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
      wrongness: 1 / 3,
    );
    expect(entry.wrongness, closeTo(1 / 3, 0.000001));
  });

  test('EntryEntity wrongness got its default value', () {
    EntryEntity entry = EntryEntity(
      fieldListId: fieldListId,
      answer: answer,
      question: question,
      creationAt: creationAt,
      lastModificationAt: lastModificationAt,
      order: order,
      didAskedAtCurrentTestRound: didAskedAtCurrentTestRound,
    );
    expect(entry.wrongness, 0);
  });
}
