import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nonso/nonso.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/create_field_page.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/fields_page.dart';

const rootPath = "/";
const createField = "create_field";
const createFieldPath = "$rootPath$createField";

GoRouter getRouterConfig() {
  return GoRouter(routes: [
    GoRoute(
        path: rootPath,
        builder: rootPathBuilder,
        routes: [GoRoute(path: createField, builder: createFieldPathBuilder)])
  ]);
}

Widget rootPathBuilder(BuildContext buildContext, GoRouterState goRouterState) {
  return AuthScreen(FieldsPage());
}

Widget createFieldPathBuilder(
    BuildContext buildContext, GoRouterState goRouterState) {
  return CreateFieldPage();
}
