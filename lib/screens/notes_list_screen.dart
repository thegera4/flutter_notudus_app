import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:notudus/screens/widgets/empty_view.dart';
import 'package:notudus/services/local_db.dart';
import '../models/note.dart';
import '../res/strings.dart';
import 'create_note_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

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
      for (var note in notes) {
        log('Note: ${note.toString()}');
      }
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
                return ListView.builder(
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    final note = snapshot.data![index];
                    return ListTile(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>
                                CreateNoteScreen(note: note)
                            )
                        );
                      },
                      title: Text(note.title),
                      subtitle: Text(note.note),
                    );
                  },
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
            MaterialPageRoute(builder: (context) => const CreateNoteScreen(note: null,)),
          );
        },
        tooltip: AppStrings.addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}