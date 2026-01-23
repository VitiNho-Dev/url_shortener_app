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
          '''CREATE TABLE IF NOT EXISTS urls_shortner (
            id INTIGER PRIMARY KEY,
            urlLong TEXT NOT NULL,
            urlShort TEXT NOT NULL
          )''',
        );
      },
      version: 1,
    );

    return database;
  }
}
