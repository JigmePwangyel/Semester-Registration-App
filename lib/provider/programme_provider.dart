import 'package:flutter/material.dart';

class ProgrammeProvider extends ChangeNotifier {
  String _programmeName = '';

  String get programmeName => _programmeName;

  void setProgrammeName(String name) {
    _programmeName = name;
    notifyListeners();
  }
}
