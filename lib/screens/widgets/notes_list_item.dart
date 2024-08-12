import 'package:flutter/material.dart';
import '../../models/note.dart';
import '../create_note_screen.dart';

class NotesListItem extends StatelessWidget {
  const NotesListItem({super.key, required this.note});
  final Note? note;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateNoteScreen(note: note))
          );
        },
        title: Text(note!.title),
        subtitle: Text(note!.note),
      ),
    );
  }
}
