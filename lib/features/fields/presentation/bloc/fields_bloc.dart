import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/delete_field_usecase.dart';
import '../../domain/usecases/watch_fields_with_field_lists_count_usecase.dart';
import 'fields_event.dart';
import 'fields_state.dart';

class FieldsBloc extends Bloc<FieldsEvent, FieldsState> {
  FieldsBloc(
    this._watchFieldsWithFieldListsCountUsecase,
    this._deleteFieldUsecase,
  ) : super(FieldsState()) {
    on<FieldsSubscriptionRequested>(_onFieldsSubscriptionRequested);
    on<DeleteField>(_onDeleteField);
  }
  final WatchFieldsWithFieldListsCountUsecase
  _watchFieldsWithFieldListsCountUsecase;
  final DeleteFieldUsecase _deleteFieldUsecase;

  Future<void> _onFieldsSubscriptionRequested(
    FieldsSubscriptionRequested event,
    Emitter<FieldsState> emit,
  ) async {
    emit(state.copyWith(status: FieldsStatus.loading));
    try {
      await emit.forEach(
        _watchFieldsWithFieldListsCountUsecase.call(event.userAccountId),
        onData: (fieldsWithFieldListsCount) => state.copyWith(
          status: FieldsStatus.success,
          fieldsWithFieldListsCount: fieldsWithFieldListsCount,
        ),
        onError: (_, _) => state.copyWith(status: FieldsStatus.failure),
      );
    } catch (e) {
      emit(state.copyWith(status: FieldsStatus.failure));
    }
  }

  Future<void> _onDeleteField(
    DeleteField event,
    Emitter<FieldsState> emit,
  ) async {
    emit(state.copyWith(status: FieldsStatus.loading));
    try {
      await _deleteFieldUsecase(event.fieldId);
      emit(state.copyWith(status: FieldsStatus.success));
    } catch (e) {
      emit(state.copyWith(status: FieldsStatus.failure));
    }
  }
}
