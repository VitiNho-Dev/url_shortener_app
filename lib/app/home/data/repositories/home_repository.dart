import 'dart:developer';

import 'package:url_shortener_app/app/core/custom_errors.dart';
import 'package:url_shortener_app/app/core/error_messages.dart';
import 'package:url_shortener_app/app/core/results.dart';
import 'package:url_shortener_app/app/home/data/services/api/api_client.dart';
import 'package:url_shortener_app/app/home/models/home_model.dart';

abstract interface class HomeRepository {
  Future<Result<HomeModel>> call(String url);
}

class ApiHomeRepository implements HomeRepository {
  final ApiClient _apiClient;

  const ApiHomeRepository({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  @override
  Future<Result<HomeModel>> call(String url) async {
    try {
      final result = await _apiClient.sendUrl(url);

      if (result is Error) {
        return Result.error((result as Error).error);
      }

      final data = (result as Ok<String>).value;
      final homeModel = HomeModel(longUrl: url, shortUrl: data);

      return Result.ok(homeModel);
    } catch (error, stackTrace) {
      log('Repository error: ${error.toString()}', stackTrace: stackTrace);

      return Result.error(
        RepositoryError(message: ErrorMessages.failedToRetrieveShortenedURL),
      );
    }
  }
}
