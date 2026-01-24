import 'package:flutter/material.dart';
import 'package:url_shortener_app/app/home/controllers/home_controller.dart';

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
          controller: HomeController.controller,
        ),
      },
    );
  }
}
