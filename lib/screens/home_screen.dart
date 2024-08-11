import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notudus/res/values.dart';
import 'package:notudus/screens/notes_list_screen.dart';
import 'package:sqflite/sqflite.dart';
import '../res/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.database});
  final Database database;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isListView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.notes,
          style: GoogleFonts.poppins(fontSize: AppValues.appbarFontSize),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: AppStrings.search,
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(isListView ? Icons.splitscreen : Icons.grid_view ),
            tooltip: AppStrings.changeView,
            onPressed: () => setState(() => isListView = !isListView),
          ),
        ],
      ),
      body: NotesListScreen(database: widget.database),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: AppStrings.notes,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: AppStrings.todos,
          ),
        ],
      ),
    );
  }
}