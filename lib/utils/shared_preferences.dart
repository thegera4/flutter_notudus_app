import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  /// String value to check if the user prefers to view the list of notes
  /// in a list view or a grid view.
  static const String _isListView = 'isListView';

  /// Changes the view type of the list of notes to either a list or a grid view.
  static Future<void> setIsListView(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isListView, value);
  }

  /// Retrieves the view type of the list of notes.
  static Future<bool> getIsListView() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isListView) ?? true;
  }

}