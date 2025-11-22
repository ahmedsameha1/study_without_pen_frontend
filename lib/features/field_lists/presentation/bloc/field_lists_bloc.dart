import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_lists_page_data.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/watch_field_lists_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_state.dart';

class FieldListsBloc extends Bloc<FieldListsEvent, FieldListsState> {
  FieldListsBloc(this._watchFieldListsUsecase)
      : super(const FieldListsState()) {
    on<FieldListsSubscriptionRequested>(_onSubscriptionRequested);
  }

  final WatchFieldListsUsecase _watchFieldListsUsecase;

  Future<void> _onSubscriptionRequested(
    FieldListsSubscriptionRequested event,
    Emitter<FieldListsState> emit,
  ) async {
    emit(state.copyWith(status: FieldListsStatus.loading));
    try {
      await emit.forEach<FieldListsPageData>(
          _watchFieldListsUsecase.call(event.fieldId),
          onData: (fieldListsPageData) {
        if (fieldListsPageData.field == null) {
          return state.copyWith(status: FieldListsStatus.failure);
        } else {
          return state.copyWith(
              status: FieldListsStatus.success,
              fieldListsPageData: fieldListsPageData);
        }
      }, onError: (_, __) {
        return state.copyWith(status: FieldListsStatus.failure);
      });
    } catch (e) {
      emit(state.copyWith(status: FieldListsStatus.failure));
    }
  }
}
