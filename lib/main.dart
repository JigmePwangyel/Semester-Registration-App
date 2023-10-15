import 'package:flutter/material.dart';
import 'package:semester_registration_app/theme/light_mode.dart';
import 'pages/MyHomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: lightMode,
    );
  }
}
