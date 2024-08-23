import 'package:flutter/material.dart';
import 'package:notudus/res/strings.dart';
import 'package:notudus/res/styles.dart';
import 'package:notudus/screens/widgets/notes_list_item.dart';
import '../../models/note.dart';
import '../../services/local_db.dart';

/// A widget that displays a search overlay with a text field
/// to enter the search query. It also displays the search results.
class SearchOverlay extends StatefulWidget {
  const SearchOverlay({super.key, required this.onClose});
  /// A function that is called when the search overlay is closed.
  final Function onClose;

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  /// Controller for the search text field.
  final TextEditingController _searchController = TextEditingController();
  /// A stream that contains the search results.
  Stream<List<Note>>? _searchResultsStream;
  /// An instance of the local database service.
  final LocalDBService dbService = LocalDBService();

  /// Calls the "searchNotes" method from the db service to get all notes that
  /// contain the search query either on the title or the note.
  void _searchNotes(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResultsStream = null;
      } else {
        _searchResultsStream = Stream.fromFuture(dbService.searchNotes(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Future.delayed(const Duration(milliseconds: 300), () {
              widget.onClose();
            });
          },
          child: Container(color: Colors.black.withOpacity(0.95),),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                maxLines: 1,
                controller: _searchController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: ColorSwatch(0xFF424242, {900: Color(0xFF424242),}),
                  hintText: AppStrings.search,
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  enabledBorder: AppInputStyles.searchInputBorders,
                  focusedBorder: AppInputStyles.searchInputBorders,
                ),
                onChanged: _searchNotes,
              ),
              const SizedBox(height: 16.0),
              Flexible(
                child: StreamBuilder<List<Note>>(
                  stream: _searchResultsStream,
                  builder: (context, snapshot) {
                    if (_searchResultsStream == null) {
                      return const SizedBox.shrink();
                    } else if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return const Text(AppStrings.errorLoading);
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text(AppStrings.noNotes);
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final note = snapshot.data![index];
                          return NotesListItem(
                            note: note,
                            onNoteDeleted: widget.onClose,
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}