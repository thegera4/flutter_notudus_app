import 'package:flutter/material.dart';
import 'package:notudus/res/styles.dart';
import 'package:notudus/res/values.dart';
import 'package:notudus/screens/widgets/custom_note_input.dart';
import '../../models/note.dart';
import '../../res/strings.dart';
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
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _noteController.text = widget.note!.note;
    }
  }

  /// Calls the "updateNote" method from the db service to update a note.
  /// Throws an exception if the note is not updated.
  Future<void> _updateNote() async {
    // check if the note was not modified (no need to update)
    if (_titleController.text == widget.note!.title &&
        _noteController.text == widget.note!.note) {
      return;
    }

    // else, update the note
    final note = Note.withId(
      id: widget.note!.id,
      title: _titleController.text,
      note: _noteController.text,
      lastEdit: DateTime.now(),
      isLocked: widget.note!.isLocked,
    );

    try {
      await _dbService.updateNote(note);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.errorUpdating)),
      );
    }

  }

  /// Calls the "addNote" method from the db service to save a note.
  /// Throws an exception if the note is not saved.
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
        isLocked: false,
      );
      try {
        await _dbService.addNote(note);
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.errorSaving)),
        );
      }
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
          padding: const EdgeInsets.only(
              left: AppValues.bigPadding,
              right: AppValues.bigPadding
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomNoteInput(
                        controller: _titleController,
                        textStyle: AppTextStyles.noteInputStyle(
                            AppValues.noteTitleSize,
                            FontWeight.bold
                        ),
                        hintText: AppStrings.hintTitle
                      ),
                      CustomNoteInput(
                          controller: _noteController,
                          textStyle: AppTextStyles.noteInputStyle(
                              AppValues.noteTextSize,
                              FontWeight.normal
                          ),
                          hintText: AppStrings.hintText
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}