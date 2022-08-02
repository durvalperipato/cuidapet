// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_mobile/app/core/exceptions/failure.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/exceptions/user_not_exists_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/models/social_login_type.dart';
import 'package:cuidapet_mobile/app/models/social_network_model.dart';
import 'package:cuidapet_mobile/repositories/social/social_repository.dart';
import 'package:cuidapet_mobile/repositories/user/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _userRepository;
  final SocialRepository _socialRepository;
  final AppLogger _log;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;

  UserServiceImpl({
    required UserRepository userRepository,
    required SocialRepository socialRepository,
    required AppLogger log,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
  })  : _userRepository = userRepository,
        _socialRepository = socialRepository,
        _log = log,
        _localStorage = localStorage,
        _localSecureStorage = localSecureStorage;

  @override
  Future<void> register({required String email, required String password}) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final userMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (userMethods.isNotEmpty) {
        throw UserExistsException();
      }
      await _userRepository.register(email: email, password: password);
      final userRegisterCredential =
          await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await userRegisterCredential.user?.sendEmailVerification();
    } on FirebaseException catch (e, s) {
      _log.error('Erro ao criar usuário no Firebase', e, s);
      throw Failure(message: 'Erro ao criar usuário');
    }
  }

  @override
  Future<void> login({required String email, required String password}) async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(email);
      if (loginMethods.isEmpty) {
        throw UserNotExistsException();
      }
      if (loginMethods.contains('password')) {
        final userCredential =
            await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
        final userVerified = userCredential.user?.emailVerified ?? false;
        if (!userVerified) {
          userCredential.user?.sendEmailVerification();
          throw Failure(message: 'Email não confirmado, por favor verifique sua caixa de spam');
        }
        final accessToken = await _userRepository.login(email: email, password: password);
        await _saveAccessToken(accessToken);
        await _confirmLogin();
        await _getUserData();
      } else {
        throw Failure(message: 'Login não pode ser feito por e-mail e password');
      }
    } on FirebaseAuthException catch (e, s) {
      _log.error('Usuário ou senha inválidos -> FirebaseAuthError[${e.code}]', e, s);
      throw Failure(message: 'Usuário ou senha inválidos');
    }
  }

  Future<void> _saveAccessToken(String accessToken) =>
      _localStorage.write(Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY, accessToken);

  Future<void> _confirmLogin() async {
    final confirmLoginModel = await _userRepository.confirmLogin();
    await _saveAccessToken(confirmLoginModel.accessToken);
    await _localSecureStorage.write(
        Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY, confirmLoginModel.refreshToken);
  }

  Future<void> _getUserData() async {
    final userModel = await _userRepository.getUserLogged();
    await _localStorage.write<String>(
        Constants.LOCAL_STORAGE_USER_LOGGED_DATA_KEY, userModel.toJson());
  }

  @override
  Future<void> socialLogin(SocialLoginType socialLoginType) async {
    try {
      final SocialNetworkModel socialModel;
      final AuthCredential authCredential;
      final firebaseAuth = FirebaseAuth.instance;

      switch (socialLoginType) {
        case SocialLoginType.facebook:
          throw Failure(message: 'Facebook not implemented');

        case SocialLoginType.google:
          socialModel = await _socialRepository.googleLogin();
          authCredential = GoogleAuthProvider.credential(
            accessToken: socialModel.accessToken,
            idToken: socialModel.id,
          );
          break;
      }
      final loginMethods = await firebaseAuth.fetchSignInMethodsForEmail(socialModel.email);
      final methodCheck = _getMethodToSocialLoginType(socialLoginType);
      if (loginMethods.isNotEmpty && !loginMethods.contains(methodCheck)) {
        throw Failure(
            message: 'Login não pode ser feito $methodCheck, por favor utilize outro método');
      }
      await firebaseAuth.signInWithCredential(authCredential);
      final accessToken = await _userRepository.loginSocial(socialModel);
      await _saveAccessToken(accessToken);
      await _confirmLogin();
      await _getUserData();
    } on FirebaseAuthException catch (e, s) {
      _log.error('Erro ao realizar login com $socialLoginType', e, s);
      throw Failure(message: 'Erro ao realizar login');
    }
  }

  String _getMethodToSocialLoginType(SocialLoginType socialLoginType) {
    switch (socialLoginType) {
      case SocialLoginType.facebook:
        return 'facebook.com';

      case SocialLoginType.google:
        return 'google.com';
    }
  }
}
