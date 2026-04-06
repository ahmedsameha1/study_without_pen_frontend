import 'package:flutter_bloc/flutter_bloc.dart';

import 'study_test_event.dart';
import 'study_test_state.dart';

class StudyTestBloc extends Bloc<StudyTestEvent, StudyTestState> {
  StudyTestBloc(super.state) {
    on<ChangeEntry>(_onChangeEntry);
  }

  void _onChangeEntry(ChangeEntry event, Emitter<StudyTestState> emit) {
    emit(state.copyWith(currentEntryIndex: event.index));
  }
}
