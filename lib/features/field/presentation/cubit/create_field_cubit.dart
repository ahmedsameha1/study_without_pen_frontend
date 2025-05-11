import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/usecases/create_field_usecase.dart';

enum CreateFieldState {
  initial,
  validationFailure,
  persistanceFailure,
  success
}

class CreateFieldCubit extends Cubit<CreateFieldState> {
  CreateFieldCubit(this.createFieldUseCase) : super(CreateFieldState.initial);
  final CreateFieldUseCase createFieldUseCase;

  void createField(String userAccountId, String name, int color) {
    try {
      createFieldUseCase.call(userAccountId, name, color);
      emit(CreateFieldState.success);
    } on AssertionError {
      emit(CreateFieldState.validationFailure);
    } catch (e) {
      emit(CreateFieldState.persistanceFailure);
    }
    emit(CreateFieldState.initial);
  }
}
