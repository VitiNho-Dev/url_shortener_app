import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBClient {
  DBClient._();

  static final db = DBClient._();

  Future<Database> get database async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'home_model.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE urlsShortner(id INTIGER PRIMARY KEY, urlLong TEXT, urlShort TEXT)',
        );
      },
      version: 1,
    );

    return database;
  }
}
