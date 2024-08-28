import 'package:flutter/material.dart';
import 'package:notudus/res/values.dart';
import 'package:notudus/screens/notes_list_screen.dart';
import 'package:notudus/screens/widgets/search_overlay.dart';
import 'package:provider/provider.dart';
import '../models/provided_data.dart';
import '../res/strings.dart';
import '../utils/shared_preferences.dart';

/// Home screen widget that displays the list of notes, appbar icons,
/// and the bottom navigation bar.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// A boolean value to change the appbar icons based on the view type.
  bool isListView = true;
  /// A boolean value to determine if the search overlay is visible or not.
  bool _isSearchOverlayVisible = false;

  @override
  void initState() {
    super.initState();
    _loadViewPreference();
  }

  /// Loads the user's preference from the shared preferences.
  void _loadViewPreference() async {
    isListView = await SharedPreferencesUtil.getIsListView();
    setState(() {});
  }

  /// Toggles the view type between list view and grid view.
  void _toggleView() async {
    setState(() => isListView = !isListView);
    await SharedPreferencesUtil.setIsListView(isListView);
  }

  /// Shows the search overlay by setting the "_isSearchOverlayVisible" to true.
  void _showSearchOverlay() {
    setState(() => _isSearchOverlayVisible = true);
  }

  /// Hides the search overlay by setting the "_isSearchOverlayVisible" to false.
  void _hideSearchOverlay() {
    setState(() =>_isSearchOverlayVisible = false);
  }

  /// Toggles the view if the user is authenticated or not.
  void _toggleAuthentication(ProvidedData providedData) {
    providedData.setIsAuthenticated(!providedData.isAuthenticated);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProvidedData(),
      child: Consumer<ProvidedData>(
        builder: (context, providedData, child) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                AppStrings.notes,
                style: TextStyle(fontSize: AppValues.appbarFontSize),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                      providedData.isAuthenticated ? Icons.lock_open : Icons
                          .lock),
                  tooltip: AppStrings.search,
                  onPressed: () {
                    _toggleAuthentication(providedData);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: AppStrings.search,
                  onPressed: () {
                    !_isSearchOverlayVisible
                        ? _showSearchOverlay()
                        : _hideSearchOverlay();
                  },
                ),
                IconButton(
                  icon: Icon(isListView ? Icons.splitscreen : Icons.grid_view),
                  tooltip: AppStrings.changeView,
                  onPressed: _toggleView,
                ),
              ],
            ),
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
        },
      ),
    );
  }
}