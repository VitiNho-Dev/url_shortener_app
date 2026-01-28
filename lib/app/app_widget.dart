import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:url_shortener_app/app/home/controllers/home_controller.dart';
import 'package:url_shortener_app/app/home/data/repositories/home_repository.dart';
import 'package:url_shortener_app/app/home/data/services/api/api_client.dart';
import 'package:url_shortener_app/app/home/data/services/local/local_data_service.dart';

import 'home/views/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
      ),
      theme: ThemeData(
        colorScheme: .fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(
          controller: GetIt.instance<HomeController>(),
        ),
      },
    );
  }
}
