class Note {
  /// The id of the note.
  int? id;
  /// The title of the note.
  final String title;
  /// The content of the note.
  final String note;
  /// The date and time when the note was last edited.
  final DateTime lastEdit;
  /// Boolean value to determine if the note was saved as private or not.
  bool? isLocked;

  ///Constructor for a Note without an id
  Note({
    required this.title,
    required this.note,
    required this.lastEdit,
    this.isLocked
  });

  ///Constructor for a Note with an id
  Note.withId({
    this.id,
    required this.title,
    required this.note,
    required this.lastEdit,
    this.isLocked
  });

  ///Convert a Note into a Map. The keys are the names of the columns in the db.
  Map<String, dynamic> toMap() {
      return {
        'id': id,
        'title': title,
        'note': note,
        'last_edit': lastEdit.toIso8601String(),
        'is_locked': isLocked == true ? 1 : 0,
      };
  }

  @override
  String toString() {
    return 'Note{'
        'id: $id, '
        'title: $title, '
        'note: $note, '
        'lastEdit: $lastEdit, '
        'isLocked: $isLocked'
        '}';
  }

}