import 'package:drift/drift.dart';

import '../../../../database/app_database.dart';
import '../../../../database/entrys_dao.dart';
import '../../domain/models/entry_entity.dart';
import 'entries_repository.dart';

class EntriesRepositoryLocal implements EntriesRepository {
  const EntriesRepositoryLocal(this._entrysDao);
  final EntrysDao _entrysDao;

  @override
  Stream<List<EntryEntity>> watch(String fieldListId) => _entrysDao
      .watchByFieldListId(fieldListId)
      .map(
        (list) => list
            .map(
              (entry) => EntryEntity(
                id: entry.id,
                fieldListId: entry.fieldListId,
                answer: entry.answer,
                question: entry.question,
                creationAt: entry.creationAt,
                lastModificationAt: entry.lastModificationAt,
                order: entry.order,
                didAskedAtCurrentTestRound: entry.didAskedAtCurrentTestRound,
                emulatedCreatedAt: entry.emulatedCreatedAt,
                rank: switch (entry.rank) {
                  0 => Rank.low,
                  1 => Rank.normal,
                  2 => Rank.important,
                  3 => Rank.vital,
                  _ => throw AssertionError('Invalid rank'),
                },
                askedCount: entry.askedCount.toInt(),
                wronglyAnsweredCount: entry.wronglyAnsweredCount.toInt(),
                lastAskedAt: entry.lastAskedAt,
              ),
            )
            .toList(),
      );

  @override
  Stream<List<EntryEntity>> search(String fieldListId, String text) =>
      _entrysDao
          .searchByTextInQuestionOrAnswer(fieldListId, text)
          .map(
            (list) => list
                .map(
                  (entry) => EntryEntity(
                    id: entry.id,
                    fieldListId: entry.fieldListId,
                    answer: entry.answer,
                    question: entry.question,
                    creationAt: entry.creationAt,
                    lastModificationAt: entry.lastModificationAt,
                    order: entry.order,
                    didAskedAtCurrentTestRound:
                        entry.didAskedAtCurrentTestRound,
                    emulatedCreatedAt: entry.emulatedCreatedAt,
                    rank: switch (entry.rank) {
                      0 => Rank.low,
                      1 => Rank.normal,
                      2 => Rank.important,
                      3 => Rank.vital,
                      _ => throw AssertionError('Invalid rank'),
                    },
                    askedCount: entry.askedCount.toInt(),
                    wronglyAnsweredCount: entry.wronglyAnsweredCount.toInt(),
                    lastAskedAt: entry.lastAskedAt,
                  ),
                )
                .toList(),
          );

  @override
  Future<int> create(EntryEntity entryEntity) => _entrysDao.create(
    EntrysCompanion(
      fieldListId: Value(entryEntity.fieldListId),
      answer: Value(entryEntity.answer),
      question: Value(entryEntity.question),
      creationAt: Value(entryEntity.creationAt),
      lastModificationAt: Value(entryEntity.lastModificationAt),
      order: Value(entryEntity.order),
      didAskedAtCurrentTestRound: Value(entryEntity.didAskedAtCurrentTestRound),
      emulatedCreatedAt: Value(entryEntity.emulatedCreatedAt),
      rank: Value(entryEntity.rank.index),
      askedCount: Value(BigInt.from(entryEntity.askedCount)),
      wronglyAnsweredCount: Value(
        BigInt.from(entryEntity.wronglyAnsweredCount),
      ),
    ),
  );

  @override
  Future<bool> update(EntryEntity entryEntity) => _entrysDao.mutate(
    EntrysCompanion(
      id: Value(entryEntity.id!),
      fieldListId: Value(entryEntity.fieldListId),
      answer: Value(entryEntity.answer),
      question: Value(entryEntity.question),
      creationAt: Value(entryEntity.creationAt),
      lastModificationAt: Value(entryEntity.lastModificationAt),
      order: Value(entryEntity.order),
      didAskedAtCurrentTestRound: Value(entryEntity.didAskedAtCurrentTestRound),
      emulatedCreatedAt: Value(entryEntity.emulatedCreatedAt),
      rank: Value(entryEntity.rank.index),
      askedCount: Value(BigInt.from(entryEntity.askedCount)),
      wronglyAnsweredCount: Value(
        BigInt.from(entryEntity.wronglyAnsweredCount),
      ),
    ),
  );
}
