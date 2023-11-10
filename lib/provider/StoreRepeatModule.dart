import 'package:flutter/material.dart';
import 'package:semester_registration_app/models/RepeatModule.dart';

class EnteredModuleProvider extends ChangeNotifier {
  List<Module> _enteredModules = [];

  List<Module> get enteredModules => _enteredModules;

  void addEnteredModule(Module module) {
    _enteredModules.add(module);
    notifyListeners();
  }
}
