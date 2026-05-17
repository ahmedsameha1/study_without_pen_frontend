import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/userless_data_migration/domain/usecases/give_user_to_the_userless_data_after_first_signin_usecase.dart';
import 'package:uuid/uuid.dart';

class MockFieldsRepository extends Mock implements FieldsRepository {}

void main() {
  final fieldsRepository = MockFieldsRepository();
  final
  giveUserToTheUserlessDataAfterFirstSignInUsecase =
      GiveUserToTheUserlessDataAfterFirstSignInUsecase(fieldsRepository);

  test('call() calls FieldsRepository.giveUserTheUserlessData()', () {
    final userAccountId = const Uuid().v4();
    when(
      () => fieldsRepository.giveUserTheUserlessData(userAccountId),
    ).thenAnswer((_) => Future.value());
    giveUserToTheUserlessDataAfterFirstSignInUsecase.call(userAccountId);
    verify(
      () => fieldsRepository.giveUserTheUserlessData(userAccountId),
    ).called(1);
  });
}
