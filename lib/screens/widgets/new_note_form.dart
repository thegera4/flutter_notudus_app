import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notudus/models/note.dart';
import 'package:notudus/res/values.dart';
import 'package:notudus/services/local_db.dart';
import 'package:sqflite/sqflite.dart';

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({super.key, required this.database});
  final Database database;

  @override
  State<NewNoteForm> createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() async {
    log('Title: ${_titleController.text}');
    log('Note: ${_noteController.text}');
    var newNote = Note(
        id: 0,
        title: _titleController.text,
        note: _noteController.text,
        lastEdit: DateTime.now()
    );
    var addedNote = await LocalDBService.addNote(newNote, widget.database);
    if (addedNote != "Error") {
      var notes = await LocalDBService.getNotes(widget.database);
      log('Notes: $notes');
    }

    _titleController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: AppValues.bigPadding, right: AppValues.bigPadding),
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                style: GoogleFonts.poppins(fontSize: AppValues.noteTitleSize),
                decoration: const InputDecoration(
                  hintText: 'Note title',
                  border: InputBorder.none,
                ),
              ),
              TextFormField(
                controller: _noteController,
                style: GoogleFonts.poppins(fontSize: AppValues.noteTextSize),
                decoration: const InputDecoration(
                  hintText: 'Write note',
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}