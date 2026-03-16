import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/entries_page_data.dart';
import '../../domain/usecases/watch_entries_usecase.dart';
import 'entries_event.dart';
import 'entries_state.dart';
import 'tab_data.dart';

class EntriesBloc extends Bloc<EntriesEvent, EntriesState> {
  EntriesBloc(this._watchEntriesUsecase) : super(const EntriesState()) {
    on<EntriesSubscriptionRequested>(_onSubscriptionRequested);
    on<PrepareScoreTab>(_onPrepareScoreTab, transformer: restartable());
    on<PrepareStrugglingTab>(
      _onPrepareStrugglingTab,
      transformer: restartable(),
    );
    on<PrepareTodayTab>(_onPrepareTodayTab, transformer: restartable());
    on<PrepareUnseenTab>(_onPrepareUnseenTab, transformer: restartable());
    on<PrepareBrowseTab>(_onPrepareBrowseTab, transformer: restartable());
  }
  final WatchEntriesUsecase _watchEntriesUsecase;
  static const scoreTabIndex = 0;
  static const strugglingTabIndex = 1;
  static const todayTabIndex = 2;
  static const unseenTabIndex = 3;
  static const browseTabIndex = 4;

  Future<void> _onSubscriptionRequested(
    EntriesSubscriptionRequested event,
    Emitter<EntriesState> emit,
  ) async {
    emit(state.copyWith(status: EntriesStatus.loading));
    await _prepareScoreTab(event.fieldListId, emit);
  }

  Future<void> _onPrepareScoreTab(
    PrepareScoreTab event,
    Emitter<EntriesState> emit,
  ) async {
    if (state.entriesPageData != null) {
      await _prepareScoreTab(state.entriesPageData!.fieldList.id!, emit);
    } else {
      emit(
        state.copyWith(
          status: EntriesStatus.failure,
          currentTabIndex: scoreTabIndex,
        ),
      );
    }
  }

  Future<void> _prepareScoreTab(
    String fieldListId,
    Emitter<EntriesState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          currentTabIndex: EntriesBloc.scoreTabIndex,
          tabs: const EntriesState().tabs.map((tab) => tab.copyWith()).toList(),
        ),
      );
      await emit.onEach<EntriesPageData>(
        _watchEntriesUsecase.watchEntriesForScore(fieldListId),
        onData: (entriesPageData) {
          emit(
            state.copyWith(
              status: EntriesStatus.success,
              currentTabIndex: EntriesBloc.scoreTabIndex,
              entriesPageData: entriesPageData,
              tabs: const EntriesState().tabs.map((tab) {
                if (tab.name == scoreTabName) {
                  return tab.copyWith(
                    status: TabDataStatus.ready,
                    entries: entriesPageData.entries,
                  );
                } else {
                  return tab.copyWith();
                }
              }).toList(),
            ),
          );
        },
        onError: (_, _) =>
            emit(const EntriesState(status: EntriesStatus.failure)),
      );
    } catch (e) {
      emit(const EntriesState(status: EntriesStatus.failure));
    }
  }

  Future<void> _onPrepareStrugglingTab(
    PrepareStrugglingTab event,
    Emitter<EntriesState> emit,
  ) async {
    await _prepareTab(
      emit,
      _watchEntriesUsecase.watchEntriesForStruggling,
      strugglingTabName,
      strugglingTabIndex,
    );
  }

  Future<void> _onPrepareTodayTab(
    PrepareTodayTab event,
    Emitter<EntriesState> emit,
  ) async {
    await _prepareTab(
      emit,
      _watchEntriesUsecase.watchEntriesForToday,
      todayTabName,
      todayTabIndex,
    );
  }

  Future<void> _onPrepareUnseenTab(
    PrepareUnseenTab event,
    Emitter<EntriesState> emit,
  ) async {
    await _prepareTab(
      emit,
      _watchEntriesUsecase.watchEntriesForUnseen,
      unseenTabName,
      unseenTabIndex,
    );
  }

  Future<void> _onPrepareBrowseTab(
    PrepareBrowseTab event,
    Emitter<EntriesState> emit,
  ) async {
    await _prepareTab(
      emit,
      _watchEntriesUsecase.watchEntriesForBrowse,
      browseTabName,
      browseTabIndex,
    );
  }

  Future<void> _prepareTab(
    Emitter<EntriesState> emit,
    Stream<EntriesPageData> Function(String fieldListId) call,
    String tabName,
    int tabIndex,
  ) async {
    if (state.entriesPageData != null) {
      emit(
        state.copyWith(
          currentTabIndex: tabIndex,
          tabs: const EntriesState().tabs.map((tab) => tab.copyWith()).toList(),
        ),
      );
      try {
        await emit.onEach<EntriesPageData>(
          call(state.entriesPageData!.fieldList.id!),
          onData: (entriesPageData) => emit(
            state.copyWith(
              status: EntriesStatus.success,
              tabs: const EntriesState().tabs.map((tab) {
                if (tab.name == tabName) {
                  return tab.copyWith(
                    status: TabDataStatus.ready,
                    entries: entriesPageData.entries,
                  );
                } else {
                  return tab.copyWith();
                }
              }).toList(),
            ),
          ),
          onError: (_, _) => emit(
            const EntriesState().copyWith(
              status: EntriesStatus.failure,
              currentTabIndex: tabIndex,
            ),
          ),
        );
      } catch (e) {
        emit(
          const EntriesState().copyWith(
            status: EntriesStatus.failure,
            currentTabIndex: tabIndex,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(
          status: EntriesStatus.failure,
          currentTabIndex: tabIndex,
        ),
      );
    }
  }
}
