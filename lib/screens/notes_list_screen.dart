import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:notudus/screens/widgets/empty_view.dart';
import 'package:notudus/screens/widgets/notes_grid.dart';
import 'package:notudus/screens/widgets/notes_list.dart';
import 'package:notudus/services/local_db.dart';
import '../models/note.dart';
import '../res/strings.dart';
import 'create_note_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key, required this.isListView});
  final bool isListView;

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final LocalDBService dbService = LocalDBService();
  late Future<List<Note>> notesListFuture;

  @override
  void initState() {
    super.initState();
    notesListFuture  = _loadNotes();
  }

  Future<List<Note>> _loadNotes() async {
    try {
      final notes = await dbService.getNotes();
      return notes;
    } catch (error) {
      log('Error getting notes: $error');
      return <Note>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Note>>(
        future: notesListFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading notes'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const EmptyView();
          } else {
            return StreamBuilder<List<Note>>(
              stream: dbService.listenAllNotes(),
              builder: (context, snapshot) {
                return AnimatedSwitcher(
                  transitionBuilder: (child, animation) =>
                      SlideTransition(position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation), child: child),
                  duration: const Duration(milliseconds: 300),
                  child: widget.isListView
                      ? NotesList(snapshot: snapshot)
                      : NotesGrid(snapshot: snapshot),
                );
              }
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                CreateNoteScreen(note: null, dbService: dbService)),
          );
        },
        tooltip: AppStrings.addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}