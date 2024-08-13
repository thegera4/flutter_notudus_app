import 'package:flutter/material.dart';
import 'package:notudus/models/note.dart';
import 'package:notudus/res/text_styles.dart';
import '../../res/values.dart';

class NoteItemTitle extends StatelessWidget {
  const NoteItemTitle({super.key, required this.note});
  final Note? note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppValues.normalPadding),
      alignment: Alignment.centerLeft,
      child: Text(note!.title, maxLines:1, style: AppTextStyles.noteTitle,),
    );
  }
}