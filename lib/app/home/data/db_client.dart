import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBClient {
  Future<Database> get database async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'shortened_url.db'),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE IF NOT EXISTS shortened_url (
	            id INTEGER PRIMARY KEY AUTOINCREMENT,
	            long_url TEXT NOT NULL,
	            short_url TEXT NOT NULL
            )''',
        );
      },
      version: 1,
    );

    return database;
  }
}
