import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonso/nonso.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../router_config.dart';

class App extends StatelessWidget {
  final FirebaseAuth firebaseAuthInstance;
  App(this.firebaseAuthInstance);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(firebaseAuthInstance))
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
     //   title: AppLocalizations.of(context)!.materialAppTitle,
        /*
        localeListResolutionCallback: (locales, supportedLocales) {
          return Locale("en");
        },
        */
        routerConfig: getRouterConfig(),
      ),
    );
  }
}
