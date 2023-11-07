import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  String _formType = '';

  String get formType => _formType;

  void setFormType(String name) {
    _formType = name;
    notifyListeners();
  }

  String getFormType() {
    return _formType;
  }
}
