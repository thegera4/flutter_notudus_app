import 'package:flutter/material.dart';
import 'package:notudus/res/values.dart';
import 'package:notudus/screens/notes_list_screen.dart';
import '../res/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool isListView = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppStrings.notes,
          style: TextStyle(fontSize: AppValues.appbarFontSize),
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
      body: NotesListScreen(isListView: isListView),
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