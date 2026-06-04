import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_field_usecase.dart';
import 'create_field_event.dart';
import 'create_field_state.dart';

class CreateFieldBloc extends Bloc<CreateFieldEvent, CreateFieldState> {
  CreateFieldBloc(this._createFieldUsecase, this._userAccountId)
    : super(CreateFieldState(userAccountId: _userAccountId)) {
    on<CreateFieldNameChanged>(_onCreateFieldNameChanged);
    on<CreateFieldColorChanged>(_onCreateFieldColorChanged);
    on<CreateFieldSubmitted>(_onCreateFieldSubmitted);
  }
  final CreateFieldUsecase _createFieldUsecase;
  final String _userAccountId;

  void _onCreateFieldNameChanged(
    CreateFieldNameChanged event,
    Emitter<CreateFieldState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onCreateFieldColorChanged(
    CreateFieldColorChanged event,
    Emitter<CreateFieldState> emit,
  ) {
    emit(state.copyWith(color: event.color));
  }

  Future<void> _onCreateFieldSubmitted(
    CreateFieldSubmitted event,
    Emitter<CreateFieldState> emit,
  ) async {
    emit(state.copyWith(status: CreateFieldStatus.loading));
    try {
      await _createFieldUsecase.call(
        state.userAccountId,
        state.name,
        state.color,
      );
      emit(state.copyWith(status: CreateFieldStatus.success));
      emit(
        CreateFieldState(
          status: CreateFieldStatus.initial,
          userAccountId: _userAccountId,
        ),
      );
    } on AssertionError {
      emit(state.copyWith(status: CreateFieldStatus.validationFailure));
      emit(state.copyWith(status: CreateFieldStatus.initial));
    } catch (e) {
      emit(state.copyWith(status: CreateFieldStatus.persistenceFailure));
      emit(state.copyWith(status: CreateFieldStatus.initial));
    }
  }
}
