import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/models/entries_page_data.dart';
import '../../domain/models/entry_entity.dart';
import '../../domain/usecases/watch_entries_usecase.dart';
import 'entries_event.dart';
import 'entries_state.dart';
import 'tab_data.dart';

class EntriesBloc extends Bloc<EntriesEvent, EntriesState> {
  EntriesBloc(this._watchEntriesUsecase) : super(const EntriesState()) {
    on<EntriesSubscriptionRequested>(
      _onSubscriptionRequested,
      transformer: sequential(),
    );
    on<NewData>(_onNewData, transformer: sequential());
    on<PrepareTab>(_onPrepareTab, transformer: sequential());
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
    try {
      await emit.onEach<EntriesPageData>(
        _watchEntriesUsecase.watchData(event.fieldListId),
        onData: (entriesPageData) {
          add(NewData(entriesPageData));
          add(PrepareTab(state.currentTabIndex, DateTime.now()));
        },
        onError: (_, _) => emit(state.copyWith(status: EntriesStatus.failure)),
      );
    } catch (e) {
      emit(state.copyWith(status: EntriesStatus.failure));
    }
  }

  void _onNewData(NewData event, Emitter<EntriesState> emit) {
    emit(
      state.copyWith(
        status: EntriesStatus.success,
        entriesPageData: event.data,
        tabs: state.tabs
            .map(
              (tab) => tab.copyWith(
                status: TabDataStatus.loading,
                outdated: true,
                entries: [],
              ),
            )
            .toList(),
      ),
    );
  }

  Future<void> _onPrepareTab(
    PrepareTab event,
    Emitter<EntriesState> emit,
  ) async {
    if (state.tabs[event.tabIndex].outdated) {
      List<TabData> tabs = [...state.tabs];
      final tab = tabs.removeAt(event.tabIndex);
      tabs.insert(
        event.tabIndex,
        TabData(
          outdated: false,
          name: tab.name,
          description: tab.description,
          status: TabDataStatus.ready,
          entries: await compute<List<EntryEntity>, List<EntryEntity>>(
            (List<EntryEntity> entries) => switch (event.tabIndex) {
              scoreTabIndex =>
                entries..sort((a, b) => a.score >= b.score ? -1 : 1),
              strugglingTabIndex =>
                entries.where((entry) => entry.wrongness > 0.6).toList()
                  ..sort((a, b) => a.score >= b.score ? -1 : 1),
              todayTabIndex =>
                entries
                    .where(
                      (entry) =>
                          entry.creationAt.year == event.now.year &&
                          entry.creationAt.month == event.now.month &&
                          entry.creationAt.day == event.now.day,
                    )
                    .toList()
                  ..sort(
                    (a, b) =>
                        b.creationAt.difference(a.creationAt).inMicroseconds,
                  ),
              unseenTabIndex =>
                entries
                    .where(
                      (entry) =>
                          entry.askedCount == 0 &&
                          !(entry.creationAt.year == event.now.year &&
                              entry.creationAt.month == event.now.month &&
                              entry.creationAt.day == event.now.day),
                    )
                    .toList()
                  ..sort(
                    (a, b) =>
                        b.creationAt.difference(a.creationAt).inMicroseconds,
                  ),
              browseTabIndex =>
                entries..sort((a, b) {
                  final orderResult = a.order.compareTo(b.order);
                  if (orderResult != 0) {
                    return orderResult;
                  } else {
                    final questionResult = a.question.compareTo(b.question);
                    if (questionResult != 0) {
                      return questionResult;
                    } else {
                      return b.creationAt
                          .difference(a.creationAt)
                          .inMicroseconds;
                    }
                  }
                }),
              _ => throw ArgumentError(''),
            },
            List<EntryEntity>.from(state.entriesPageData!.entries),
          ),
        ),
      );
      emit(state.copyWith(currentTabIndex: event.tabIndex, tabs: tabs));
    } else {
      emit(state.copyWith(currentTabIndex: event.tabIndex));
    }
  }
}
