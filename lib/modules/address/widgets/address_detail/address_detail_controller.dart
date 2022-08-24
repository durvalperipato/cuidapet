// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:mobx/mobx.dart';

import '../../../../app/core/ui/widgets/loader.dart';
import '../../../../app/entities/address_entity.dart';
import '../../../../app/models/place_model.dart';
import '../../../../services/address/address_service.dart';

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
