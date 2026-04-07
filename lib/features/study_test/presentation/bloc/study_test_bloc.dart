import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'study_test_event.dart';
import 'study_test_state.dart';

class StudyTestBloc extends Bloc<StudyTestEvent, StudyTestState> {
  StudyTestBloc(super.state) {
    on<ChangeEntry>(_onChangeEntry);
    on<ChangeTab>(_onChangeTab);
  }

  void _onChangeEntry(ChangeEntry event, Emitter<StudyTestState> emit) {
    emit(state.copyWith(currentEntryIndex: event.index));
  }

  void _onChangeTab(ChangeTab event, Emitter<StudyTestState> emit) {
    emit(
      state.copyWith(
        counts: state.counts.mapIndexed((index, count) {
          if (index == state.currentEntryIndex) {
            return (count.$1, count.$2, event.tab);
          } else {
            return count;
          }
        }).toList(),
      ),
    );
  }
}
