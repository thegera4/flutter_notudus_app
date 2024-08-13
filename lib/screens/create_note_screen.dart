import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:notudus/models/note.dart';
import 'package:notudus/models/provided_data.dart';
import 'package:notudus/res/assets.dart';
import 'package:notudus/res/strings.dart';
import 'package:notudus/res/values.dart';
import 'package:notudus/screens/widgets/new_note_form.dart';
import 'package:notudus/services/local_db.dart';
import 'package:provider/provider.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({super.key,required this.note});
  final Note? note;

  /// Calls the "deleteNote" method from the db service to delete a note,
  /// and navigates to the notes list screen when done.
  /// Throws an exception if the note is not deleted.
  Future<void> _deleteNote(Note note, context, dbService) async {
    try {
      if (note.id != null && dbService != null) {
        await dbService?.deleteNote(note.id!);
      }
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } catch (error) {
      throw Exception(AppStrings.errorDeleting + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    final LocalDBService dbService = LocalDBService();

    return Scaffold(
      appBar: AppBar(
        actions: [
          note != null ?
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  backgroundColor: Colors.grey[900],
                  title: Text(
                    AppStrings.deleteAlertTitle,
                    style: GoogleFonts.poppins(
                        fontSize: AppValues.alertTitleSize
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          child: Lottie.asset(
                              height: AppValues.deleteAnimationHeight,
                              width: AppValues.deleteAnimationWidth,
                              AnimationAssets.delete,
                              fit: BoxFit.cover
                          )
                      ),
                      const Text(AppStrings.deleteAlertBody),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(AppStrings.cancel),
                    ),
                    TextButton(
                      onPressed: () {
                          Provider.of<ProvidedData>(context, listen: false)
                              .setIsDeleting(true);
                        _deleteNote(note!, context, dbService).then((value) {
                          Provider.of<ProvidedData>(context, listen: false)
                              .setIsDeleting(false);
                        });
                      },
                      child: const Text(
                          AppStrings.delete,
                          style: TextStyle(color: Colors.red)
                      ),
                    ),
                  ],
                );
              });
            },
          ) :
          const SizedBox(),
        ],
      ),
      body: NewNoteForm(note: note),
    );
  }
}