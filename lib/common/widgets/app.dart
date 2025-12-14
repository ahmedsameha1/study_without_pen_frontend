import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/theme.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations_en.dart';

import '../router_config.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<nonso.AuthBloc>.value(
      value: context.read<nonso.AuthBloc>(),
      child: AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        AppLocalizations.delegate,
        nonso.AppLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      title: AppLocalizationsEn().materialAppTitle,
      routerConfig: getRouterConfig(),
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
