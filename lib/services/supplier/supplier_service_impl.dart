import '../../app/entities/address_entity.dart';
import '../../app/models/supplier_category_model.dart';
import '../../app/models/supplier_nearby_me_model.dart';
import '../../repositories/supplier/supplier_repository.dart';
import 'supplier_service.dart';

class SupplierServiceImpl implements SupplierService {
  final SupplierRepository _repository;

  SupplierServiceImpl({required SupplierRepository supplierRepository})
      : _repository = supplierRepository;

  @override
  Future<List<SupplierCategoryModel>> getCategories() => _repository.getCategories();

  @override
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity address) {
    return _repository.findNearBy(address);
  }
}
