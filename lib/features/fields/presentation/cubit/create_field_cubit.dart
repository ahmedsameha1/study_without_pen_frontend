import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/common/state_status.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/create_field_usecase.dart';

class CreateFieldCubit extends Cubit<StateStatus> {
  CreateFieldCubit(this.createFieldUseCase) : super(StateStatus.initial);
  final CreateFieldUseCase createFieldUseCase;

  Future<void> createField(String userAccountId, String name, int color) async {
    emit(StateStatus.loading);
    try {
      await createFieldUseCase.call(userAccountId, name, color);
      emit(StateStatus.success);
    } on AssertionError {
      emit(StateStatus.validationFailure);
      emit(StateStatus.initial);
    } catch (e) {
      emit(StateStatus.persistenceFailure);
      emit(StateStatus.initial);
    }
  }
}
