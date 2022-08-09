// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
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

  @override
  Future<List<AddressEntity>> getAddress() => _addressRepository.getAddress();

  @override
  Future<AddressEntity> saveAddress(PlaceModel place, String additional) async {
    final addressEntity = AddressEntity(
      address: place.address,
      lat: place.lat,
      lng: place.lng,
      additional: additional,
    );

    final addressId = await _addressRepository.saveAddress(addressEntity);
    return addressEntity.copyWith(id: addressId);
  }

  @override
  Future<void> deleteAll() async => _addressRepository.deleteAll();
}
