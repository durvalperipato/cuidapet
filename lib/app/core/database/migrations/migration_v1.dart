import 'package:cuidapet_mobile/app/core/database/migrations/migration.dart';
import 'package:sqflite/sqflite.dart';

class MigrationV1 implements Migration {
  @override
  void create(Batch batch) {
    batch.execute('''
      CREATE TABLE address (
        id Integer primary key autoincrement,
        address text not null,
        lat text,
        lng text,
        additional text
      )
      ''');
  }

  @override
  void upgrade(Batch batch) {}
}
