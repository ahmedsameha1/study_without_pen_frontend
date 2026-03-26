import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/study_test_bloc.dart';
import '../bloc/study_test_state.dart';

class StudyTestPage extends StatelessWidget {
  StudyTestPage({required this.state, super.key});
  StudyTestState state;

  @override
  Widget build(BuildContext context) => BlocProvider<StudyTestBloc>(
    create: (context) => StudyTestBloc(state),
    child: const StudyTestPageView(),
  );
}

class StudyTestPageView extends StatelessWidget {
  const StudyTestPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
