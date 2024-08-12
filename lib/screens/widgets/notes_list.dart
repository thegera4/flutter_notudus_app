import 'package:flutter/material.dart';
import 'package:notudus/screens/widgets/notes_list_item.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data?.length ?? 0,
      itemBuilder: (context, index) {
        final note = snapshot.data![index];
        return NotesListItem(note: note);
      },
    );
  }
}