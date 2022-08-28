// ignore_for_file: public_member_api_docs, sort_constructors_first
import './supplier_repository.dart';
import '../../app/core/exceptions/failure.dart';
import '../../app/core/logger/app_logger.dart';
import '../../app/core/rest_client/rest_client.dart';
import '../../app/core/rest_client/rest_client_exception.dart';
import '../../app/entities/address_entity.dart';
import '../../app/models/supplier_category_model.dart';
import '../../app/models/supplier_nearby_me_model.dart';

class SupplierRepositoryImpl implements SupplierRepository {
  final RestClient _restClient;
  final AppLogger _log;
  SupplierRepositoryImpl({
    required RestClient restClient,
    required AppLogger log,
  })  : _restClient = restClient,
        _log = log;

  @override
  Future<List<SupplierCategoryModel>> getCategories() async {
    try {
      final result = await _restClient.auth().get('/categories/');
      return result.data
          ?.map<SupplierCategoryModel>(
            (categoryResponse) => SupplierCategoryModel.fromMap(categoryResponse),
          )
          .toList();
    } on RestClientException catch (e, s) {
      const message = 'Erro ao buscar as categorias dos fornecedores';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }

  @override
  Future<List<SupplierNearbyMeModel>> findNearBy(AddressEntity address) async {
    try {
      final result = await _restClient.auth().get(
        '/suppliers/',
        queryParameters: {
          'lat': address.lat,
          'lng': address.lng,
        },
      );
      return result.data
          ?.map<SupplierNearbyMeModel>(
              (supplierResponse) => SupplierNearbyMeModel.fromMap(supplierResponse))
          .toList();
    } on RestClientException catch (e, s) {
      const message = 'Erro ao buscar fornecedores perto de mim';
      _log.error(message, e, s);
      throw Failure(message: message);
    }
  }
}
