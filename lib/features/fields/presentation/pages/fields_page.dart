import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:nonso/nonso.dart' as nonso;

import '../../../../common/router_config.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/usecases/watch_fields_with_field_lists_count_usecase.dart'
    as nonso;
import '../bloc/fields_bloc.dart';
import '../bloc/fields_event.dart';
import '../bloc/fields_state.dart';

class FieldsPage extends StatelessWidget {
  const FieldsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<FieldsBloc>(
    create: (context) =>
        FieldsBloc(context.read<nonso.WatchFieldsWithFieldListsCountUsecase>())
          ..add(
            FieldsSubscriptionRequested(
              context.read<nonso.AuthBloc>().state.user!.uid,
            ),
          ),
    child: const FieldsPageView(),
  );
}

class FieldsPageView extends StatelessWidget {
  const FieldsPageView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(AppLocalizations.of(context)!.materialAppTitle),
      actions: [
        PopupMenuButton<Text>(
          itemBuilder: (_) => [
            PopupMenuItem<Text>(
              child: Text(AppLocalizations.of(context)!.signOut),
              onTap: () {
                context.read<nonso.AuthBloc>().signOut();
              },
            ),
            PopupMenuItem<Text>(
              child: Text(AppLocalizations.of(context)!.about),
              onTap: () {
                showAboutDialog(context: context);
              },
            ),
          ],
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        GoRouter.of(context).go(createFieldPath);
      },
      child: const Icon(Icons.add),
    ),
    body: BlocBuilder<FieldsBloc, FieldsState>(
      builder: (context, state) {
        if (state.status == FieldsStatus.loading ||
            state.status == FieldsStatus.initial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == FieldsStatus.failure) {
          return Center(
            child: Text(AppLocalizations.of(context)!.failureLoadingFields),
          );
        } else {
          if (state.fieldsWithFieldListsCount.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.noFields));
          } else {
            return Scrollbar(
              thumbVisibility: true,
              trackVisibility: true,
              thickness: 10.0,
              radius: const Radius.circular(8.0),
              interactive: true,
              child: MasonryGridView.count(
                padding: const EdgeInsets.all(10.0),
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                itemCount: state.fieldsWithFieldListsCount.length,
                itemBuilder: (context, index) {
                  final color = Color(
                    state.fieldsWithFieldListsCount[index].$1.color,
                  );
                  return Card(
                    color: color,
                    elevation: 2,
                    child: Padding(
                      key: const Key('cardContentPadding'),
                      padding: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          state.fieldsWithFieldListsCount[index].$1.name,
                          style: TextStyle(
                            color: color.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                            fontSize: Theme.of(
                              context,
                            ).textTheme.titleLarge!.fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${state.fieldsWithFieldListsCount[index].$2} ${AppLocalizations.of(context)!.lists}',
                          style: TextStyle(
                            color: color.computeLuminance() > 0.5
                                ? Colors.black
                                : Colors.white,
                            fontSize: Theme.of(
                              context,
                            ).textTheme.bodySmall!.fontSize,
                          ),
                        ),
                        onTap: () => GoRouter.of(context).go(
                          '$fieldListsPath${state.fieldsWithFieldListsCount[index].$1.id!}',
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }
      },
    ),
  );
}
