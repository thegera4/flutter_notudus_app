import 'package:flutter/material.dart';

class CustomNoteInput extends StatelessWidget {
  const CustomNoteInput({
    super.key,
    required this.controller,
    required this.textStyle,
    required this.hintText,
  });
  final TextEditingController controller;
  final TextStyle textStyle;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: textStyle,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(hintText: hintText, border: InputBorder.none,)
    );
  }
}