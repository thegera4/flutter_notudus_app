import 'package:flutter/material.dart';
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
        const Text(
          AppStrings.noNotes,
          style: TextStyle(fontSize: AppValues.emptyTextSize),
        ),
      ],
    );
  }
}