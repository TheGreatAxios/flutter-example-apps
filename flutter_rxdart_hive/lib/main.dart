import 'package:flutter/material.dart';
import 'package:flutter_rxdart_hive/todos.page.dart';
import 'hive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService hiveService = HiveService();

  await hiveService.startHive();

  runApp(FlutterRxDartHiveApp());
}

class FlutterRxDartHiveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Todos(),
    );
  }
}
