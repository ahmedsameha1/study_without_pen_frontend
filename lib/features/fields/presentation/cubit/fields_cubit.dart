import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/common/state_status.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_fields_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/cubit/fields_state.dart';

class FieldsCubit extends Cubit<FieldsState> {
  FieldsCubit(this._watchFieldsUsecase) : super(FieldsState());
  final WatchFieldsUsecase _watchFieldsUsecase;

  void watch(String userAccountId) {
    emit(FieldsState(StateStatus.loading, []));
    try {
      Stream<List<FieldEntity>> result =
          _watchFieldsUsecase.call(userAccountId);
      result.listen(
          (list) => emit(FieldsState(StateStatus.success, list)),
          onError: (_) => emit(FieldsState(StateStatus.failure, [])));
    } catch (e) {
      emit(FieldsState(StateStatus.failure, []));
    }
  }
}
