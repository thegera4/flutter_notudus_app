import 'package:flutter/material.dart';
import '../res/strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: AppStrings.search,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.grid_view_sharp),
            tooltip: AppStrings.addNote,
            onPressed: () {},
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