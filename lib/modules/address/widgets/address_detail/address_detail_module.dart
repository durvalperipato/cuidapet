import 'package:cuidapet_mobile/modules/address/widgets/address_detail/address_detail_controller.dart';
import 'package:cuidapet_mobile/modules/address/widgets/address_detail/address_detail_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AddressDetailModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => AddressDetailController(addressService: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => AddressDetailPage(place: args.data),
        ),
      ];
}
