import 'package:flutter_modular/flutter_modular.dart';

import '../../repositories/social/social_repository.dart';
import '../../repositories/social/social_repository_impl.dart';
import '../../repositories/user/user_repository.dart';
import '../../repositories/user/user_repository_impl.dart';
import '../../services/user/user_service.dart';
import '../../services/user/user_service_impl.dart';
import 'home/auth_home_page.dart';
import 'login/login_module.dart';
import 'register/register_module.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<SocialRepository>((i) => SocialRepositoryImpl()),
        Bind.lazySingleton<UserRepository>((i) => UserRepositoryImpl(log: i(), restClient: i())),
        Bind.lazySingleton<UserService>(
          (i) => UserServiceImpl(
            log: i(),
            userRepository: i(),
            socialRepository: i(),
            localStorage: i(),
            localSecureStorage: i(),
          ),
        ),
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
