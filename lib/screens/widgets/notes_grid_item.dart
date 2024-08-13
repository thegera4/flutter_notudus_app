import 'package:flutter/material.dart';
import 'package:notudus/screens/widgets/last_modified_on.dart';
import 'package:notudus/screens/widgets/note_item_preview.dart';
import 'package:notudus/screens/widgets/note_item_title.dart';
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
              MaterialPageRoute(builder: (context) =>
                  CreateNoteScreen(note: note)
              )
          );
        },
        child: Column(
          children: [
            NoteItemTitle(note: note),
            NoteItemPreview(note: note),
            LastModifiedOn(note: note),
          ],
        ),
      ),
    );
  }
}