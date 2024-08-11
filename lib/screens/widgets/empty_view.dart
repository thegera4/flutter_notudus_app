import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:notudus/res/strings.dart';
import '../../res/assets.dart';
import '../../res/values.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(AnimationAssets.empty),
        Text(
            AppStrings.noNotes,
            style: GoogleFonts.poppins(fontSize: AppValues.emptyTextSize),
        ),
      ],
    );
  }
}