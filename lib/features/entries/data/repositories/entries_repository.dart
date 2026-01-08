import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';

abstract class EntriesRepository {
  Future<int> create(EntryEntity entryEntity);
  Stream<List<EntryEntity>> watch(String fieldListId);
}
