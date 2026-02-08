import 'package:clock/clock.dart';
import 'package:study_without_pen_by_flutter/features/entries/data/repositories/entries_repository.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

import '../../../../database/entrys_dao.dart';

class CreateEntryUsecase {
  const CreateEntryUsecase(this._fieldListsRepository, this._entriesRepository);
  final EntriesRepository _entriesRepository;
  final FieldListsRepository _fieldListsRepository;
  Future<int> call({
    required String fieldListId,
    required String answer,
    required String question,
    required Rank rank,
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

  Stream<FieldListEntity?> watchFieldList(String fieldListId) {
    return _fieldListsRepository.watchFieldList(fieldListId);
  }
}
