// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../app/core/helpers/constants.dart';
import '../../app/core/local_storage/local_storage.dart';
import '../../app/entities/address_entity.dart';
import '../../app/models/place_model.dart';
import '../../repositories/address/address_repository.dart';
import 'address_service.dart';

class AddressServiceImpl implements AddressService {
  final LocalStorage _localStorage;
  final AddressRepository _addressRepository;

  AddressServiceImpl({
    required AddressRepository addressRepository,
    required LocalStorage localStorage,
  })  : _addressRepository = addressRepository,
        _localStorage = localStorage;

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

  @override
  Future<AddressEntity?> getAddressSelected() async {
    final addressJson =
        await _localStorage.read<String>(Constants.LOCAL_STORAGE_DEFAULT_ADDRESS_DATA_KEY);
    if (addressJson != null) {
      return AddressEntity.fromJson(addressJson);
    }
    return null;
  }

  @override
  Future<void> selectAddress(AddressEntity addressEntity) async {
    await _localStorage.write<String>(
      Constants.LOCAL_STORAGE_DEFAULT_ADDRESS_DATA_KEY,
      addressEntity.toJson(),
    );
  }
}
