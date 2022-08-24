import 'package:flutter_modular/flutter_modular.dart';

import 'address_controller.dart';
import 'address_page.dart';
import 'widgets/address_detail/address_detail_module.dart';
import 'widgets/address_search_widget/address_search_controller.dart';

class AddressModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => AddressSearchController(addressService: i())),
        Bind.lazySingleton((i) => AddressController(addressService: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, __) => const AddressPage(),
        ),
        ModuleRoute('/detail', module: AddressDetailModule()),
      ];
}
