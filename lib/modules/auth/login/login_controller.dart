// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../app/core/exceptions/failure.dart';
import '../../../app/core/exceptions/user_not_exists_exception.dart';
import '../../../app/core/logger/app_logger.dart';
import '../../../app/core/ui/widgets/loader.dart';
import '../../../app/core/ui/widgets/messages.dart';
import '../../../app/models/social_login_type.dart';
import '../../../services/user/user_service.dart';

part 'login_controller.g.dart';

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final UserService _userService;
  final AppLogger _log;

  LoginControllerBase({
    required UserService userService,
    required AppLogger log,
  })  : _userService = userService,
        _log = log;

  Future<void> login({required String login, required String password}) async {
    try {
      Loader.show();
      await _userService.login(email: login, password: password);
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e, s) {
      final message = e.message ?? 'Erro ao realizar login';
      _log.error(message, e, s);
      Messages.alert(message);
    } on UserNotExistsException {
      const message = "Usuário não encontrado";
      _log.error(message);
      Messages.alert(message);
    } finally {
      Loader.hide();
    }
  }

  Future<void> socialLogin(SocialLoginType socialLoginType) async {
    try {
      Loader.show();
      await _userService.socialLogin(socialLoginType);
      Loader.hide();
      Modular.to.navigate('/auth/');
    } on Failure catch (e, s) {
      _log.error('Erro ao realizar login', e, s);
      Messages.alert(e.message ?? 'Erro ao realizar login');
    } finally {
      Loader.hide();
    }
  }
}
