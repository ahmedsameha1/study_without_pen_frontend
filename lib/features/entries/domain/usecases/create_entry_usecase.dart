import 'package:clock/clock.dart';
import 'package:study_without_pen_by_flutter/features/entries/data/repositories/entries_repository.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';

class CreateEntryUsecase {
  const CreateEntryUsecase(this._entriesRepository);
  final EntriesRepository _entriesRepository;
  Future<int> call({
    required String fieldListId,
    required String answer,
    required String question,
    required int rank,
    required int order,
  }) {
    final now = clock.now();
    return _entriesRepository.create(
      EntryEntity(
        fieldListId: fieldListId,
        answer: answer,
        question: question,
        rank: rank,
        order: order,
        creationAt: now,
        lastModificationAt: now,
      ),
    );
  }
}
