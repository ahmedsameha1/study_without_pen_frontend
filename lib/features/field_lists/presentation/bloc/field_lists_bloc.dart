import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/models/field_lists_page_data.dart';
import '../../domain/usecases/watch_field_lists_with_entries_count_usecase.dart';
import 'field_lists_event.dart';
import 'field_lists_state.dart';

class FieldListsBloc extends Bloc<FieldListsEvent, FieldListsState> {
  FieldListsBloc(this._watchFieldListsWithEntriesCountUsecase)
    : super(const FieldListsState()) {
    on<FieldListsSubscriptionRequested>(_onSubscriptionRequested);
  }

  final WatchFieldListsWithEntriesCountUsecase
  _watchFieldListsWithEntriesCountUsecase;

  Future<void> _onSubscriptionRequested(
    FieldListsSubscriptionRequested event,
    Emitter<FieldListsState> emit,
  ) async {
    emit(state.copyWith(status: FieldListsStatus.loading));
    try {
      await emit.forEach<FieldListsPageData>(
        _watchFieldListsWithEntriesCountUsecase.call(event.fieldId),
        onData: (fieldListsPageData) {
          if (fieldListsPageData.field == null) {
            return state.copyWith(status: FieldListsStatus.failure);
          } else {
            return state.copyWith(
              status: FieldListsStatus.success,
              fieldListsPageData: fieldListsPageData,
            );
          }
        },
        onError: (_, _) => state.copyWith(status: FieldListsStatus.failure),
      );
    } catch (e) {
      emit(state.copyWith(status: FieldListsStatus.failure));
    }
  }
}
