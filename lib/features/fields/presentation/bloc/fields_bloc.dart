import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/watch_fields_with_field_lists_count_usecase.dart';
import 'fields_event.dart';
import 'fields_state.dart';

class FieldsBloc extends Bloc<FieldsEvent, FieldsState> {
  FieldsBloc(this._watchFieldsWithFieldListsCountUsecase)
    : super(FieldsState()) {
    on<FieldsSubscriptionRequested>(_onFieldsSubscriptionRequested);
  }
  final WatchFieldsWithFieldListsCountUsecase
  _watchFieldsWithFieldListsCountUsecase;

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
}
