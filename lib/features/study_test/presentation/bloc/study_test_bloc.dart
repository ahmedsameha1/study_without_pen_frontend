import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../database/app_database.dart';
import 'study_test_event.dart';
import 'study_test_state.dart';

class StudyTestBloc extends Bloc<StudyTestEvent, StudyTestState> {
  StudyTestBloc(super.state) {
    on<ChangeEntry>(_onChangeEntry);
    on<ChangeTab>(_onChangeTab);
    on<CheckUserAnswer>(_onChangeUserAnswer);
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

  void _onChangeUserAnswer(
    CheckUserAnswer event,
    Emitter<StudyTestState> emit,
  ) {
    switch (state.fieldList.checkType) {
      case CheckType.DO_NOT_IGNORE_CASE:
        updateStateAccordingToAnswerChecking(
          event.userAnswer == state.entries[state.currentEntryIndex].answer,
          emit,
          event,
        );
        break;
      case CheckType.IGNORE_CASE:
        updateStateAccordingToAnswerChecking(
          event.userAnswer.toLowerCase() ==
              state.entries[state.currentEntryIndex].answer.toLowerCase(),
          emit,
          event,
        );
        break;
      default:
        updateStateAccordingToAnswerChecking(
          event.userAnswer == state.entries[state.currentEntryIndex].answer,
          emit,
          event,
        );
    }
  }

  void updateStateAccordingToAnswerChecking(
    bool result,
    Emitter<StudyTestState> emit,
    CheckUserAnswer event,
  ) {
    if (result) {
      emit(
        state.copyWith(
          isUserAnswerCorrect: true,
          counts: state.counts.mapIndexed((index, count) {
            if (index == state.currentEntryIndex) {
              if (count.$3 == 0) {
                return (count.$1 + 1, count.$2, count.$3);
              } else {
                return (count.$1, count.$2 + 1, count.$3);
              }
            } else {
              return count;
            }
          }).toList(),
        ),
      );
      emit(state.copyWith(isUserAnswerCorrect: false));
    }
  }
}
