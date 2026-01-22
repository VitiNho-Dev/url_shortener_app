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

      final urlShort = json['urlEncurtada'] as String;

      final homeModel = HomeModel(urlLong: url, urlShort: urlShort);

      _saveHomeModel(homeModel);
    } else {
      value = HomeFailure(error: Exception('Ocorreu um erro ao enviar o URL'));
    }
  }

  Future<void> _saveHomeModel(HomeModel data) async {
    final db = await _database;

    await db.insert(
      'urlsShortner',
      HomeModel.toJson(data),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> getHistoricUrl() async {
    value = HomeLoading();

    final db = await _database;

    final result = await db.query('urlsShortner');

    final homeModel = (result as List)
        .cast<Map<String, Object?>>()
        .map(HomeModel.fromJson)
        .toList();

    value = HomeSuccess(data: homeModel);
  }
}
