import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notudus/res/strings.dart';
import '../../res/assets.dart';
import '../../res/values.dart';

class EmptyView extends StatefulWidget {
  const EmptyView({super.key});

  @override
  State<EmptyView> createState() => _EmptyViewState();
}

class _EmptyViewState extends State<EmptyView> {
  bool _isAnimationLoaded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset(
          AnimationAssets.empty,
          repeat: false,
          onLoaded: (composition) {setState(() => _isAnimationLoaded = true);},
        ),
        Visibility(
          visible: _isAnimationLoaded,
          child: const Text(
            AppStrings.noNotes,
            style: TextStyle(fontSize: AppValues.emptyTextSize),
          ),
        ),
      ],
    );
  }
}