import 'package:flutter/foundation.dart';

class RepeaterCheckProvider extends ChangeNotifier {
  String _result = '';

  String get result => _result;

  void setResult(String value) {
    _result = value;
    notifyListeners();
  }
}
