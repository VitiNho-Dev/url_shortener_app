import 'package:flutter/foundation.dart';
import 'package:sqflite/sql.dart';
import 'package:url_shortener_app/app/core/results.dart';
import 'package:url_shortener_app/app/home/controllers/home_state.dart';
import 'package:url_shortener_app/app/home/data/db_client.dart';
import 'package:url_shortener_app/app/home/data/repositories/home_repository.dart';

import '../models/home_model.dart';

class HomeController extends ValueNotifier<HomeState> {
  HomeController({required HomeRepository repository})
    : _repository = repository,
      super(HomeInitial());

  final _database = DBClient.db.database;
  final HomeRepository _repository;

  Future<void> sendUrl(String url) async {
    final result = await _repository(url);

    switch (result) {
      case Ok<HomeModel>():
        _saveShortenedUrl(result.value);
        break;
      case Error():
        value = HomeFailure(error: result.error);
        break;
    }
  }

  Future<void> _saveShortenedUrl(HomeModel model) async {
    final db = await _database;

    await db.insert(
      'shortened_url',
      model.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    getAllShortenedUrl();
  }

  Future<void> deleteShortenedUrl(int id) async {
    final db = await _database;

    await db.delete(
      'shortened_url',
      where: 'id = ?',
      whereArgs: [id],
    );

    getAllShortenedUrl();
  }

  Future<void> getAllShortenedUrl() async {
    value = HomeLoading();

    final db = await _database;

    final result = await db.query('shortened_url');

    final model = (result as List)
        .cast<Map<String, Object?>>()
        .map(HomeModel.fromJson)
        .toList();

    if (model.isEmpty) {
      value = HomeInitial();
      return;
    }

    value = HomeSuccess(model: model);
  }
}
