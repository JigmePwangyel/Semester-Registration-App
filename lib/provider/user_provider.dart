import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _username = "";

  String get username => _username;
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }

  void setUserName(String username) {
    _username = username;
    print("The provider username is $_username");
    notifyListeners(); // Notify listeners when the data changes
  }
}
