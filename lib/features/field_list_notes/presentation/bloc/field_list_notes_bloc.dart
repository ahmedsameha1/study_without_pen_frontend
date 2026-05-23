import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/watch_field_list_notes_usecase.dart';
import 'field_list_notes_event.dart';
import 'field_list_notes_state.dart';

class FieldListNotesBloc
    extends Bloc<FieldListNotesEvent, FieldListNotesState> {
  FieldListNotesBloc(this._watchFieldListNotesUsecase)
    : super(FieldListNotesState()) {
    on<FieldListNotesSubscriptionRequested>(_onSubscriptionRequested);
  }
  WatchFieldListNotesUsecase _watchFieldListNotesUsecase;

  Future<void> _onSubscriptionRequested(
    FieldListNotesSubscriptionRequested event,
    Emitter<FieldListNotesState> emit,
  ) async {
    emit(state.copyWith(status: FieldListNotesStatus.loading));
    try {
      await emit.forEach(
        _watchFieldListNotesUsecase.call(event.fieldListId),
        onData: (fieldListNotesPageData) => state.copyWith(
          status: FieldListNotesStatus.success,
          fieldListNotesPageData: fieldListNotesPageData,
        ),
        onError: (_, _) => state.copyWith(status: FieldListNotesStatus.failure),
      );
    } catch (e) {
      emit(state.copyWith(status: FieldListNotesStatus.failure));
    }
  }
}
