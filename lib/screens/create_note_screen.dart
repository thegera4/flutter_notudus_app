import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:notudus/models/note.dart';
import 'package:notudus/models/provided_data.dart';
import 'package:notudus/res/assets.dart';
import 'package:notudus/res/strings.dart';
import 'package:notudus/screens/widgets/new_note_form.dart';
import 'package:notudus/services/local_db.dart';
import 'package:provider/provider.dart';

class CreateNoteScreen extends StatelessWidget {
  const CreateNoteScreen({super.key,required this.note,required this.dbService});
  final Note? note;
  final LocalDBService? dbService;

  @override
  Widget build(BuildContext context) {
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
                    style: GoogleFonts.poppins(fontSize: 24),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          child: Lottie.asset(
                              height: 80,
                              width: 80,
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
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        log('Before isDeleting: ${Provider.of<ProvidedData>(context, listen: false).isDeleting}');
                          Provider.of<ProvidedData>(context, listen: false)
                              .setIsDeleting(true);
                        log('After isDeleting: ${Provider.of<ProvidedData>(context, listen: false).isDeleting}');
                          Navigator.of(context).pop();
                      },
                      child: const Text(
                          'Delete',
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