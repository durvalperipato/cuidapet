import 'package:cuidapet_mobile/modules/auth/home/auth_home_page.dart';
import 'package:cuidapet_mobile/modules/auth/login/login_module.dart';
import 'package:cuidapet_mobile/modules/auth/register/register_module.dart';
import 'package:cuidapet_mobile/modules/core/core_module.dart';
import 'package:cuidapet_mobile/repositories/user/user_repository.dart';
import 'package:cuidapet_mobile/repositories/user/user_repository_impl.dart';
import 'package:cuidapet_mobile/services/user/user_service.dart';
import 'package:cuidapet_mobile/services/user/user_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<UserRepository>((i) => UserRepositoryImpl(log: i(), restClient: i())),
        Bind.lazySingleton<UserService>(
          (i) => UserServiceImpl(
            log: i(),
            userRepository: i(),
            localStorage: i(),
            localSecureStorage: i(),
          ),
        ),
      ];

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
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/register', module: RegisterModule()),
      ];
}
