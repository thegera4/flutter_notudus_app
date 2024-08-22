import 'package:flutter/material.dart';
import 'package:notudus/res/values.dart';
import 'package:notudus/screens/notes_list_screen.dart';
import 'package:notudus/screens/widgets/search_overlay.dart';
import '../res/strings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

//TODO: implement shared preferences to save the view type

class _HomeScreenState extends State<HomeScreen> {
  bool isListView = true;
  bool _isSearchOverlayVisible = false;
  //final TextEditingController _searchController = TextEditingController();

  /// Calls the "searchNotes" method from the db service to get all notes that
  /// contain the search query either on the title or the note.
  /// Returns a list of notes if successful, or an empty list if not.
  /// Displays a dialog with a text field to enter the search query.
  /// If the search query is empty, it will not perform the search.
  /// If the search query is not empty, it will call the "searchNotes" method
  /// from the db service to get all notes that contain the search query.
  /*void showSearchDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(AppStrings.search),
            content: TextField(
              controller: _searchController,
              decoration: const InputDecoration(hintText: AppStrings.search),
              onSubmitted: (query) {
                setState(() {
                  //_searchController.text = query;
                });
                Navigator.of(context).pop();
                },
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(AppStrings.cancel),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    //_searchController.text = _searchController.text;
                  });
                  Navigator.of(context).pop();
                },
                child: const Text(AppStrings.search),
              ),
            ],
          );
    });
  }*/

  void _showSearchOverlay() {
    setState(() {
      _isSearchOverlayVisible = true;
    });
  }

  void _hideSearchOverlay() {
    setState(() {
      _isSearchOverlayVisible = false;
    });
  }

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
            onPressed: () {
              //showSearchDialog(context);
              !_isSearchOverlayVisible ?
              _showSearchOverlay() :
              _hideSearchOverlay();
            },
          ),
          IconButton(
            icon: Icon(isListView ? Icons.splitscreen : Icons.grid_view ),
            tooltip: AppStrings.changeView,
            onPressed: () => setState(() => isListView = !isListView),
          ),
        ],
      ),
      //body: NotesListScreen(isListView: isListView, searchQuery: _searchController.text),
      body: Stack(
        children: [
          NotesListScreen(isListView: isListView, searchQuery: ''),
          if (_isSearchOverlayVisible)
            SearchOverlay(onClose: _hideSearchOverlay),
        ],
      ),
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