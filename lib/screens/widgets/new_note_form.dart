import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notudus/res/values.dart';
import '../../models/note.dart';
import '../../services/local_db.dart';

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({super.key});

  @override
  State<NewNoteForm> createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final LocalDBService _dbService = LocalDBService();

  Future<void> _saveNote() async {
    if (_titleController.text.isNotEmpty || _noteController.text.isNotEmpty) {
      final note = Note(
        title: _titleController.text,
        note: _noteController.text,
        lastEdit: DateTime.now(),
      );
      try {
        final id = await _dbService.addNote(note);
        log('Note saved correctly with id: $id');
        //TODO: add a snackbar to show the user that the note was saved
      } catch (error) {
        log('Error saving note: $error');
      }
    } else {
      log('Empty note, not saved');
      //TODO: add a snackbar to show the user that the note was not saved
    }
  }

  @override
  void dispose() {
    _saveNote();
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