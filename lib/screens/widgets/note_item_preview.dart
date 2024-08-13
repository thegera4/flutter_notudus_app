import 'package:flutter/material.dart';
import 'package:notudus/res/values.dart';
import '../../models/note.dart';

class NoteItemPreview extends StatelessWidget {
  const NoteItemPreview({super.key, required this.note});
  final Note? note;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(AppValues.normalPadding),
        alignment: Alignment.topLeft,
        child: Text(note!.note, maxLines: 3),
      ),
    );
  }
}