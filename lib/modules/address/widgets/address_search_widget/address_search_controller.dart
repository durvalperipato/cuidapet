// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/services/address/address_service.dart';
import 'package:mobx/mobx.dart';

part 'address_search_controller.g.dart';

class AddressSearchController = AddressSearchControllerBase with _$AddressSearchController;

abstract class AddressSearchControllerBase with Store {
  final AddressService _addressService;

  AddressSearchControllerBase({
    required AddressService addressService,
  }) : _addressService = addressService;

  Future<List<PlaceModel>> searchAddress(String addressPattern) =>
      _addressService.findAddressByGooglePlaces(addressPattern);
}
