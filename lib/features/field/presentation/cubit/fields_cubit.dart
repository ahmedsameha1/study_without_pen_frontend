import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/usecases/watch_fields_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/cubit/fields_state.dart';

class FieldsCubit extends Cubit<FieldsState> {
  FieldsCubit(this._watchFieldsUsecase) : super(FieldsState());
  final WatchFieldsUsecase _watchFieldsUsecase;

  void watch(String userAccountId) {
    emit(FieldsState(FieldsStateStatus.loading, []));
    try {
      Stream<List<FieldEntity>> result =
          _watchFieldsUsecase.call(userAccountId);
      result.listen(
          (list) => emit(FieldsState(FieldsStateStatus.success, list)),
          onError: (_) => emit(FieldsState(FieldsStateStatus.failure, [])));
    } catch (e) {
      emit(FieldsState(FieldsStateStatus.failure, []));
    }
  }
}
