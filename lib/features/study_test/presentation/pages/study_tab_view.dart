import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../bloc/study_test_bloc.dart';
import '../bloc/study_test_event.dart';
import '../bloc/study_test_state.dart';

class StudyTabView extends StatefulWidget {
  const StudyTabView({super.key});

  @override
  State<StudyTabView> createState() => _StudyTabViewState();
}

class _StudyTabViewState extends State<StudyTabView>
    with SingleTickerProviderStateMixin {
  static const OutlineInputBorder _outlineInputBorder = OutlineInputBorder();
  late final ScrollController _scrollController;
  late TextEditingController _userAnswerTextEditingController;
  late AnimationController _animationController;
  late Animation<double> _fadeTranstion;
  late Animation<Offset> _slideTranstion;

  @override
  void initState() {
    _userAnswerTextEditingController = TextEditingController();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );

    _fadeTranstion = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _slideTranstion =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -2.5)).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );
    super.initState();
  }

  @override
  void dispose() {
    _userAnswerTextEditingController.dispose();
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<StudyTestBloc, StudyTestState>(
    listener: (BuildContext context, state) {
      if (state.isUserAnswerCorrect) {
        _userAnswerTextEditingController.clear();
        _animationController.forward(from: 0);
      }
    },
    builder: (BuildContext context, state) => Center(
      child: Scrollbar(
        controller: _scrollController,
        interactive: true,
        thumbVisibility: true,
        thickness: 15,
        child: Padding(
          key: const Key('tabPadding'),
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 30,
            vertical: 15,
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(
                  key: const Key('questionSizedBox'),
                  height: 200,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _outlineInputBorder.borderSide.color,
                        width: _outlineInputBorder.borderSide.width,
                      ),
                      borderRadius: _outlineInputBorder.borderRadius,
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 180),
                        child: Center(
                          child: Text(
                            state.entries[state.currentEntryIndex].question,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(key: Key('questionAnswerSizedBox'), height: 20),
                SizedBox(
                  key: const Key('answerSizedBox'),
                  height: 200,
                  width: double.infinity,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _outlineInputBorder.borderSide.color,
                        width: _outlineInputBorder.borderSide.width,
                      ),
                      borderRadius: _outlineInputBorder.borderRadius,
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 180),
                        child: Center(
                          child: Text(
                            state.entries[state.currentEntryIndex].answer,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  key: Key('answerUserAnswerSizedBox'),
                  height: 20,
                ),
                SizedBox(
                  key: const Key('userAnswerSizedBox'),
                  height: 200,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      TextFormField(
                        key: const Key(
                          'study_tab_view_user_answer_text_form_field',
                        ),
                        controller: _userAnswerTextEditingController,
                        style: Theme.of(context).textTheme.bodyLarge,
                        expands: true,
                        maxLines: null,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.multiline,
                        autofocus: true,
                        autocorrect: false,
                        enableSuggestions: false,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(
                            context,
                          )!.enterYourAnswer,
                          contentPadding: const EdgeInsets.only(
                            top: 20,
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          filled: true,
                          border: const OutlineInputBorder(gapPadding: 0),
                        ),
                        onChanged: (value) => BlocProvider.of<StudyTestBloc>(
                          context,
                        ).add(CheckUserAnswer(value)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3, left: 6),
                        child: Text(
                          '${state.counts[state.currentEntryIndex].$1}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      if (_animationController.isAnimating)
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) => SlideTransition(
                            position: _slideTranstion,
                            child: FadeTransition(
                              opacity: _fadeTranstion,
                              child: child,
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.star, color: Colors.yellow, size: 72),
                              Icon(Icons.star, color: Colors.yellow, size: 72),
                              Icon(Icons.star, color: Colors.yellow, size: 72),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
