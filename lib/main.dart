import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:turbo_shark/homepage.dart';
import 'package:turbo_shark/models/downloadProvider.dart';
import 'package:turbo_shark/models/download_history.dart';
import 'package:turbo_shark/ssl/ssl_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init('user-data');
  await Hive.initFlutter();
  Hive.registerAdapter(DownloadHistoryAdapter());
  runApp(ChangeNotifierProvider(
      create: (context) => DownloadProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        dividerTheme: const DividerThemeData(color: Colors.transparent),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
