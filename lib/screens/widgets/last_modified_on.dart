import 'package:flutter/material.dart';
import '../../models/note.dart';
import '../../res/strings.dart';
import '../../res/values.dart';

class LastModifiedOn extends StatelessWidget {
  const LastModifiedOn({super.key, required this.note});
  final Note? note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppValues.normalPadding),
      alignment: Alignment.centerLeft,
      child: Text(
          '${AppStrings.lastModifiedOn} ${note!.lastEdit.year}/'
              '${note!.lastEdit.month}/${note!.lastEdit.day}',
          style: const TextStyle(
              fontSize: AppValues.noteItemDateSize,
              color: Colors.grey
          )
      ),
    );
  }
}