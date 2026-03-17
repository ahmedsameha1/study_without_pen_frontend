import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/router_config.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/usecases/watch_entries_usecase.dart';
import '../bloc/entries_bloc.dart';
import '../bloc/entries_event.dart';
import '../bloc/entries_state.dart';
import '../bloc/tab_data.dart';
import 'entry_card.dart';

/// This page displays the list of entries
class EntriesPage extends StatelessWidget {
  const EntriesPage({
    required this.fieldId,
    required this.fieldListId,
    super.key,
  });
  final String fieldId;
  final String fieldListId;

  @override
  Widget build(BuildContext context) => BlocProvider<EntriesBloc>(
    create: (context) =>
        EntriesBloc(context.read<WatchEntriesUsecase>())
          ..add(EntriesSubscriptionRequested(fieldListId)),
    child: EntriesPageView(fieldId: fieldId, fieldListId: fieldListId),
  );
}

class EntriesPageView extends StatefulWidget {
  const EntriesPageView({
    required this.fieldId,
    required this.fieldListId,
    super.key,
  });
  final String fieldId;
  final String fieldListId;

  @override
  State<EntriesPageView> createState() => _EntriesPageViewState();
}

class _EntriesPageViewState extends State<EntriesPageView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void didChangeDependencies() {
    _tabController = TabController(
      length: BlocProvider.of<EntriesBloc>(context).state.tabs.length,
      vsync: this,
    );
    _tabController.addListener(_handleTabChange);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController
      ..removeListener(_handleTabChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<EntriesBloc, EntriesState>(
    builder: (context, state) {
      if (state.status == EntriesStatus.loading ||
          state.status == EntriesStatus.initial) {
        return const Scaffold(
          body: SafeArea(child: Center(child: CircularProgressIndicator())),
        );
      } else if (state.status == EntriesStatus.failure) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: Text(AppLocalizations.of(context)!.failureLoadingEntries),
            ),
          ),
        );
      } else {
        // EntriesStatus.success
        return Scaffold(
          appBar: state.entriesPageData!.entries.isEmpty
              ? AppBar(title: Text(state.entriesPageData!.fieldList.name))
              : null,
          body: SafeArea(
            child: state.entriesPageData!.entries.isEmpty
                ? Center(child: Text(AppLocalizations.of(context)!.noEntries))
                : NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context,
                        ),
                        sliver: SliverAppBar(
                          floating: true,
                          title: Text(state.entriesPageData!.fieldList.name),
                          actions: [
                            SearchAnchor(
                              builder: (context, controller) => IconButton(
                                onPressed: () {
                                  controller.openView();
                                },
                                icon: const Icon(Icons.search),
                              ),
                              suggestionsBuilder: (context, controller) => [],
                            ),
                          ],
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 15,
                          right: 15,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(AppLocalizations.of(context)!.mastered),
                              const SizedBox(
                                key: Key('masteredMasteryLineSizedBox'),
                                width: 5,
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 1,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: state.entriesPageData!.entries
                                            .where(
                                              (entry) => entry.wrongness <= 0.1,
                                            )
                                            .toList()
                                            .length,
                                        child: const SizedBox(
                                          height: 10,
                                          child: ColoredBox(
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: state.entriesPageData!.entries
                                            .where(
                                              (entry) =>
                                                  entry.wrongness > 0.1 &&
                                                  entry.wrongness <= 0.4,
                                            )
                                            .toList()
                                            .length,
                                        child: const SizedBox(
                                          height: 10,
                                          child: ColoredBox(
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: state.entriesPageData!.entries
                                            .where(
                                              (entry) => entry.wrongness > 0.4,
                                            )
                                            .toList()
                                            .length,
                                        child: SizedBox(
                                          height: 10,
                                          child: ColoredBox(
                                            color: Colors.red.shade700,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                key: Key('masteryLineNeedsFocusSizedBox'),
                                width: 5,
                              ),
                              Text(AppLocalizations.of(context)!.needsFocus),
                            ],
                          ),
                        ),
                      ),
                      SliverPersistentHeader(
                        key: const Key('sliverPersistentHeader'),
                        pinned: true,
                        delegate: _StickyHeader(
                          _tabController,
                          state.tabs
                              .map(
                                (tab) => Text(switch (tab.name) {
                                  scoreTabName => AppLocalizations.of(
                                    context,
                                  )!.score,
                                  strugglingTabName => AppLocalizations.of(
                                    context,
                                  )!.struggling,
                                  todayTabName => AppLocalizations.of(
                                    context,
                                  )!.today,
                                  unseenTabName => AppLocalizations.of(
                                    context,
                                  )!.unseen,
                                  browseTabName => AppLocalizations.of(
                                    context,
                                  )!.browse,
                                  _ => throw ArgumentError(tab.name),
                                }),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                    body: TabBarView(
                      controller: _tabController,
                      children: state.tabs
                          .map(
                            (tab) => tab.status == TabDataStatus.loading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Builder(
                                    builder: (context) => CustomScrollView(
                                      key: PageStorageKey<String>(tab.name),
                                      slivers: [
                                        SliverOverlapInjector(
                                          handle:
                                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                                context,
                                              ),
                                        ),
                                        SliverPadding(
                                          key: const Key(
                                            'descriptionSliverPadding',
                                          ),
                                          padding: const EdgeInsetsGeometry.all(
                                            5,
                                          ),
                                          sliver: SliverToBoxAdapter(
                                            child: Center(
                                              child: Text(
                                                switch (tab.description) {
                                                  scoreTabDescription =>
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.scoreDescription(
                                                      state
                                                          .entriesPageData!
                                                          .entries
                                                          .length,
                                                      tab.entries.length,
                                                    ),
                                                  strugglingTabDescription =>
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.strugglingDescription(
                                                      state
                                                          .entriesPageData!
                                                          .entries
                                                          .length,
                                                      tab.entries.length,
                                                    ),
                                                  todayTabDescription =>
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.todayDescription(
                                                      state
                                                          .entriesPageData!
                                                          .entries
                                                          .length,
                                                      tab.entries.length,
                                                    ),
                                                  unseenTabDescription =>
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.unseenDescription(
                                                      state
                                                          .entriesPageData!
                                                          .entries
                                                          .length,
                                                      tab.entries.length,
                                                    ),
                                                  browseTabDescription =>
                                                    AppLocalizations.of(
                                                      context,
                                                    )!.browseDescription(
                                                      state
                                                          .entriesPageData!
                                                          .entries
                                                          .length,
                                                      tab.entries.length,
                                                    ),
                                                  _ => throw ArgumentError(
                                                    tab.description,
                                                  ),
                                                },
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                      color: Theme.of(
                                                        context,
                                                      ).hintColor,
                                                    )
                                                    .copyWith(
                                                      backgroundColor: Theme.of(
                                                        context,
                                                      ).colorScheme.onSecondary,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SliverList(
                                          key: PageStorageKey<String>(tab.name),
                                          delegate: SliverChildBuilderDelegate(
                                            childCount: tab.entries.length,
                                            (context, index) => EntryCard(
                                              entry: tab.entries[index],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          )
                          .toList(),
                    ),
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => GoRouter.of(context).go(
              '$fieldListsPath${widget.fieldId}$entriesPath'
              '${state.entriesPageData!.fieldList.id!}$createEntry',
            ),
            child: const Icon(Icons.add),
          ),
        );
      }
    },
  );

  void _handleTabChange() {
    if (!_tabController.indexIsChanging) {
      if (_tabController.index == EntriesBloc.scoreTabIndex) {
        BlocProvider.of<EntriesBloc>(context).add(PrepareScoreTab());
      } else if (_tabController.index == EntriesBloc.strugglingTabIndex) {
        BlocProvider.of<EntriesBloc>(context).add(PrepareStrugglingTab());
      } else if (_tabController.index == EntriesBloc.todayTabIndex) {
        BlocProvider.of<EntriesBloc>(context).add(PrepareTodayTab());
      } else if (_tabController.index == EntriesBloc.unseenTabIndex) {
        BlocProvider.of<EntriesBloc>(context).add(PrepareUnseenTab());
      } else if (_tabController.index == EntriesBloc.browseTabIndex) {
        BlocProvider.of<EntriesBloc>(context).add(PrepareBrowseTab());
      } else {
        throw ArgumentError(_tabController.index);
      }
    }
  }
}

class _StickyHeader extends SliverPersistentHeaderDelegate {
  _StickyHeader(this._tabController, this._tabsWidgets);
  final TabController _tabController;
  final List<Widget> _tabsWidgets;
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => Container(
    color: Theme.of(context).scaffoldBackgroundColor,
    alignment: Alignment.center,
    child: TabBar(
      controller: _tabController,
      isScrollable: true,
      tabs: _tabsWidgets,
    ),
  );

  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
