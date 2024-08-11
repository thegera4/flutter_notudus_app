import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:notudus/res/strings.dart';
import 'package:notudus/screens/home_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:notudus/services/local_db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
      join(await getDatabasesPath(), AppStrings.dbName),
      onCreate: (db, version) {
        return db.execute(AppStrings.createNotesTable,);
      },
      version: 1,

  );
  var notes = await LocalDBService.getNotes(database);
  log('Notes: $notes');
  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.database});
  final Database database;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.green,
          accentColor: Colors.green,
          cardColor: Colors.black,
          backgroundColor: Colors.black,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(database: database),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.database});
  final Database database;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => HomeScreen(database: widget.database);
}