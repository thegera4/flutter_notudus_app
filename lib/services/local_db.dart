import 'package:notudus/res/strings.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';
import 'package:path/path.dart';

/// A service class that handles the local SQLite database operations.
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
            'id INTEGER PRIMARY KEY, '
            'title TEXT, '
            'note TEXT, '
            'last_edit TEXT, '
            'is_locked INTEGER)');
      },
      version: 1,
    );
  }

  ///Returns a Future with a list of  notes from the db. If the user is authenticated,
  ///it returns all notes, otherwise it returns only the notes with the property
  ///is_locked = 0. Throws an exception if there is an error.
  Future<List<Note>> getNotes(bool isAuthenticated) async {
    try{
      final db = await database;
      if (isAuthenticated) {
        final List<Map<String, dynamic>> maps = await db.query('notes');
        return List.generate(maps.length, (index) {
          return Note.withId(
            id: maps[index]['id'],
            title: maps[index]['title'],
            note: maps[index]['note'],
            lastEdit: DateTime.parse(maps[index]['last_edit']),
            isLocked: maps[index]['is_locked'],
          );
        });
      } else {
        final List<Map<String, dynamic>> maps =
            await db.query('notes', where: 'is_locked = 0');
        return List.generate(maps.length, (index) {
          return Note.withId(
            id: maps[index]['id'],
            title: maps[index]['title'],
            note: maps[index]['note'],
            lastEdit: DateTime.parse(maps[index]['last_edit']),
            isLocked: maps[index]['is_locked'] == 0,
          );
        });
      }
    } catch(e) {
      throw Exception(AppStrings.errorGettingNotes);
    }
  }

  ///Listens to changes in the notes table to update the UI. If the user is
  ///authenticated, it returns all notes, otherwise it returns only the notes
  ///with the property is_locked = 0.
  ///Returns a Stream with a list of notes
  Stream<List<Note>> listenAllNotes(bool isAuthenticated) async* {
    final db = await database;
    if (isAuthenticated) {
      yield* Stream.periodic(const Duration(milliseconds: 500)).asyncMap((_) async {
        final List<Map<String, dynamic>> maps = await db.query('notes');
        return List.generate(maps.length, (index) {
          return Note.withId(
            id: maps[index]['id'],
            title: maps[index]['title'],
            note: maps[index]['note'],
            lastEdit: DateTime.parse(maps[index]['last_edit']),
            isLocked: maps[index]['is_locked'],
          );
        });
      });
    } else {
      yield* Stream.periodic(const Duration(milliseconds: 500)).asyncMap((_) async {
        final List<Map<String, dynamic>> maps =
        await db.query('notes', where: 'is_locked = 0');
        return List.generate(maps.length, (index) {
          return Note.withId(
            id: maps[index]['id'],
            title: maps[index]['title'],
            note: maps[index]['note'],
            lastEdit: DateTime.parse(maps[index]['last_edit']),
            isLocked: maps[index]['is_locked'] == 0,
          );
        });
      });
    }
  }

  ///Adds a new note to the database.
  ///Returns a Future with a message indicating if the note was added or not.
  Future<String> addNote(Note note) async {
    try {
      final db = await database;
      await db.insert(
        'notes',
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return AppStrings.noteAdded;
    } catch (e) {
      return AppStrings.error;
    }
  }

  ///Deletes a note from the database.
  ///Throws an exception if there is an error.
  Future<void> deleteNote(int id) async {
    final db = await database;
    try {
      await db.delete('notes', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception(AppStrings.errorDeleting + e.toString());
    }
  }

  ///Updates a note in the database.
  ///Throws an exception if there is an error.
  Future<void> updateNote(Note note) async {
    final db = await database;
    try {
      await db.update(
        'notes',
        note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id],
      );
    } catch (e) {
      throw Exception(AppStrings.errorUpdating + e.toString());
    }
  }

  /// Searches notes in the database based on the query.
  /// Returns a Future with a list of notes that match the query.
  Future<List<Note>> searchNotes(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
        'notes',
        where: 'title LIKE ? OR note LIKE ?',
        whereArgs: ['%$query%', '%$query%']);
    return List.generate(maps.length, (index) {
      return Note.withId(
        id: maps[index]['id'],
        title: maps[index]['title'],
        note: maps[index]['note'],
        lastEdit: DateTime.parse(maps[index]['last_edit']),
        isLocked: maps[index]['is_locked'] == 0,
      );
    });
  }

  ///Creates the TODOS table in the database
  Future<void> createTodosTable(Database database) async {
    await database.execute('CREATE TABLE IF NOT EXISTS todos('
        'id INTEGER PRIMARY KEY, title TEXT, todo TEXT, is_done INTEGER)');
  }

}