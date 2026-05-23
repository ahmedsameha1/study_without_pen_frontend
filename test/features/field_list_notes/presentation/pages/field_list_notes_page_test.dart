import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nonso/l10n/app_localizations.dart';
import 'package:nonso/l10n/app_localizations.dart' as nonso;
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/models/field_list_note_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/models/field_list_notes_page_data.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/domain/usecases/watch_field_list_notes_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/presentation/pages/field_list_notes_page.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:uuid/uuid.dart';

class MockWatchFieldListNotesusecase extends Mock
    implements WatchFieldListNotesUsecase {}

class MockGoRouter extends Mock implements GoRouter {}

Future<void> _createFieldListNotesPageInASkeleton(
  WidgetTester tester,
  Locale locale,
  GoRouter goRouter,
  WatchFieldListNotesUsecase watchFieldListNotesUsecase,
  String fieldListId,
) async {
  await tester.pumpWidget(
    RepositoryProvider.value(
      value: watchFieldListNotesUsecase,
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          nonso.AppLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: InheritedGoRouter(
          goRouter: goRouter,
          child: FieldListNotesPage(fieldListId: fieldListId),
        ),
      ),
    ),
  );
}

void main() {
  final creationAt1 = DateTime(2023);
  final creationAt2 = DateTime(2024);
  final creationAt3 = DateTime(2025);
  final fieldListEntity = FieldListEntity(
    id: const Uuid().v4(),
    fieldId: const Uuid().v4(),
    name: 'field list name1',
    creationAt: creationAt1,
    lastModificationAt: creationAt1,
  );
  List<FieldListNoteEntity> fieldListNoteEntities = [
    FieldListNoteEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      text: 'note1',
      creationAt: creationAt1,
      lastModificationAt: creationAt1,
    ),
    FieldListNoteEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      text: 'note2',
      creationAt: creationAt2,
      lastModificationAt: creationAt2,
    ),
    FieldListNoteEntity(
      id: const Uuid().v4(),
      fieldListId: fieldListEntity.id!,
      text: 'note3',
      creationAt: creationAt3,
      lastModificationAt: creationAt3,
    ),
  ];
  late WatchFieldListNotesUsecase watchFieldListNotesUsecase;
  final fieldListNotesPageData = FieldListNotesPageData(
    fieldList: fieldListEntity,
    fieldListNotes: fieldListNoteEntities,
  );
  late GoRouter goRouter = MockGoRouter();
  group('English', () {
    Locale locale = const Locale('en');

    group('FieldListNotesPage', () {
      setUp(() {
        watchFieldListNotesUsecase = MockWatchFieldListNotesusecase();
        when(
          () => watchFieldListNotesUsecase.call(fieldListEntity.id!),
        ).thenAnswer((_) => Stream.value(fieldListNotesPageData));
      });

      testWidgets('Test the presence of FieldListsPageView widget', (
        WidgetTester tester,
      ) async {
        await _createFieldListNotesPageInASkeleton(
          tester,
          locale,
          goRouter,
          watchFieldListNotesUsecase,
          fieldListEntity.id!,
        );
        expect(
          find.descendant(
            of: find.byType(FieldListNotesPage),
            matching: find.byType(FieldListNotesPageView),
          ),
          findsOne,
        );
      });

      testWidgets(
        'Test calling WatchFieldListNotesUsecase.call() on initialization',
        (WidgetTester tester) async {
          await _createFieldListNotesPageInASkeleton(
            tester,
            locale,
            goRouter,
            watchFieldListNotesUsecase,
            fieldListEntity.id!,
          );
          verify(
            () => watchFieldListNotesUsecase.call(fieldListEntity.id!),
          ).called(1);
        },
      );
    });
  });
}
