import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nonso/nonso.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/field_page.dart';

const routePath = "/";

GoRouter getRouterConfig() {
  return GoRouter(routes: [GoRoute(path: routePath, builder: rootPathBuilder)]);
}

Widget rootPathBuilder(BuildContext buildContext, GoRouterState goRouterState) {
  return AuthScreen(FieldPage());
}
