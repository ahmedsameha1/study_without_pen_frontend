import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nonso/nonso.dart';
import '../features/entries/presentation/pages/create_entry_page.dart';
import '../features/entries/presentation/pages/entries_page.dart';
import '../features/field_lists/presentation/pages/create_field_list_page.dart';
import '../features/field_lists/presentation/pages/field_lists_page.dart';
import '../features/fields/presentation/pages/create_field_page.dart';
import '../features/fields/presentation/pages/fields_page.dart';

import '../features/study_test/presentation/bloc/study_test_state.dart';
import '../features/study_test/presentation/pages/study_test_page.dart';

const rootPath = '/';
const createField = 'create_field';
const createFieldPath = '$rootPath$createField';
const fieldLists = 'field_lists/:$fieldIdParameter';
const entries = 'entries/:$fieldListIdParameter';
const fieldIdParameter = 'fieldId';
const fieldListIdParameter = 'fieldListId';
const fieldListNameParameter = 'fieldListName';
const fieldListsPath = '/field_lists/';
const entriesPath = '/entries/';
const createFieldList = '/create_field_list';
const createEntry = '/create_entry';
const studyTest = '/study_test';

GoRouter getRouterConfig() => GoRouter(
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
            GoRoute(path: createFieldList, builder: createFieldListPathBuilder),
            GoRoute(
              path: entries,
              builder: entriesPathBuilder,
              routes: [
                GoRoute(path: createEntry, builder: createEntryPathBuilder),
                GoRoute(path: studyTest, builder: studyTestPathBuilder),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

Widget rootPathBuilder(
  BuildContext buildContext,
  GoRouterState goRouterState,
) => AuthScreen(FieldsPage());

Widget createFieldPathBuilder(
  BuildContext buildContext,
  GoRouterState goRouterState,
) => CreateFieldPage();

Widget fieldListsPathBuilder(
  BuildContext buildContext,
  GoRouterState goRouterState,
) => FieldListsPage(goRouterState.pathParameters[fieldIdParameter]!);

Widget entriesPathBuilder(
  BuildContext buildContext,
  GoRouterState goRouterState,
) => EntriesPage(
  fieldId: goRouterState.pathParameters[fieldIdParameter]!,
  fieldListId: goRouterState.pathParameters[fieldListIdParameter]!,
);

Widget createFieldListPathBuilder(
  BuildContext buildContext,
  GoRouterState goRouterState,
) => CreateFieldListPage(
  fieldId: goRouterState.pathParameters[fieldIdParameter]!,
);

Widget createEntryPathBuilder(
  BuildContext buildContext,
  GoRouterState goRouterState,
) => CreateEntryPage(
  fieldListId: goRouterState.pathParameters[fieldListIdParameter]!,
);

Widget studyTestPathBuilder(
  BuildContext buildContext,
  GoRouterState goRouterState,
) => StudyTestPage(state: goRouterState.extra as StudyTestState);
