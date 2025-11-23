import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nonso/nonso.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/create_field_list_page.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/field_lists_page.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/create_field_page.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/fields_page.dart';

const rootPath = "/";
const createField = "create_field";
const createFieldPath = "$rootPath$createField";
const fieldLists = "field_lists/:$fieldIdParameter";
const fieldIdParameter = "fieldId";
const fieldListsPath = "/field_lists/";
const createFieldList = '/create_field_list';

GoRouter getRouterConfig() {
  return GoRouter(routes: [
    GoRoute(path: rootPath, builder: rootPathBuilder, routes: [
      GoRoute(path: createField, builder: createFieldPathBuilder),
      GoRoute(path: fieldLists, builder: fieldListsPathBuilder, routes: [
        GoRoute(path: createFieldList, builder: createFieldListPathBuilder)
      ])
    ])
  ]);
}

Widget rootPathBuilder(BuildContext buildContext, GoRouterState goRouterState) {
  return AuthScreen(FieldsPage());
}

Widget createFieldPathBuilder(
    BuildContext buildContext, GoRouterState goRouterState) {
  return CreateFieldPage();
}

Widget fieldListsPathBuilder(
    BuildContext buildContext, GoRouterState goRouterState) {
  return FieldListsPage(goRouterState.pathParameters[fieldIdParameter]!);
}

Widget createFieldListPathBuilder(
    BuildContext buildContext, GoRouterState goRouterState) {
  return CreateFieldListPage(
      fieldId: goRouterState.pathParameters[fieldIdParameter]!);
}
