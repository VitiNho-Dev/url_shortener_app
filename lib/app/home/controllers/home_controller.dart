import 'package:flutter/foundation.dart';
import 'package:url_shortener_app/app/core/results.dart';
import 'package:url_shortener_app/app/home/controllers/home_state.dart';
import 'package:url_shortener_app/app/home/data/repositories/home_repository.dart';
import 'package:url_shortener_app/app/home/data/services/local/local_data_service.dart';

import '../models/home_model.dart';

class HomeController extends ValueNotifier<HomeState> {
  HomeController({
    required HomeRepository repository,
    required LocalDataService dataService,
  }) : _repository = repository,
       _dataService = dataService,
       super(HomeInitial());

  final HomeRepository _repository;
  final LocalDataService _dataService;

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
    await _dataService.saveShortenedUrl(model);

    getAllShortenedUrl();
  }

  Future<void> deleteShortenedUrl(int id) async {
    await _dataService.deleteShortenedUrl(id);

    getAllShortenedUrl();
  }

  Future<void> getAllShortenedUrl() async {
    value = HomeLoading();

    final result = await _dataService.getAllShortenedUrl();

    if (result.isEmpty) {
      value = HomeInitial();
      return;
    }

    value = HomeSuccess(model: result);
  }
}
