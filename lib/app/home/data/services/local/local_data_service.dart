import 'package:sqflite/sql.dart';
import 'package:url_shortener_app/app/home/data/services/local/db_client.dart';
import 'package:url_shortener_app/app/home/models/home_model.dart';

class LocalDataService {
  LocalDataService({
    required DBClient dbClient,
  }) : _dbClient = dbClient;

  final DBClient _dbClient;
  final _dbName = 'shortened_url';

  Future<void> saveShortenedUrl(HomeModel model) async {
    final db = await _dbClient.database;

    await db.insert(
      _dbName,
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteShortenedUrl(int id) async {
    final db = await _dbClient.database;

    final urlIDDeleted = await db.delete(
      _dbName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return urlIDDeleted;
  }

  Future<List<HomeModel>> getAllShortenedUrl() async {
    final db = await _dbClient.database;

    final result = await db.query(_dbName);

    final homeModels = (result as List)
        .cast<Map<String, Object?>>()
        .map(HomeModel.fromJson)
        .toList();

    return homeModels;
  }
}
