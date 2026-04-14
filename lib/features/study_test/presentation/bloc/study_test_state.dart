import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../entries/domain/models/entry_entity.dart';
import '../../../field_lists/domain/models/field_list_entity.dart';

part 'study_test_state.freezed.dart';

typedef EntryCounts = (int studyCount, int testCount, int tab);

@freezed
abstract class StudyTestState with _$StudyTestState {
  @Assert(
    'entries.length == counts.length',
    'entries length must be equal to counts length',
  )
  const factory StudyTestState({
    required FieldListEntity fieldList,
    required List<EntryEntity> entries,
    required List<EntryCounts> counts,
    @Default(0) int currentEntryIndex,
    @Default('') String userAnswer,
  }) = _StudyTestState;
}
