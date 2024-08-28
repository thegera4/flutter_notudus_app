import 'package:flutter/foundation.dart';

/// This class is used to provide data to the widgets with the Provider package
class ProvidedData extends ChangeNotifier {
  /// This property is used to know if the note is being deleted
  bool _isDeleting = false;
  /// This property is used to know if the user is authenticated
  bool _isAuthenticated = false;

  /// This method is used to get the value of the isDeleting property
  bool get isDeleting => _isDeleting;

  /// This method is used to set the value of the isDeleting property
  void setIsDeleting(bool value) {
    _isDeleting = value;
    notifyListeners();
  }

  /// This method is used to get the value of the isAuthenticated property
  bool get isAuthenticated => _isAuthenticated;

  /// This method is used to set the value of the isAuthenticated property
  void setIsAuthenticated(bool value) {
    _isAuthenticated = value;
    notifyListeners();
  }

}