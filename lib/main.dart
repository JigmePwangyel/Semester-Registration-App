import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/pages/MyHomePage.dart';
import 'package:semester_registration_app/provider/StoreRepeatModule.dart';
import 'package:semester_registration_app/provider/form_provider.dart';
import 'package:semester_registration_app/provider/programme_provider.dart';
import 'package:semester_registration_app/provider/registration_provider.dart';
import 'package:semester_registration_app/provider/repeat_module_provider.dart';
import 'package:semester_registration_app/provider/user_provider.dart';
import 'package:semester_registration_app/theme/light_mode.dart';
import 'pages/login.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(
            create: (context) => StudentRegistrationProvider()),
        ChangeNotifierProvider(create: (context) => ProgrammeProvider()),
        ChangeNotifierProvider(create: (context) => FormProvider()),
        ChangeNotifierProvider(create: (context) => RepeatModuleProvider()),
        ChangeNotifierProvider(create: (context) => EnteredModuleProvider()),
      ],
      child: const MyApp(),
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
      home: userProvider.isLoggedIn ? const MyHomePage() : const Login(),
      theme: lightMode,
    );
  }
}
