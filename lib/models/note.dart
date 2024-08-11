class Note {
  int? id;
  final String title;
  final String note;
  final DateTime lastEdit;

  ///Constructor for a Note without an id
  Note({required this.title, required this.note, required this.lastEdit});

  ///Constructor for a Note with an id
  Note.withId({
    this.id,
    required this.title,
    required this.note,
    required this.lastEdit
  });

  ///Convert a Note into a Map. The keys are the names of the columns in the db.
  Map<String, dynamic> toMap() {
      return {
        'id': id,
        'title': title,
        'note': note,
        'last_edit': lastEdit.toIso8601String()
      };
  }

  @override
  String toString() {
    return 'Note{id: $id, title: $title, note: $note, lastEdit: $lastEdit}';
  }
}