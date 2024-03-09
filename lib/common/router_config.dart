import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nonso/nonso.dart';

const routePath = "/";

GoRouter getRouterConfig() {
  return GoRouter(routes: [GoRoute(path: routePath, builder: rootPathBuilder)]);
}

Widget rootPathBuilder(BuildContext buildContext, GoRouterState goRouterState) {
  return Scaffold(
      body: AuthScreen(Container(key: Key("hi"),)) , 
  );
}
