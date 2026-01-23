import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

final scaffoldFinder = find.byType(Scaffold);
final centerFinder = find.byType(Center);
final paddingFinder = find.byType(Padding);
final cardFinder = find.byType(Card);
final singleChildScrollViewFinder = find.byType(SingleChildScrollView);
final columnFinder = find.byType(Column);
final formFinder = find.byType(Form);
final textFormFieldFinder = find.byType(TextFormField);
final blocProviderFinder = find.byType(BlocProvider);
final snackBarFinder = find.byType(SnackBar);
final circularProgressIndicatorFinder = find.byType(CircularProgressIndicator);
final appBarFinder = find.byType(AppBar);
final floatingActionButtonFinder = find.byType(FloatingActionButton);
