import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../entries/domain/models/entry_entity.dart';
import '../bloc/study_test_bloc.dart';
import '../bloc/study_test_event.dart';
import 'study_tab_view.dart';
import 'test_tab_view.dart';

class StudyTestPageViewContent extends StatelessWidget {
  const StudyTestPageViewContent({
    required this.entry,
    required this.studyCount,
    required this.testCount,
    required this.tabIndex,
    super.key,
  });
  final EntryEntity entry;
  final int studyCount;
  final int testCount;
  final int tabIndex;

  @override
  Widget build(BuildContext context) => DefaultTabController(
    initialIndex: tabIndex,
    length: 2,
    child: Column(
      key: const Key('outerColumn'),
      children: [
        TabBar(
          onTap: (value) =>
              BlocProvider.of<StudyTestBloc>(context).add(ChangeTab(value)),
          tabs: [
            Text(AppLocalizations.of(context)!.study),
            Text(AppLocalizations.of(context)!.test),
          ],
        ),
        Expanded(
          child: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              StudyTabView(entry: entry, count: studyCount),
              TestTabView(entry: entry, count: testCount),
            ],
          ),
        ),
      ],
    ),
  );
}
