import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/create_field_usecase.dart';

enum CreateFieldState { initial, failure, success }

class CreateFieldCubit extends Cubit<CreateFieldState> {
  CreateFieldCubit(this.createFieldUseCase) : super(CreateFieldState.initial);
  final CreateFieldUseCase createFieldUseCase;

  void createField(
      String fieldId,
      String userAccountId,
      String name,
      DateTime creationAt,
      DateTime lastModificationAt,
      int usageCount,
      int color) {
    try {
      createFieldUseCase.call(fieldId, userAccountId, name, creationAt,
          lastModificationAt, usageCount, color);
      emit(CreateFieldState.success);
    } on ArgumentError {
      emit(CreateFieldState.failure);
    }
    emit(CreateFieldState.initial);
  }
}
