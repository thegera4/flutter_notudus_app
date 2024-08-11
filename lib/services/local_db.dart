import 'dart:developer';
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';
import 'package:path/path.dart';

class LocalDBService {

  ///Singleton instance
  static final LocalDBService _instance = LocalDBService._createInstance();
  ///Database instance
  static Database? _database;

  ///Named constructor for the singleton instance
  LocalDBService._createInstance();

  ///Factory constructor for the singleton instance
  factory LocalDBService() { // factory constructor lets you return something
    return _instance;
  }

  ///Returns the database instance
  Future<Database> get database async {
    // ignore: prefer_conditional_assignment
    if (_database == null) {
      _database = await _initDb();
    }
    return _database!;
  }

  ///Initializes the database (opens the database and creates the notes table)
  ///Returns a Future with the database instance
  Future<Database> _initDb() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'notudus.db'),
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE IF NOT EXISTS notes('
            'id INTEGER PRIMARY KEY, title TEXT, note TEXT, last_edit TEXT)');
      },
      version: 1,
    );
  }

  ///Returns a Future with a list of notes from the database
  ///Throws an exception if there is an error
  Future<List<Note>> getNotes() async {
    try{
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('notes');
      return List.generate(maps.length, (index) {
        return Note.withId(
          id: maps[index]['id'],
          title: maps[index]['title'],
          note: maps[index]['note'],
          lastEdit: DateTime.parse(maps[index]['last_edit']),
        );
      });
    } catch(e) {
      log('Error getting notes: $e');
      throw Exception('Error getting notes');
    }
  }

  ///Listens to changes in the notes table to update the UI
  ///Returns a Stream with a list of notes
  Stream<List<Note>> listenAllNotes() async* {
    final db = await database;
    yield* Stream.periodic(const Duration(seconds: 1)).asyncMap((_) async {
      final List<Map<String, dynamic>> maps = await db.query('notes');
      return List.generate(maps.length, (index) {
        return Note.withId(
          id: maps[index]['id'],
          title: maps[index]['title'],
          note: maps[index]['note'],
          lastEdit: DateTime.parse(maps[index]['last_edit']),
        );
      });
    });
  }

  ///Adds a new note to the database
  ///Returns a Future with a message indicating if the note was added or not
  Future<String> addNote(Note note) async {
    try {
      final db = await database;
      await db.insert(
        'notes',
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return 'Note added';
    } catch (e) {
      return 'Error';
    }
  }

  ///Deletes a note from the database
  Future<void> deleteNote(int id) async {
    final db = await database;
    await db.delete('notes', where: 'id = ?', whereArgs: [id],);
  }

  ///Creates the TODOS table in the database
  Future<void> createTodosTable(Database database) async {
    await database.execute('CREATE TABLE IF NOT EXISTS todos('
        'id INTEGER PRIMARY KEY, title TEXT, todo TEXT, is_done INTEGER)');
  }

}