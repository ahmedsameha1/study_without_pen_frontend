import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_bloc.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_state.dart';

void main() {
  test('Bloc has a correct initial state', () {
    expect(StudyTestBloc(const StudyTestState()).state, const StudyTestState());
  });
}
