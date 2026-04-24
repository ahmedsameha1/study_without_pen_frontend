import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../bloc/study_test_bloc.dart';
import '../bloc/study_test_event.dart';
import '../bloc/study_test_state.dart';
import 'study_tab_view.dart';
import 'test_tab_view.dart';

class StudyTestPageViewContent extends StatelessWidget {
  const StudyTestPageViewContent({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<StudyTestBloc, StudyTestState>(
        builder: (context, state) => DefaultTabController(
          key: ValueKey(state.currentEntryIndex),
          initialIndex: state.counts[state.currentEntryIndex].$3,
          length: 2,
          child: Column(
            key: const Key('outerColumn'),
            children: [
              TabBar(
                onTap: (value) => BlocProvider.of<StudyTestBloc>(
                  context,
                ).add(ChangeTab(value)),
                tabs: [
                  Text(AppLocalizations.of(context)!.study),
                  Text(AppLocalizations.of(context)!.test),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [StudyTabView(), TestTabView()],
                ),
              ),
            ],
          ),
        ),
      );
}
