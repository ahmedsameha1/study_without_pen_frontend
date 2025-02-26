import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

import '../router_config.dart';

class App extends StatelessWidget {
  final FirebaseAuth firebaseAuthInstance;
  App(this.firebaseAuthInstance);
  @override
  Widget build(BuildContext context) {
    const seedColor =  Color(0xFFEC407A);
    final colorScheme =
        ColorScheme.fromSeed(seedColor: seedColor);
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<nonso.AuthBloc>(
              create: (context) => nonso.AuthBloc(firebaseAuthInstance))
        ],
        child: MaterialApp.router(
          localizationsDelegates: [AppLocalizations.delegate, nonso.AppLocalizations.delegate],
          supportedLocales: AppLocalizations.supportedLocales,
          //   title: AppLocalizations.of(context)!.materialAppTitle,
          /*
          localeListResolutionCallback: (locales, supportedLocales) {
            return Locale("en");
          },
          */
          routerConfig: getRouterConfig(),
          theme: ThemeData().copyWith(
            colorScheme: colorScheme,
            scaffoldBackgroundColor: colorScheme.surfaceContainerHighest,
            appBarTheme: AppBarTheme().copyWith(backgroundColor: seedColor),
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
