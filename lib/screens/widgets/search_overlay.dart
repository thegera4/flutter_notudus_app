import 'package:flutter/material.dart';
import 'package:notudus/res/strings.dart';
import 'package:notudus/screens/widgets/notes_list_item.dart';
import '../../models/note.dart';
import '../../services/local_db.dart';

//TODO: fix bug when we search something and then delete the note (UI doesn't update)
//it should close the overlay (try with provider to track the open state)

class SearchOverlay extends StatefulWidget {
  const SearchOverlay({super.key, required this.onClose});
  final Function onClose;

  @override
  State<SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<SearchOverlay> {
  final TextEditingController _searchController = TextEditingController();
  Stream<List<Note>>? _searchResultsStream;
  final LocalDBService dbService = LocalDBService();

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
          onTap: () => widget.onClose(),
          child: Container(
            color: Colors.black.withOpacity(0.95),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                maxLines: 1,
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: AppStrings.search,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                ),
                onChanged: _searchNotes,
              ),
              const SizedBox(height: 16.0),
              StreamBuilder<List<Note>>(
                stream: _searchResultsStream,
                builder: (context, snapshot) {
                  if (_searchResultsStream == null) {
                    return const Text(AppStrings.searchSomething);
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
                        return NotesListItem(note: note);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}