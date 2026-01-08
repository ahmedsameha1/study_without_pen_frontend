import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entries_page_data.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/usecases/watch_entries_usecase.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/entries_event.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/entries_state.dart';

class EntriesBloc extends Bloc<EntriesEvent, EntriesState> {
  EntriesBloc(this._watchEntriesUsecase) : super(const EntriesState()) {
    on<EntriesSubscriptionRequested>(_onSubscriptionRequested);
  }
  final WatchEntriesUsecase _watchEntriesUsecase;

  Future<void> _onSubscriptionRequested(
    EntriesSubscriptionRequested event,
    Emitter<EntriesState> emit,
  ) async {
    emit(state.copyWith(status: EntriesStatus.loading));
    try {
      await emit.forEach<EntriesPageData>(
        _watchEntriesUsecase.call(event.fieldListId),
        onData: (entriesPageData) => state.copyWith(
          status: EntriesStatus.success,
          entriesPageData: entriesPageData,
        ),
        onError: (_, _) => state.copyWith(status: EntriesStatus.failure),
      );
    } catch (e) {
      emit(state.copyWith(status: EntriesStatus.failure));
    }
  }
}
