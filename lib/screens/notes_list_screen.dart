import 'package:flutter/material.dart';
import 'package:notudus/screens/widgets/empty_view.dart';
import 'package:sqflite/sqflite.dart';
import '../res/strings.dart';
import 'create_note_screen.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key, required this.database});
  final Database database;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          children: [
            EmptyView(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder:
                  (context) => CreateNoteScreen(database: database,))
          );
        },
        tooltip: AppStrings.addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}