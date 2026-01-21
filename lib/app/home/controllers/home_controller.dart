import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:url_shortener_app/app/home/controllers/home_state.dart';

import '../models/home_model.dart';

class HomeController extends ValueNotifier<HomeState> {
  HomeController() : super(HomeInitial());

  Future<void> sendUrl(String url) async {
    final response = await http.post(
      Uri.parse('https://api.encurtador.dev/encurtamentos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(HomeModel.toJson(url)),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final result = HomeModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );

      final data = result.copyWith(urlLong: url);

      saveHomeModel(data);
    } else {
      value = HomeFailure(error: Exception('Ocorreu um erro ao enviar o URL'));
    }
  }

  final _items = <HomeModel>[];

  Future<void> saveHomeModel(HomeModel data) async {
    _items.add(data);

    getHistoricUrl();
  }

  Future<void> getHistoricUrl() async {
    value = HomeLoading();

    final result = await Future.delayed(Duration(seconds: 3), () {
      return _items;
    });

    if (_items.isEmpty) {
      value = HomeInitial();
      return;
    }

    value = HomeSuccess(data: result);
  }
}
