import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';

abstract class EntriesRepository {
  Stream<List<EntryEntity>> watch(String fieldListId);
}
