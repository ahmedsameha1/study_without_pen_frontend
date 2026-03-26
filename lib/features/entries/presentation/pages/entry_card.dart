import 'package:flutter/material.dart';

import '../../../../database/entrys_dao.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/entry_entity.dart';

/// This widget represents an entry in the entries page
class EntryCard extends StatelessWidget {
  const EntryCard({required this.entry, required this.onTap, super.key});
  final EntryEntity entry;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    var sideColor = Colors.red.shade700;
    if (entry.wrongness <= 0.1) {
      sideColor = Colors.green;
    } else if (entry.wrongness > 0.1 && entry.wrongness <= 0.4) {
      sideColor = Colors.yellow;
    }

    return Material(
      child: Dismissible(
        key: const Key('hi'),
        child: InkWell(
          onTap: onTap,
          child: Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: ClipPath(
              clipper: ShapeBorderClipper(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: sideColor, width: 4)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Chip(
                              label: Text(
                                '${AppLocalizations.of(context)!.score}: ${entry.score}',
                              ),
                              labelStyle: Theme.of(
                                context,
                              ).textTheme.labelSmall,
                              padding: EdgeInsets.zero,
                            ),
                            Chip(
                              label: Text(
                                '${AppLocalizations.of(context)!.wrongness}: ${entry.wrongness}',
                              ),
                              labelStyle: Theme.of(
                                context,
                              ).textTheme.labelSmall,
                              padding: EdgeInsets.zero,
                            ),
                            Chip(
                              label: Text(switch (entry.rank) {
                                Rank.low => AppLocalizations.of(context)!.low,
                                Rank.normal => AppLocalizations.of(
                                  context,
                                )!.normal,
                                Rank.important => AppLocalizations.of(
                                  context,
                                )!.important,
                                Rank.vital => AppLocalizations.of(
                                  context,
                                )!.vital,
                              }),
                              labelStyle: Theme.of(
                                context,
                              ).textTheme.labelSmall,
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                        PopupMenuButton<String>(
                          itemBuilder: (_) => [
                            const PopupMenuItem<String>(
                              value: '',
                              child: Text('hi'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      key: Key('scoreRankQuestionSizedBox'),
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Center(
                            child: SelectableText(
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge!
                                  .copyWith(fontWeight: FontWeight.w600),
                              entry.question,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      key: Key('questionAnswerSizedBox'),
                      height: 10,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Center(
                            child: SelectableText(
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                              entry.answer,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
