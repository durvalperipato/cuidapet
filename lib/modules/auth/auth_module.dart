import 'package:cuidapet_mobile/modules/auth/home/auth_home_page.dart';
import 'package:cuidapet_mobile/modules/auth/login/login_module.dart';
import 'package:cuidapet_mobile/modules/core/core_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, __) => AuthHomePage(
            authStore: Modular.get(),
          ),
        ),
        ModuleRoute('/login', module: LoginModule())
      ];
}
