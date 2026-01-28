import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:url_shortener_app/app/core/custom_errors.dart';
import 'package:url_shortener_app/app/core/error_messages.dart';
import 'package:url_shortener_app/app/core/results.dart';

class ApiClient {
  Future<Result<String>> sendUrl(String url) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.encurtador.dev/encurtamentos'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'url': url}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final shortUrl = json['urlEncurtada'] as String;

        return Result.ok(shortUrl);
      }

      log('POST: ${response.statusCode}');

      final data = jsonDecode(response.body);
      final errorMessage = data['message'] ?? ErrorMessages.failureToShortenURL;

      return Result.error(
        ApiError(message: errorMessage),
      );
    } on ClientHttpError catch (error, stackTrace) {
      log('ClientHttpError: ${error.message}', stackTrace: stackTrace);

      return Result.error(
        ClientHttpError(message: ErrorMessages.onServer),
      );
    } catch (error, stackTrace) {
      log('Unexpected error: ${error.toString()}', stackTrace: stackTrace);

      return Result.error(
        UnexpectedError(message: ErrorMessages.unexpected),
      );
    }
  }
}
