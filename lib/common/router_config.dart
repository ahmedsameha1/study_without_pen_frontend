import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nonso/nonso.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/pages/create_entry_page.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/pages/entries_page.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/create_field_list_page.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/field_lists_page.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/create_field_page.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/fields_page.dart';

const rootPath = "/";
const createField = "create_field";
const createFieldPath = "$rootPath$createField";
const fieldLists = "field_lists/:$fieldIdParameter";
const entries = "entries/:$fieldListIdParameter";
const fieldIdParameter = "fieldId";
const fieldListIdParameter = "fieldListId";
const fieldListNameParameter = 'fieldListName';
const fieldListsPath = "/field_lists/";
const entriesPath = "/entries/";
const createFieldList = '/create_field_list';
const createEntry = '/create_entry';

GoRouter getRouterConfig() {
  return GoRouter(
    routes: [
      GoRoute(
        path: rootPath,
        builder: rootPathBuilder,
        routes: [
          GoRoute(path: createField, builder: createFieldPathBuilder),
          GoRoute(
            path: fieldLists,
            builder: fieldListsPathBuilder,
            routes: [
              GoRoute(
                path: createFieldList,
                builder: createFieldListPathBuilder,
              ),
              GoRoute(
                path: entries,
                builder: entriesPathBuilder,
                routes: [
                  GoRoute(path: createEntry, builder: createEntryPathBuilder),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget rootPathBuilder(BuildContext buildContext, GoRouterState goRouterState) {
  return AuthScreen(FieldsPage());
}

Widget createFieldPathBuilder(
  BuildContext buildContext,
  GoRouterState goRouterState,
) {
  return CreateFieldPage();
}

Widget fieldListsPathBuilder(
  BuildContext buildContext,
  GoRouterState goRouterState,
) {
  return FieldListsPage(goRouterState.pathParameters[fieldIdParameter]!);
}

Widget entriesPathBuilder(
  BuildContext buildContext,
  GoRouterState goRouterState,
) {
  return EntriesPage(
    fieldId: goRouterState.pathParameters[fieldIdParameter]!,
    fieldListId: goRouterState.pathParameters[fieldListIdParameter]!,
  );
}

Widget createFieldListPathBuilder(
  BuildContext buildContext,
  GoRouterState goRouterState,
) {
  return CreateFieldListPage(
    fieldId: goRouterState.pathParameters[fieldIdParameter]!,
  );
}

Widget createEntryPathBuilder(
  BuildContext buildContext,
  GoRouterState goRouterState,
) {
  return CreateEntryPage(
    fieldListId: goRouterState.pathParameters[fieldListIdParameter]!,
  );
}
