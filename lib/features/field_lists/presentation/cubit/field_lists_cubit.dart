import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/common/state_status.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/usecases/watch_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/cubit/field_lists_state.dart';

class FieldListsCubit extends Cubit<FieldListsState> {
  FieldListsCubit(this._watchFieldUsecase) : super(FieldListsState());

  final WatchFieldUsecase _watchFieldUsecase;

  void watch(String fieldId) {
    emit(FieldListsState(StateStatus.loading));
    try {
      Stream<FieldEntity> stream = _watchFieldUsecase.call(fieldId);
      stream.listen((fieldEntity) {
        emit(FieldListsState(StateStatus.success, fieldEntity.name));
      });
    } catch (e) {
      emit(FieldListsState(StateStatus.failure));
    }
  }
}
