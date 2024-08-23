import 'package:flutter/material.dart';
import 'package:notudus/res/values.dart';

class AppTextStyles {

  static const noteTitle = TextStyle(
    fontSize: AppValues.noteItemTitleSize,
    fontWeight: FontWeight.bold,
  );

  static TextStyle noteInputStyle(double fontSize, FontWeight fontWeight) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

}

class AppInputStyles {

  static const searchInputBorders = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
    borderRadius: BorderRadius.all(Radius.circular(16.0)),
  );

}