import 'package:flutter/material.dart';
import 'package:notudus/models/note.dart';
import 'package:notudus/screens/widgets/new_note_form.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({super.key, required this.note});
  final Note? note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NewNoteForm(note: note),
    );
  }
}