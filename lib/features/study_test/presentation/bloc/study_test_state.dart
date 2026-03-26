import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_test_state.freezed.dart';

@freezed
abstract class StudyTestState with _$StudyTestState {
  const factory StudyTestState() = _StudyTestState;
}
