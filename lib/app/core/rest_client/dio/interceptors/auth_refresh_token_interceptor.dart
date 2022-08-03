// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cuidapet_mobile/app/core/exceptions/expire_token_exception.dart';
import 'package:cuidapet_mobile/app/core/helpers/constants.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client_exception.dart';
import 'package:dio/dio.dart';

import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/modules/core/auth/auth_store.dart';

class AuthRefreshTokenInterceptor extends Interceptor {
  final AuthStore _authStore;
  final LocalStorage _localStorage;
  final LocalSecureStorage _localSecureStorage;
  final RestClient _restClient;
  final AppLogger _log;

  AuthRefreshTokenInterceptor({
    required AuthStore authStore,
    required LocalStorage localStorage,
    required LocalSecureStorage localSecureStorage,
    required RestClient restClient,
    required AppLogger log,
  })  : _authStore = authStore,
        _localStorage = localStorage,
        _localSecureStorage = localSecureStorage,
        _restClient = restClient,
        _log = log;

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    try {
      final responseStatusCode = err.response?.statusCode ?? 0;
      final requestPath = err.requestOptions.path;

      if (responseStatusCode == 403 || responseStatusCode == 401) {
        // Utiliza esta verificação do path, pois se o caminho é o refresh
        // portanto deu erro na solicitação do refresh e com isso ficaria
        // em loop infinito
        if (requestPath != '/auth/refresh') {
          final authRequired =
              err.requestOptions.extra[Constants.REST_CLIENT_AUTH_REQUIRED_KEY] ?? false;
          if (authRequired) {
            _log.info('########## Refresh Token ##########');
            await _refreshToken(err);
            await _retryRequest(err, handler);
            _log.info('########## Refresh Token Success ##########');
          } else {
            throw err;
          }
        } else {
          throw err;
        }
      } else {
        throw err;
      }
    } on DioError catch (e) {
      handler.next(e);
    } on ExpireTokenException {
      _authStore.logout();
      handler.next(err);
    } catch (e, s) {
      _log.error('Erro rest client', e, s);
      handler.next(err);
    }
  }

  Future<void> _refreshToken(DioError err) async {
    final refreshToken = await _localSecureStorage.read(Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY);
    if (refreshToken == null) {
      throw ExpireTokenException();
    }

    final resultRefresh = await _restClient.auth().put(
      'auth/refresh',
      data: {
        'refresh_token': refreshToken,
      },
    );
    await _localStorage.write<String>(
        Constants.LOCAL_STORAGE_ACCESS_TOKEN_KEY, resultRefresh.data['access_token']);
    await _localSecureStorage.write(
        Constants.LOCAL_STORAGE_REFRESH_TOKEN_KEY, resultRefresh.data['refresh_token']);
  }

  Future<void> _retryRequest(DioError err, ErrorInterceptorHandler handler) async {
    _log.info('########## Retry Request ##########');
    final requestOptions = err.requestOptions;
    final result = await _restClient.request(
      requestOptions.path,
      method: requestOptions.method,
      data: requestOptions.data,
      headers: requestOptions.headers,
      queryParameters: requestOptions.queryParameters,
    );

    handler.resolve(
      Response(
        requestOptions: requestOptions,
        data: result.data,
        statusCode: result.statusCode,
        statusMessage: result.statusMessage,
      ),
    );
  }
}
