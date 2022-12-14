// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobx/mobx.dart';

import '../../app/core/life_cycle/controller_life_cycle.dart';
import '../../app/core/ui/widgets/loader.dart';
import '../../app/core/ui/widgets/messages.dart';
import '../../app/entities/address_entity.dart';
import '../../app/models/place_model.dart';
import '../../services/address/address_service.dart';

part 'address_controller.g.dart';

class AddressController = AddressControllerBase with _$AddressController;

abstract class AddressControllerBase with Store, ControllerLifeCycle {
  final AddressService _addressService;

  @readonly
  var _locationServiceUnavailable = false;

  @readonly
  var _addresses = <AddressEntity>[];

  @readonly
  LocationPermission? _locationPermission;

  @readonly
  PlaceModel? _placeModel;

  AddressControllerBase({
    required AddressService addressService,
  }) : _addressService = addressService;

  @override
  void onReady() {
    getAddresses();
  }

  @action
  Future<void> getAddresses() async {
    try {
      Loader.show();
      _addresses = await _addressService.getAddress();
    } finally {
      Loader.hide();
    }
  }

  @action
  Future<void> myLocation() async {
    _locationPermission = null;
    _locationServiceUnavailable = false;
    final serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      _locationServiceUnavailable = true;
      return;
    }

    final locationPermission = await Geolocator.checkPermission();
    switch (locationPermission) {
      case LocationPermission.denied:
        final permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever) {
          _locationPermission = permission;
          return;
        }
        break;
      case LocationPermission.deniedForever:
      case LocationPermission.unableToDetermine:
        _locationPermission = locationPermission;
        return;
      case LocationPermission.whileInUse:
      case LocationPermission.always:
        break;
    }
    Loader.show();
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final placemark = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final place = placemark.first;
    final address = '${place.thoroughfare} ${place.subThoroughfare}';
    final placeModel = PlaceModel(
      address: address,
      lat: position.latitude,
      lng: position.longitude,
    );
    Loader.hide();
    goToAddressDetail(placeModel);
  }

  Future<void> goToAddressDetail(PlaceModel place) async {
    final address = await Modular.to.pushNamed('/address/detail', arguments: place);
    // Editando um endere??o enviado
    if (address is PlaceModel) {
      _placeModel = address;
    }
    // Salvou um endere??o
    else if (address is AddressEntity) {
      selectAddress(address);
    }
  }

  Future<void> selectAddress(AddressEntity addressEntity) async {
    await _addressService.selectAddress(addressEntity);

    Modular.to.pop(addressEntity);
  }

  Future<bool> addressWasSelected() async {
    final address = await _addressService.getAddressSelected();
    if (address != null) {
      return true;
    } else {
      Messages.alert('Por favor selecione ou cadastre um endere??o');
      return false;
    }
  }
}
