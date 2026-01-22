import 'package:flutter/material.dart';
import 'package:url_shortener_app/app/home/data/db_client.dart';

import 'app/app_widget.dart';

void main() async {
  runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  DBClient.db.database;
}
