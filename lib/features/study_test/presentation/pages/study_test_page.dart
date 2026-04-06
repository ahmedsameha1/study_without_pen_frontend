import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/study_test_bloc.dart';
import '../bloc/study_test_event.dart';
import '../bloc/study_test_state.dart';
import 'study_test_page_view_content.dart';

class StudyTestPage extends StatelessWidget {
  StudyTestPage({required this.state, super.key});
  StudyTestState state;

  @override
  Widget build(BuildContext context) => BlocProvider<StudyTestBloc>(
    create: (context) => StudyTestBloc(state),
    child: const StudyTestPageView(),
  );
}

class StudyTestPageView extends StatefulWidget {
  const StudyTestPageView({super.key});

  @override
  State<StudyTestPageView> createState() => _StudyTestPageViewState();
}

class _StudyTestPageViewState extends State<StudyTestPageView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: BlocProvider.of<StudyTestBloc>(
        context,
      ).state.currentEntryIndex,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: BlocBuilder<StudyTestBloc, StudyTestState>(
        builder: (context, state) => PageView(
          controller: _pageController,
          onPageChanged: (value) =>
              BlocProvider.of<StudyTestBloc>(context).add(ChangeEntry(value)),
          children: state.entries
              .mapIndexed(
                (index, entry) => StudyTestPageViewContent(
                  entry: entry,
                  studyCount: state.counts[index].$1,
                  testCount: state.counts[index].$2,
                ),
              )
              .toList(),
        ),
      ),
    ),
  );
}
