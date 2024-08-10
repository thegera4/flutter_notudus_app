import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Text(
          AppStrings.notes,
          style: GoogleFonts.poppins(fontSize: 28),
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
      body: const Placeholder(),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: AppStrings.addNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}