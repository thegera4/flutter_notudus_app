import 'package:flutter/material.dart';
import 'package:notudus/screens/widgets/notes_grid_item.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({super.key, required this.snapshot});
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: snapshot.data?.length ?? 0,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0
        ),
        itemBuilder: (context, index) {
            final note = snapshot.data![index];
            return NotesGridItem(note: note);
            },
      ),
    );
  }
}