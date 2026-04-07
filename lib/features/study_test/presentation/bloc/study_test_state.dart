import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../entries/domain/models/entry_entity.dart';

part 'study_test_state.freezed.dart';

typedef EntryCounts = (int studyCount, int testCount, int tab);

@freezed
abstract class StudyTestState with _$StudyTestState {
  @Assert(
    'entries.length == counts.length',
    'entries length must be equal to counts length',
  )
  const factory StudyTestState({
    @Default([]) List<EntryEntity> entries,
    @Default(0) int currentEntryIndex,
    @Default([]) List<EntryCounts> counts,
  }) = _StudyTestState;
}
