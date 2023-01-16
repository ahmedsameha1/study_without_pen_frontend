import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'main_screen.dart';

class MainWidget extends StatelessWidget {
  const MainWidget({Key? key}) : super(key: key);
  static const String title = "PenInBin";

  static Widget rootPathBuilder(BuildContext context, GoRouterState state) {
    return const MainScreen();
  }

  GoRouter _createGoRouter() {
    return GoRouter(routes: <GoRoute>[
      GoRoute(path: "/", builder: rootPathBuilder),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _createGoRouter(),
      title: title,
    );
  }
}
