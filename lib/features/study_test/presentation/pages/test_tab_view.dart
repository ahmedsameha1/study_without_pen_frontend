import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../entries/domain/models/entry_entity.dart';

class TestTabView extends StatefulWidget {
  const TestTabView({required this.entry, required this.count, super.key});
  final EntryEntity entry;
  final int count;

  @override
  State<TestTabView> createState() => _TestTabViewState();
}

class _TestTabViewState extends State<TestTabView> {
  static const OutlineInputBorder _outlineInputBorder = OutlineInputBorder();
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
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
                          widget.entry.question,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(key: Key('questionUserAnswerSizedBox'), height: 20),
              SizedBox(
                key: const Key('userAnswerSizedBox'),
                height: 200,
                child: TextFormField(
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
                    hintText: AppLocalizations.of(context)!.enterYourAnswer,
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
              ),
              const SizedBox(
                key: Key('userAnswerCheckButtonSizedBox'),
                height: 20,
              ),
              FilledButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(AppLocalizations.of(context)!.check)],
                      ),
                    ),
                    Text('${widget.count}'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
