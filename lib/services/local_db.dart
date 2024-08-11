import 'package:sqflite/sqflite.dart';
import '../models/note.dart';

class LocalDBService {

  ///Adds a new note to the database
  static Future<String> addNote(Note note, Database database) async {
    try {
      await database.insert(
        'notes',
        note.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return 'Note added successfully';
    } catch (e) {
      return 'Error';
    }
  }

  ///Returns a list of notes from the database
  static Future<List<Note>> getNotes(Database database) async {
    try{
      final List<Map<String, dynamic>> maps = await database.query('notes');
      return List.generate(maps.length, (i) {
        return Note(
          id: maps[i]['id'],
          title: maps[i]['title'],
          note: maps[i]['note'],
          lastEdit: DateTime.parse(maps[i]['last_edit']),
        );
      });
    } catch (e) {
      throw Exception('Error fetching notes: $e');
    }
  }

}