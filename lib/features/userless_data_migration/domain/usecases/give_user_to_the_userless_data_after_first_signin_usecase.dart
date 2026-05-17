import '../../../fields/data/repositories/fields_repository.dart';

class GiveUserToTheUserlessDataAfterFirstSignInUsecase {
  FieldsRepository _fieldsRepository;
  GiveUserToTheUserlessDataAfterFirstSignInUsecase(this._fieldsRepository);
  Future<void> call(String userAccountId) async =>
      _fieldsRepository.giveUserTheUserlessData(userAccountId);
}
