// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/loader.dart';
import 'package:cuidapet_mobile/app/core/ui/widgets/messages.dart';
import 'package:mobx/mobx.dart';

import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/services/user/user_service.dart';

part 'register_controller.g.dart';

class RegisterController = RegisterControllerBase with _$RegisterController;

abstract class RegisterControllerBase with Store {
  final UserService _userService;
  final AppLogger _log;
  RegisterControllerBase({
    required UserService userService,
    required AppLogger log,
  })  : _userService = userService,
        _log = log;

  Future<void> register({required String email, required String password}) async {
    try {
      Loader.show();
      await _userService.register(email: email, password: password);
      Messages.info('Enviamos um e-mail de confirmação, por favor verifique sua caixa de e-mail');
    } on UserExistsException {
      Messages.alert('Email já utilizado, por favor escolha outro');
    } catch (e, s) {
      _log.error('Erro ao registar usuário', e, s);
      Messages.alert('Erro ao registrar usuário');
    } finally {
      Loader.hide();
    }
  }
}
