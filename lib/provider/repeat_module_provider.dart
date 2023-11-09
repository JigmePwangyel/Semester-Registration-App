import 'package:flutter/material.dart';

class RepeatModuleProvider extends ChangeNotifier {
  Map<String, String> _RepeatModule = {};

  Map<String, String> get RepeatModule => _RepeatModule;

  void setData(Map<String, String> data) {
    _RepeatModule = data;
    notifyListeners();
  }
}
