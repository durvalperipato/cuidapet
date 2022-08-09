// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/entities/address_entity.dart';
import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapet_mobile/services/address/address_service.dart';

part 'address_detail_controller.g.dart';

class AddressDetailController = AddressDetailControllerBase with _$AddressDetailController;

abstract class AddressDetailControllerBase with Store {
  @readonly
  AddressEntity? _addressEntity;

  final AddressService _addressService;
  AddressDetailControllerBase({
    required AddressService addressService,
  }) : _addressService = addressService;

  Future<void> saveAddress(PlaceModel place, String additional) async {
    try {
      Loader.show();
      final addressEntity = await _addressService.saveAddress(place, additional);
      _addressEntity = addressEntity;
    } finally {
      Loader.hide();
    }
  }
}
