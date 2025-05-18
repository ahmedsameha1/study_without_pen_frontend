import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/usecases/create_field_usecase.dart';

enum CreateFieldState {
  initial,
  loading,
  validationFailure,
  persistenceFailure,
  success
}

class CreateFieldCubit extends Cubit<CreateFieldState> {
  CreateFieldCubit(this.createFieldUseCase) : super(CreateFieldState.initial);
  final CreateFieldUseCase createFieldUseCase;

  Future<void> createField(String userAccountId, String name, int color) async {
    emit(CreateFieldState.loading);
    try {
      await createFieldUseCase.call(userAccountId, name, color);
      emit(CreateFieldState.success);
    } on AssertionError {
      emit(CreateFieldState.validationFailure);
      emit(CreateFieldState.initial);
    } catch (e) {
      emit(CreateFieldState.persistenceFailure);
      emit(CreateFieldState.initial);
    }
  }
}
