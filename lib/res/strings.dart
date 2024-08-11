class AppStrings {
  static const String dbName = 'notudus.db';
  static const String appName = 'Notudus';
  static const String notes = 'Notes';
  static const String todos = 'Todos';
  static const String note = 'Note';
  static const String todo = 'Todo';
  static const String addNote = 'Add Note';
  static const String addTodo = 'Add Todo';
  static const String search = 'Search';
  static const String changeView = 'Change View';
  static const String noNotes = 'No notes found. Tap + to add a new note.';

  //Database
  static const String createNotesTable = 'CREATE TABLE IF NOT EXISTS notes(id INTEGER PRIMARY KEY, title TEXT, note TEXT, last_edit TEXT)';
}