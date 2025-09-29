import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/watch_field_lists_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_state.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_field_usecase.dart';

class FieldListsBloc extends Bloc<FieldListsEvent, FieldListsState> {
  FieldListsBloc(this._watchFieldUsecase, this._watchFieldListsUsecase)
      : super(const FieldListsState()) {
    on<FieldListsSubscriptionRequested>(_onSubscriptionRequested);
  }

  final WatchFieldUsecase _watchFieldUsecase;
  final WatchFieldListsUsecase _watchFieldListsUsecase;

  Future<void> _onSubscriptionRequested(
    FieldListsSubscriptionRequested event,
    Emitter<FieldListsState> emit,
  ) async {
    emit(state.copyWith(status: FieldListsStatus.loading));
    try {
      emit.forEach<FieldEntity?>(_watchFieldUsecase.call(event.fieldId),
          onData: (field) {
        if (field == null) {
          return state.copyWith(status: FieldListsStatus.failure);
        }
        if ((state.status == FieldListsStatus.loading ||
                state.status == FieldListsStatus.success) &&
            state.fieldLists != null) {
          return state.copyWith(
              status: FieldListsStatus.success, fieldName: field.name);
        } else {
          return state.copyWith(fieldName: field.name);
        }
      }, onError: (_, __) {
        return state.copyWith(status: FieldListsStatus.failure);
      });
    } catch (e) {
      emit(state.copyWith(status: FieldListsStatus.failure));
    }
    try {
       emit.forEach<List<FieldListEntity>>(
          _watchFieldListsUsecase.call(event.fieldId), onData: (fieldLists) {
        if ((state.status == FieldListsStatus.loading ||
                state.status == FieldListsStatus.success) &&
            state.fieldName != null) {
          return state.copyWith(
              status: FieldListsStatus.success, fieldLists: fieldLists);
        } else {
          return state.copyWith(fieldLists: fieldLists);
        }
      }, onError: (_, __) {
        return state.copyWith(status: FieldListsStatus.failure);
      });
    } catch (e) {
      emit(state.copyWith(status: FieldListsStatus.failure));
    }
  }
}
