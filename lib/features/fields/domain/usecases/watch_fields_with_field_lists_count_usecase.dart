import '../../data/repositories/fields_repository.dart';
import '../models/field_entity.dart';

class WatchFieldsWithFieldListsCountUsecase {
  WatchFieldsWithFieldListsCountUsecase(this._repository);
  final FieldsRepository _repository;
  Stream<List<(FieldEntity, int)>> call(String userAccountId) =>
      _repository.watchWithFieldListsCountByUserAccountId(userAccountId);
}
