import 'package:flutter/material.dart';
import '../../models/note.dart';
import '../create_note_screen.dart';

class NotesGridItem extends StatelessWidget {
  const NotesGridItem({super.key, required this.note});
  final Note? note;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateNoteScreen(note: note))
          );
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                  note!.title,
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.centerLeft,
              child: Text(note!.note),
            ),
          ],
        ),
      ),
    );
  }
}