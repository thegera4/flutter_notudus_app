import 'package:flutter/material.dart';
import 'package:notudus/res/values.dart';
import '../../models/note.dart';
import '../create_note_screen.dart';

class NotesGridItem extends StatelessWidget {
  const NotesGridItem({super.key, required this.note});
  final Note? note;

  //TODO: fix the overflow when the text is to big to show only a portion of it
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) =>
                  CreateNoteScreen(note: note))
          );
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppValues.normalPadding),
              alignment: Alignment.centerLeft,
              child: Text(
                  note!.title,
                  style: const TextStyle(
                      fontSize: AppValues.noteItemTitleSize,
                      fontWeight: FontWeight.bold
                  )
              ),
            ),
            Container(
              padding: const EdgeInsets.all(AppValues.normalPadding),
              alignment: Alignment.centerLeft,
              child: Text(note!.note),
            ),
          ],
        ),
      ),
    );
  }
}