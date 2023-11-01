import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/pages/MyHomePage.dart';
import 'package:semester_registration_app/provider/user_provider.dart';
import 'package:semester_registration_app/theme/light_mode.dart';
import 'pages/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Provider.of to get the UserProvider
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userProvider.isLoggedIn ? MyHomePage() : Login(),
      theme: lightMode,
    );
  }
}
