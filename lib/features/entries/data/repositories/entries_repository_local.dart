import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/features/entries/data/repositories/entries_repository.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';

class EntriesRepositoryLocal implements EntriesRepository {
  const EntriesRepositoryLocal(this._entrysDao);
  final EntrysDao _entrysDao;

  @override
  Stream<List<EntryEntity>> watch(String fieldListId) {
    return _entrysDao
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
                  rank: entry.rank,
                  askedCount: entry.askedCount.toInt(),
                  wronglyAnsweredCount: entry.wronglyAnsweredCount.toInt(),
                ),
              )
              .toList(),
        );
  }
}
