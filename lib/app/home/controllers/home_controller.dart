import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sql.dart';
import 'package:url_shortener_app/app/home/controllers/home_state.dart';
import 'package:url_shortener_app/app/home/data/db_client.dart';

import '../models/home_model.dart';

class HomeController extends ValueNotifier<HomeState> {
  HomeController._() : super(HomeInitial());

  static final controller = HomeController._();

  final _database = DBClient.db.database;

  Future<void> sendUrl(String url) async {
    final response = await http.post(
      Uri.parse('https://api.encurtador.dev/encurtamentos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'url': url}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;

      final shortUrl = json['urlEncurtada'] as String;

      final model = HomeModel(
        longUrl: url,
        shortUrl: shortUrl,
      );

      _saveShortenedUrl(model);
    } else {
      value = HomeFailure(
        error: Exception('Ocorreu um erro ao enviar o URL'),
      );
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
