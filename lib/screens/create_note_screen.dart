import 'package:flutter/material.dart';
import 'package:notudus/screens/widgets/new_note_form.dart';
import 'package:sqflite/sqflite.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({super.key, required this.database});
  final Database database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: NewNoteForm(database: database),
    );
  }
}