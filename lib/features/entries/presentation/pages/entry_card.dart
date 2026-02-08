import 'package:flutter/material.dart';

import '../../../../database/entrys_dao.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/models/entry_entity.dart';

/// This widget represents an entry in the entries page
class EntryCard extends StatelessWidget {
  const EntryCard({required this.entry, super.key});
  final EntryEntity entry;

  @override
  Widget build(BuildContext context) => Material(
    child: Dismissible(
      key: const Key('hi'),
      child: InkWell(
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
                border: Border(
                  left: BorderSide(color: Colors.red.shade700, width: 7),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Chip(
                            label: Text(AppLocalizations.of(context)!.score),
                            labelStyle: Theme.of(context).textTheme.labelSmall,
                          ),
                          Chip(
                            label: Text(
                              AppLocalizations.of(context)!.wrongness,
                            ),
                            labelStyle: Theme.of(context).textTheme.labelSmall,
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
                              Rank.vital => AppLocalizations.of(context)!.vital,
                            }),
                            labelStyle: Theme.of(context).textTheme.labelSmall,
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
                  const SizedBox(key: Key('answerButtonsSizedBox'), height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.onSecondary,
                        ),
                        onPressed: () {},
                        child: Text(
                          style: Theme.of(context).textTheme.titleSmall,
                          AppLocalizations.of(context)!.study,
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.onSecondary,
                        ),
                        onPressed: () {},
                        child: Text(
                          style: Theme.of(context).textTheme.titleSmall,
                          AppLocalizations.of(context)!.test,
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
