import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/theme.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations_en.dart';

import '../router_config.dart';

class App extends StatelessWidget {
  final FirebaseAuth firebaseAuthInstance;
  App(this.firebaseAuthInstance);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<nonso.AuthBloc>(
              create: (context) => nonso.AuthBloc(firebaseAuthInstance))
        ],
        child: MaterialApp.router(
          localizationsDelegates: [
            AppLocalizations.delegate,
            nonso.AppLocalizations.delegate
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          title: AppLocalizationsEn().materialAppTitle,
          routerConfig: getRouterConfig(),
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
