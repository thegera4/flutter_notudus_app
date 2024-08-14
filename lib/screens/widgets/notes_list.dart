import 'package:flutter/material.dart';
import 'package:notudus/screens/widgets/empty_view.dart';
import 'package:notudus/screens/widgets/notes_list_item.dart';

class NotesList extends StatelessWidget {
  const NotesList({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: snapshot.data?.length ?? 0,
        itemBuilder: (context, index) {
          final note = snapshot.data![index];
          if (snapshot.data!.isEmpty) {
            return const EmptyView();
          }
          return NotesListItem(note: note);
        },
      ),
    );
  }
}