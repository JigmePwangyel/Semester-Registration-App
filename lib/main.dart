import 'package:flutter/material.dart';
import 'package:semester_registration_app/theme/light_mode.dart';
import 'pages/MyHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      theme: lightMode,
    );
  }
}
