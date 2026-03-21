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
    on<SwitchToSearchTab>(_onSwitchToSearchTab);
    on<OpenSearch>(_onOpenSearch, transformer: sequential());
    on<SearchInputChanged>(_onSearchInputChanged, transformer: restartable());
    on<SubmitSearch>(_onSubmitSearch, transformer: restartable());
    on<CloseSearch>(_onCloseSearch, transformer: sequential());
  }
  final WatchEntriesUsecase _watchEntriesUsecase;
  static const scoreTabIndex = 0;
  static const strugglingTabIndex = 1;
  static const todayTabIndex = 2;
  static const unseenTabIndex = 3;
  static const browseTabIndex = 4;
  static const searchTabIndex = 5;

  Future<void> _onSubscriptionRequested(
    EntriesSubscriptionRequested event,
    Emitter<EntriesState> emit,
  ) async {
    emit(state.copyWith(status: EntriesStatus.loading));
    await _handleSubscription(event.fieldListId, emit);
  }

  Future<void> _onPrepareScoreTab(
    PrepareScoreTab event,
    Emitter<EntriesState> emit,
  ) async {
    await _prepareTab(
      emit,
      _watchEntriesUsecase.watchEntriesForScore,
      scoreTabName,
      scoreTabIndex,
    );
  }

  Future<void> _handleSubscription(
    String fieldListId,
    Emitter<EntriesState> emit,
  ) async {
    try {
      await emit.onEach<EntriesPageData>(
        _watchEntriesUsecase.watchEntriesForScore(fieldListId),
        onData: (entriesPageData) {
          if (state.currentTabIndex == EntriesBloc.scoreTabIndex) {
            emit(
              state.copyWith(
                status: EntriesStatus.success,
                entriesPageData: entriesPageData,
                tabs: const EntriesState().tabs.map((tab) {
                  if (tab.name == scoreTabName) {
                    return tab.copyWith(
                      status: TabDataStatus.ready,
                      entries: entriesPageData.entries,
                    );
                  } else {
                    return tab;
                  }
                }).toList(),
              ),
            );
          } else {
            emit(
              state.copyWith(
                status: EntriesStatus.success,
                entriesPageData: entriesPageData,
                tabs: state.tabs,
              ),
            );
          }
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
          status: EntriesStatus.success,
          currentTabIndex: tabIndex,
          entriesPageData: state.entriesPageData,
          tabs: state.tabs.map((tab) {
            if (tab.name != searchTabName) {
              return TabData(name: tab.name, description: tab.description);
            } else {
              return tab;
            }
          }).toList(),
        ),
      );
      try {
        await emit.onEach<EntriesPageData>(
          call(state.entriesPageData!.fieldList.id!),
          onData: (entriesPageData) => emit(
            state.copyWith(
              status: EntriesStatus.success,
              tabs: state.tabs.map((tab) {
                if (tab.name == tabName) {
                  return tab.copyWith(
                    status: TabDataStatus.ready,
                    entries: entriesPageData.entries,
                  );
                } else {
                  return tab;
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

  Future<void> _onSwitchToSearchTab(
    SwitchToSearchTab event,
    Emitter<EntriesState> emit,
  ) async {
    emit(state.copyWith(currentTabIndex: EntriesBloc.searchTabIndex));
  }

  Future<void> _onSearchInputChanged(
    SearchInputChanged event,
    Emitter<EntriesState> emit,
  ) async {
    if (state.entriesPageData != null) {
      if (event.searchText.isNotEmpty) {
        emit(
          state.copyWith(
            tabs: state.tabs.map((tab) {
              if (tab.name == searchTabName) {
                return const TabData(
                  name: searchTabName,
                  description: searchTabDescription,
                );
              } else {
                return tab;
              }
            }).toList(),
          ),
        );
        try {
          await emit.forEach(
            _watchEntriesUsecase.watchSearchData(
              state.entriesPageData!.fieldList.id!,
              event.searchText,
            ),
            onData: (entries) => state.copyWith(
              tabs: state.tabs.map((tab) {
                if (tab.name == searchTabName) {
                  return TabData(
                    status: TabDataStatus.ready,
                    name: searchTabName,
                    description: searchTabDescription,
                    entries: entries,
                  );
                } else {
                  return tab;
                }
              }).toList(),
            ),
            onError: (_, _) => state.copyWith(
              tabs: state.tabs.map((tab) {
                if (tab.name == searchTabName) {
                  return const TabData(
                    status: TabDataStatus.failure,
                    name: searchTabName,
                    description: searchTabDescription,
                  );
                } else {
                  return tab;
                }
              }).toList(),
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              tabs: state.tabs.map((tab) {
                if (tab.name == searchTabName) {
                  return const TabData(
                    status: TabDataStatus.failure,
                    name: searchTabName,
                    description: searchTabDescription,
                  );
                } else {
                  return tab;
                }
              }).toList(),
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            tabs: state.tabs.map((tab) {
              if (tab.name == searchTabName) {
                return const TabData(
                  status: TabDataStatus.ready,
                  name: searchTabName,
                  description: searchTabDescription,
                );
              } else {
                return tab;
              }
            }).toList(),
          ),
        );
      }
    } else {
      emit(const EntriesState(status: EntriesStatus.failure));
    }
  }

  Future<void> _onSubmitSearch(
    SubmitSearch event,
    Emitter<EntriesState> emit,
  ) async {
    if (state.entriesPageData != null) {
      if (event.searchText.isNotEmpty) {
        emit(
          state.copyWith(
            status: EntriesStatus.success,
            currentTabIndex: searchTabIndex,
            tabs: state.tabs.map((tab) {
              if (tab.name == searchTabName) {
                return const TabData(
                  name: searchTabName,
                  description: searchTabDescription,
                );
              } else {
                return tab;
              }
            }).toList(),
          ),
        );
        try {
          await emit.forEach(
            _watchEntriesUsecase.watchSearchData(
              state.entriesPageData!.fieldList.id!,
              event.searchText,
            ),
            onData: (entries) => state.copyWith(
              tabs: state.tabs.map((tab) {
                if (tab.name == searchTabName) {
                  return TabData(
                    status: TabDataStatus.ready,
                    name: searchTabName,
                    description: searchTabDescription,
                    entries: entries,
                  );
                } else {
                  return tab;
                }
              }).toList(),
            ),
            onError: (_, _) => state.copyWith(
              status: EntriesStatus.success,
              tabs: state.tabs.map((tab) {
                if (tab.name == searchTabName) {
                  return const TabData(
                    status: TabDataStatus.failure,
                    name: searchTabName,
                    description: searchTabDescription,
                  );
                } else {
                  return tab;
                }
              }).toList(),
            ),
          );
        } catch (e) {
          emit(
            state.copyWith(
              status: EntriesStatus.success,
              tabs: state.tabs.map((tab) {
                if (tab.name == searchTabName) {
                  return const TabData(
                    status: TabDataStatus.failure,
                    name: searchTabName,
                    description: searchTabDescription,
                  );
                } else {
                  return tab;
                }
              }).toList(),
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: EntriesStatus.success,
            tabs: state.tabs.map((tab) {
              if (tab.name == searchTabName) {
                return const TabData(
                  status: TabDataStatus.ready,
                  name: searchTabName,
                  description: searchTabDescription,
                );
              } else {
                return tab;
              }
            }).toList(),
          ),
        );
      }
    } else {
      emit(const EntriesState(status: EntriesStatus.failure));
    }
  }

  Future<void> _onOpenSearch(
    OpenSearch event,
    Emitter<EntriesState> emit,
  ) async {
    emit(state.copyWith(status: EntriesStatus.search));
  }

  Future<void> _onCloseSearch(
    CloseSearch event,
    Emitter<EntriesState> emit,
  ) async {
    emit(state.copyWith(status: EntriesStatus.success));
  }
}
