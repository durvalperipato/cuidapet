// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_mobile/app/core/ui/extensions/size_screen_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/cuidapet_default_button.dart';
import 'package:cuidapet_mobile/modules/address/widgets/address_detail/address_detail_controller.dart';
import 'package:flutter/material.dart';

import 'package:cuidapet_mobile/app/models/place_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';

class AddressDetailPage extends StatefulWidget {
  final PlaceModel place;

  const AddressDetailPage({
    super.key,
    required this.place,
  });

  @override
  State<AddressDetailPage> createState() => _AddressDetailPageState();
}

class _AddressDetailPageState extends State<AddressDetailPage> {
  final _additionalEC = TextEditingController();
  final controller = Modular.get<AddressDetailController>();
  late final ReactionDisposer addressEntityDisposer;

  @override
  void initState() {
    super.initState();

    addressEntityDisposer = reaction((_) => controller.addressEntity, (addressEntity) {
      if (addressEntity != null) {
        Modular.to.pop(addressEntity);
      }
    });
  }

  @override
  void dispose() {
    _additionalEC.dispose();
    addressEntityDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: context.primaryColor),
        elevation: 0,
      ),
      body: Column(
        children: [
          Text(
            'Confirme seu endereço',
            style: context.textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(widget.place.lat, widget.place.lng),
                zoom: 16,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('Address ID'),
                  position: LatLng(widget.place.lat, widget.place.lng),
                  infoWindow: InfoWindow(title: widget.place.address),
                ),
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              readOnly: true,
              initialValue: widget.place.address,
              decoration: const InputDecoration(
                labelText: 'Endereço',
                suffixIcon: Icon(Icons.edit),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _additionalEC,
              decoration: const InputDecoration(
                labelText: 'Complemento',
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: .9.sw,
            height: 60.h,
            child: CuidapetDefaultButton(
              label: 'Salvar',
              onPressed: () => controller.saveAddress(widget.place, _additionalEC.text),
            ),
          ),
        ],
      ),
    );
  }
}