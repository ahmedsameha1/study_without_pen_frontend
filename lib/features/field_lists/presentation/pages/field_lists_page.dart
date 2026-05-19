import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/router_config.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/usecases/watch_field_lists_usecase.dart';
import '../bloc/field_lists_bloc.dart';
import '../bloc/field_lists_event.dart';
import '../bloc/field_lists_state.dart';

class FieldListsPage extends StatelessWidget {
  const FieldListsPage(this.fieldId, {super.key});
  final String fieldId;

  @override
  Widget build(BuildContext context) => BlocProvider<FieldListsBloc>(
    create: (context) =>
        FieldListsBloc(context.read<WatchFieldListsUsecase>())
          ..add(FieldListsSubscriptionRequested(fieldId)),
    child: FieldListsPageView(fieldId: fieldId),
  );
}

class FieldListsPageView extends StatelessWidget {
  const FieldListsPageView({required this.fieldId, super.key});
  final String fieldId;

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<FieldListsBloc, FieldListsState>(
    builder: (context, state) => Scaffold(
      appBar: switch (state.status) {
        FieldListsStatus.success => AppBar(
          title: Text(state.fieldListsPageData!.field!.name),
          actions: [
            PopupMenuButton<Text>(
              itemBuilder: (_) => [
                PopupMenuItem(child: Text(AppLocalizations.of(context)!.notes)),
              ],
            ),
          ],
        ),
        _ => null,
      },
      body: switch (state.status) {
        FieldListsStatus.loading || FieldListsStatus.initial => const Center(
          child: CircularProgressIndicator(),
        ),
        FieldListsStatus.failure => Center(
          child: Text(AppLocalizations.of(context)!.failureLoadingData),
        ),
        FieldListsStatus.success =>
          state.fieldListsPageData!.fieldLists.isEmpty
              ? Center(child: Text(AppLocalizations.of(context)!.noFieldLists))
              : Scrollbar(
                  thumbVisibility: true,
                  trackVisibility: true,
                  interactive: true,
                  thickness: 10,
                  radius: const Radius.circular(8),
                  child: MasonryGridView.count(
                    padding: const EdgeInsets.all(10),
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    crossAxisCount: 2,
                    itemCount: state.fieldListsPageData!.fieldLists.length,
                    itemBuilder: (BuildContext context, int index) {
                      final fieldList =
                          state.fieldListsPageData!.fieldLists[index];
                      final color = Color(fieldList.color);
                      return InkWell(
                        onTap: () => GoRouter.of(context).go(
                          '$fieldListsPath$fieldId$entriesPath${state.fieldListsPageData!.fieldLists[index].id!}',
                        ),
                        child: Card(
                          color: color,
                          elevation: 2,
                          child: Padding(
                            key: const Key('cardContentPadding'),
                            padding: const EdgeInsetsGeometry.all(10),
                            child: Center(
                              child: Text(
                                fieldList.name,
                                style: TextStyle(
                                  color: color.computeLuminance() > 0.5
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
      },
      floatingActionButton: switch (state.status) {
        FieldListsStatus.success ||
        FieldListsStatus.failure => FloatingActionButton(
          onPressed: () => GoRouter.of(context).go(
            '$fieldListsPath${state.fieldListsPageData!.field!.id!}$createFieldList',
          ),
          child: const Icon(Icons.add),
        ),
        _ => null,
      },
    ),
  );
}
