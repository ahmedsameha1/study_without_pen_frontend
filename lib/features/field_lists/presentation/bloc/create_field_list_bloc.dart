import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/create_field_list_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_state.dart';

class CreateFieldListBloc
    extends Bloc<CreateFieldListEvent, CreateFieldListState> {
  CreateFieldListBloc(this._createFieldListUsecase, this._fieldId)
    : super(CreateFieldListState(fieldId: _fieldId)) {
    on<CreateFieldListNameChanged>(_onNameChanged);
    on<CreateFieldListCheckTypeChanged>(_onCheckTypeChanged);
    on<CreateFieldListReadAnswerChanged>(_onReadAnswerChanged);
    on<CreateFieldListColorChanged>(_onColorChanged);
    on<CreateFieldListSubmitted>(_onSubmitted);
  }
  final CreateFieldListUsecase _createFieldListUsecase;
  final String _fieldId;

  void _onNameChanged(
    CreateFieldListNameChanged event,
    Emitter<CreateFieldListState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onCheckTypeChanged(
    CreateFieldListCheckTypeChanged event,
    Emitter<CreateFieldListState> emit,
  ) {
    emit(state.copyWith(checkType: event.checkType));
  }

  void _onReadAnswerChanged(
    CreateFieldListReadAnswerChanged event,
    Emitter<CreateFieldListState> emit,
  ) {
    emit(state.copyWith(readAnswer: event.readAnswer));
  }

  void _onColorChanged(
    CreateFieldListColorChanged event,
    Emitter<CreateFieldListState> emit,
  ) {
    emit(state.copyWith(color: event.color));
  }

  Future<void> _onSubmitted(
    CreateFieldListSubmitted event,
    Emitter<CreateFieldListState> emit,
  ) async {
    emit(state.copyWith(status: CreateFieldListStatus.loading));
    try {
      await _createFieldListUsecase.call(
        _fieldId,
        state.name,
        state.checkType,
        state.readAnswer,
        state.color,
      );
      emit(state.copyWith(status: CreateFieldListStatus.success));
    } catch (e) {
      emit(state.copyWith(status: CreateFieldListStatus.failure));
    }
  }
}
