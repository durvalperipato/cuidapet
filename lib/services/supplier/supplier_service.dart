import '../../app/entities/address_entity.dart';
import '../../app/models/supplier_category_model.dart';
import '../../app/models/supplier_nearby_me_model.dart';

abstract class SupplierService {
  Future<List<SupplierCategoryModel>> getCategories();
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity address);
}
