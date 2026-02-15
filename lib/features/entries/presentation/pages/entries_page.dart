import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/router_config.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/usecases/watch_entries_usecase.dart';
import '../bloc/entries_bloc.dart';
import '../bloc/entries_event.dart';
import '../bloc/entries_state.dart';
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
  void initState() {
    _tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
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
                              builder: (context, controller) =>
                                  const IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.search),
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
                        delegate: _StickyHeader(_tabController),
                      ),
                    ],
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        Builder(
                          key: const Key('scoreTabViewBuilder'),
                          builder: (context) => CustomScrollView(
                            slivers: [
                              SliverOverlapInjector(
                                handle:
                                    NestedScrollView.sliverOverlapAbsorberHandleFor(
                                      context,
                                    ),
                              ),
                              SliverPadding(
                                key: const Key('summerySliverPadding'),
                                padding: const EdgeInsetsGeometry.all(5),
                                sliver: SliverToBoxAdapter(
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.scoreSummary(
                                        state.entriesPageData!.entries.length,
                                        state.entriesPageData!.entries.length,
                                      ),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Theme.of(context).hintColor,
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
                                delegate: SliverChildBuilderDelegate(
                                  childCount:
                                      state.entriesPageData!.entries.length,
                                  (context, index) => EntryCard(
                                    entry:
                                        state.entriesPageData!.entries[index],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
}

class _StickyHeader extends SliverPersistentHeaderDelegate {
  TabController _tabController;
  _StickyHeader(this._tabController);
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
      tabs: [Text(AppLocalizations.of(context)!.score)],
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
