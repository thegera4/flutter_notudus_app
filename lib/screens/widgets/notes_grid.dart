import 'package:flutter/material.dart';
import 'package:notudus/screens/widgets/notes_grid_item.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;

  //TODO: fix the GridView.builder because it has an error

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0
        ),
        itemBuilder: (context, index) {
          final note = snapshot.data![index];
          return NotesGridItem(note: note);
        },
    );
  }
}