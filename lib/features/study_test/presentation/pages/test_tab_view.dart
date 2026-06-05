import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

import '../../../../l10n/app_localizations.dart';
import '../bloc/study_test_bloc.dart';
import '../bloc/study_test_event.dart';
import '../bloc/study_test_state.dart';

class TestTabView extends StatefulWidget {
  const TestTabView({super.key});

  @override
  State<TestTabView> createState() => _TestTabViewState();
}

class _TestTabViewState extends State<TestTabView>
    with TickerProviderStateMixin {
  static const OutlineInputBorder _outlineInputBorder = OutlineInputBorder();
  late final ScrollController _scrollController;
  late TextEditingController _userAnswerTextEditingController;
  late AnimationController _correctController;
  late AnimationController _incorrectController;
  late Animation<double> _fadeTranstion;
  late Animation<Offset> _slideTranstion;
  late Animation<double> _shake;
  late FocusNode _focusNode;

  @override
  void initState() {
    _userAnswerTextEditingController = TextEditingController();
    _scrollController = ScrollController();
    _correctController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _incorrectController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fadeTranstion = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(parent: _correctController, curve: Curves.easeIn),
    );
    _slideTranstion =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0, -2.5)).animate(
          CurvedAnimation(parent: _correctController, curve: Curves.easeOut),
        );
    _shake =
        TweenSequence([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: -8.0), weight: 10),
          TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 20),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: -8.0), weight: 20),
          TweenSequenceItem(tween: Tween(begin: -8.0, end: 8.0), weight: 20),
          TweenSequenceItem(tween: Tween(begin: 8.0, end: 0.0), weight: 10),
          TweenSequenceItem(
            tween: Tween(begin: 0.0, end: 0.0),
            weight: 20,
          ), // tail, no shake
        ]).animate(
          CurvedAnimation(parent: _incorrectController, curve: Curves.linear),
        );
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _userAnswerTextEditingController.dispose();
    _scrollController.dispose();
    _correctController.dispose();
    _incorrectController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<StudyTestBloc, StudyTestState>(
    listenWhen: (previous, current) =>
        current.isUserAnswerCorrect != null ||
        current.counts[current.currentEntryIndex].$3 !=
            previous.counts[previous.currentEntryIndex].$3,
    listener: (BuildContext context, state) {
      if (state.isUserAnswerCorrect != null && state.isUserAnswerCorrect!) {
        _userAnswerTextEditingController.clear();
        _correctController.forward(from: 0);
      } else {
        _incorrectController.forward(from: 0);
      }
      if (state.counts[state.currentEntryIndex].$3 == 1) {
        _focusNode.requestFocus();
      } else if (state.counts[state.currentEntryIndex].$3 == 0) {
        _focusNode.unfocus();
      }
    },
    builder: (context, state) => Center(
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
                          child: GptMarkdown(
                            state.entries[state.currentEntryIndex].question,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  key: Key('questionUserAnswerSizedBox'),
                  height: 20,
                ),
                SizedBox(
                  key: const Key('userAnswerSizedBox'),
                  height: 200,
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      _correctController,
                      _incorrectController,
                    ]),
                    builder: (context, child) => Transform.translate(
                      offset: Offset(_shake.value, 0),
                      child: Stack(
                        children: [
                          TextFormField(
                            key: const Key(
                              'test_tab_view_user_answer_text_form_field',
                            ),
                            controller: _userAnswerTextEditingController,
                            focusNode: _focusNode,
                            style: Theme.of(context).textTheme.bodyLarge,
                            expands: true,
                            maxLines: null,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.multiline,
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
                          ),
                          if (_correctController.isAnimating)
                            SlideTransition(
                              position: _slideTranstion,
                              child: FadeTransition(
                                opacity: _fadeTranstion,
                                child: child,
                              ),
                            ),
                        ],
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
                ),
                const SizedBox(
                  key: Key('userAnswerCheckButtonSizedBox'),
                  height: 20,
                ),
                FilledButton(
                  onPressed: () => BlocProvider.of<StudyTestBloc>(
                    context,
                  ).add(CheckUserAnswer(_userAnswerTextEditingController.text)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(AppLocalizations.of(context)!.check)],
                        ),
                      ),
                      Text('${state.counts[state.currentEntryIndex].$2}'),
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
