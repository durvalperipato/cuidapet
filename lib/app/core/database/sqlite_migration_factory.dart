import 'package:cuidapet_mobile/app/core/database/migrations/migration.dart';
import 'package:cuidapet_mobile/app/core/database/migrations/migration_v1.dart';

class SqliteMigrationFactory {
  List<Migration> getCreateMigrations() => [MigrationV1()];
  List<Migration> getUpgradeMigrations(int version) => [];
}
