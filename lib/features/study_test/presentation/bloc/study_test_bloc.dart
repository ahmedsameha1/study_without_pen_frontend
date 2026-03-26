import 'package:flutter_bloc/flutter_bloc.dart';

import 'study_test_event.dart';
import 'study_test_state.dart';

class StudyTestBloc extends Bloc<StudyTestEvent, StudyTestState> {
  StudyTestBloc(StudyTestState state) : super(state);
}
