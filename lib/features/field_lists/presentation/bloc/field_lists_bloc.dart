import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_state.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_field_usecase.dart';

class FieldListsBloc extends Bloc<FieldListsEvent, FieldListsState> {
  FieldListsBloc(this.watchFieldUsecase) : super(const FieldListsState()) {
    on<FieldListsSubscriptionRequested>(_onSubscriptionRequested);
  }

  final WatchFieldUsecase watchFieldUsecase;

  Future<void> _onSubscriptionRequested(
    FieldListsSubscriptionRequested event,
    Emitter<FieldListsState> emit,
  ) async {
    emit(state.copyWith(status: FieldListsStatus.loading));
    try {
      await emit.forEach<FieldEntity?>(watchFieldUsecase.call(event.fieldId),
          onData: (field) {
            if (field == null) {
              return state.copyWith(status: FieldListsStatus.failure);
            }
            return state.copyWith(
                status: FieldListsStatus.success, fieldName: field.name);
          },
          onError: (_, __) => state.copyWith(status: FieldListsStatus.failure));
    } catch (e) {
      emit(state.copyWith(status: FieldListsStatus.failure));
    }
  }
}
