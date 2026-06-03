import '../../data/repositories/fields_repository.dart';

class DeleteFieldUsecase {
  DeleteFieldUsecase(this._fieldsRepository);
  final FieldsRepository _fieldsRepository;

  Future<int> call(String fieldId) => _fieldsRepository.remove(fieldId);
}
