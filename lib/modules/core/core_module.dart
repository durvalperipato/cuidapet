import 'package:cuidapet_mobile/app/core/database/sqlite_connection_factory.dart';
import 'package:cuidapet_mobile/app/core/local_storage/flutter_secure_storage/flutter_secure_storage_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/core/local_storage/local_storage.dart';
import 'package:cuidapet_mobile/app/core/local_storage/shared_prefences/shared_preferences_local_storage_impl.dart';
import 'package:cuidapet_mobile/app/core/logger/app_logger.dart';
import 'package:cuidapet_mobile/app/core/logger/logger_app_logger_impl.dart';
import 'package:cuidapet_mobile/app/core/rest_client/dio/dio_rest_client.dart';
import 'package:cuidapet_mobile/app/core/rest_client/rest_client.dart';
import 'package:cuidapet_mobile/modules/core/auth/auth_store.dart';
import 'package:cuidapet_mobile/repositories/address/address_repository_impl.dart';
import 'package:cuidapet_mobile/services/address/address_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => SqliteConnectionFactory(), export: true),
        Bind.lazySingleton<AppLogger>((i) => LoggerAppLoggerImpl(), export: true),
        Bind.lazySingleton<LocalStorage>((i) => SharedPreferencesLocalStorageImpl(), export: true),
        Bind.lazySingleton<LocalSecureStorage>((i) => FlutterSecureStorageLocalStorageImpl(),
            export: true),
        Bind.lazySingleton((i) => AuthStore(localStorage: i()), export: true),
        Bind.lazySingleton<RestClient>(
            (i) => DioRestClient(
                  localStorage: i(),
                  localSecureStorage: i(),
                  log: i(),
                  authStore: i(),
                ),
            export: true),
        Bind.lazySingleton((i) => AddressRepositoryImpl(), export: true),
        Bind.lazySingleton((i) => AddressServiceImpl(addressRepository: i()), export: true),
      ];
}
