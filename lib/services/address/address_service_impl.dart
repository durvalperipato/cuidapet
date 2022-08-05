// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:cuidapet_mobile/repositories/address/address_repository.dart';
import 'package:cuidapet_mobile/services/address/address_service.dart';

class AddressServiceImpl implements AddressService {
  final AddressRepository _addressRepository;

  AddressServiceImpl({
    required AddressRepository addressRepository,
  }) : _addressRepository = addressRepository;

  @override
  Future<List<PlaceModel>> findAddressByGooglePlaces(String addressPattern) async =>
      _addressRepository.findAddressByGooglePlaces(addressPattern);
}
