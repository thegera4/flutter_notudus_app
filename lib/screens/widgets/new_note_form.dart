import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notudus/res/values.dart';
import 'package:provider/provider.dart';
import '../../models/note.dart';
import '../../models/provided_data.dart';
import '../../services/local_db.dart';

class NewNoteForm extends StatefulWidget {
  const NewNoteForm({super.key, required this.note});
  final Note? note;

  @override
  State<NewNoteForm> createState() => _NewNoteFormState();
}

class _NewNoteFormState extends State<NewNoteForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final LocalDBService _dbService = LocalDBService();

  @override
  void initState() {
    super.initState();
    Provider.of<ProvidedData>(context, listen: false).addListener(_checkDelete);
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _noteController.text = widget.note!.note;
    }
  }

  void _checkDelete() {
    if (Provider.of<ProvidedData>(context, listen: false).isDeleting) {
      _deleteNote();
    }
  }

  Future<void> _deleteNote() async {
    if (widget.note != null) {
      await _dbService.deleteNote(widget.note!.id!);
      Provider.of<ProvidedData>(context, listen: false).setIsDeleting(false);
      Navigator.of(context).pop();
    }
  }

  Future<void> _updateNote() async {
    // check if the user is trying to delete the note
    /*if(widget.note != null &&
        (Provider.of<ProvidedData>(context, listen: false).isDeleting == true)) {
      return;
    }*/

    // check if the note was not modified
    if (_titleController.text == widget.note!.title &&
        _noteController.text == widget.note!.note) {
      log('Note not modified, not saved');
      return;
    }

    // else, update the note
    final note = Note.withId(
      id: widget.note!.id,
      title: _titleController.text,
      note: _noteController.text,
      lastEdit: DateTime.now(),
    );

    try {
      await _dbService.updateNote(note);
      log('Note updated correctly with id: ${widget.note!.id}');
    } catch (error) {
      log('Error updating note: $error');
    }

  }

  Future<void> _saveNote() async {
    // if the note is not new, run the update method (delete or update)
    if (widget.note != null) {
      await _updateNote();
      return;
    }

    // if the note is new, save it
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

  //TODO: funciona el borrado pero arroja error
  @override
  void dispose() {
    Provider.of<ProvidedData>(context, listen: false).removeListener(_checkDelete);
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