import 'package:flutter/material.dart';
import 'package:notudus/screens/widgets/empty_view.dart';
import 'package:notudus/screens/widgets/notes_grid.dart';
import 'package:notudus/screens/widgets/notes_list.dart';
import 'package:notudus/services/local_db.dart';
import '../models/note.dart';
import '../res/strings.dart';
import 'create_note_screen.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key, required this.isListView, this.searchQuery = ''});
  final bool isListView;
  final String searchQuery;

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final LocalDBService dbService = LocalDBService();
  Stream<List<Note>>? notesStream;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  /// Calls the "listenAllNotes" method from the db service to get all notes.
  /// Returns a list of notes if successful, or an empty list if not.
  void _loadNotes() async {
    if (widget.searchQuery.isEmpty || widget.searchQuery == '') {
      notesStream = dbService.listenAllNotes();
    } else {
      notesStream = Stream.fromFuture(dbService.searchNotes(widget.searchQuery));
    }
    setState(() {});
  }

  @override
  void didUpdateWidget(NotesListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.searchQuery != widget.searchQuery) {
      _loadNotes(); // Reload notes when the search query changes
    }
  }

  //TODO: fix the bug when we search something and then delete the note (UI doesn't update)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async { _loadNotes(); },
        child: StreamBuilder<List<Note>>(
              stream: notesStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text(AppStrings.errorLoading));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: EmptyView());
                } else {
                  return AnimatedSwitcher(
                    transitionBuilder: (child, animation) =>
                        SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(animation), child: child
                        ),
                    duration: const Duration(milliseconds: 300),
                    child: widget.isListView ?
                    NotesList(snapshot: snapshot) :
                    NotesGrid(snapshot: snapshot),
                  );
                }
              },
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>
                const CreateNoteScreen(note: null)),
          );
        },
        tooltip: AppStrings.addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}