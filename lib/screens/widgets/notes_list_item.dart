import 'package:flutter/material.dart';
import 'package:notudus/res/text_styles.dart';
import 'package:notudus/screens/widgets/last_modified_on.dart';
import '../../models/note.dart';
import '../../res/values.dart';
import '../create_note_screen.dart';

class NotesListItem extends StatelessWidget {
  const NotesListItem({super.key, required this.note});
  final Note? note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppValues.smallPadding),
      child: Card(
        color: Colors.grey[900],
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                        CreateNoteScreen(note: note))
                );
              },
              title: Text(
                  note!.title,
                  maxLines: 1,
                  style: AppTextStyles.noteTitle
              ),
              subtitle: Text(
                note!.note,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: AppValues.normalPadding,
                  right: AppValues.normalPadding,
              ),
              child: LastModifiedOn(note: note),
            ),
          ],
        ),
      ),
    );
  }
}