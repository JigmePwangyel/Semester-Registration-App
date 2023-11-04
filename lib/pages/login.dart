import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/pages/MyHomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../src/auth_service.dart';
import '../provider/user_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late Color mycolor;
  late Size mediaSize;

  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    mycolor = Theme.of(context).primaryColor;

    //Provider for user State
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Containers for Images
            Container(
              constraints: const BoxConstraints(
                  maxHeight: 200, maxWidth: double.infinity),
              decoration: BoxDecoration(
                color: mycolor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.zero,
                  topRight: Radius.zero,
                  bottomLeft: Radius.elliptical(700, 400),
                  bottomRight: Radius.elliptical(800, 400),
                ),
                image: DecorationImage(
                  image: const AssetImage('assets/basketball_Login.jpeg'),
                  fit: BoxFit.fitWidth,
                  colorFilter: ColorFilter.mode(
                      mycolor.withOpacity(0.4), BlendMode.dstATop),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 30,
                left: 30,
                right: 30,
              ),
              child: Column(
                children: [
                  // Setting The Text
                  const Text(
                    'Login',
                    style: TextStyle(
                      color: Color(0xFF0028A8),
                      fontSize: 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Email Address
                  TextField(
                    onChanged: (value) {
                      username = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset('assets/email.svg'),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  // Password
                  TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset('assets/password.svg'),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10),
                        child: SvgPicture.asset('assets/password_hide.svg'),
                      ),
                    ),
                  ),

                  const SizedBox(height: 50),

                  //Login Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xff0028a8),
                            Color(0xff2a54d5),
                            Color(0xff0028a8),
                          ],
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          await loginUser(context, username, password);
                          print("isLoggedIn: ${userProvider.isLoggedIn}");
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          if (userProvider.isLoggedIn) {
                            userProvider.setUserName(username);
                            prefs.setString('username', username);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MyHomePage(),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                                msg: "Invalid Login and Password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors
                              .transparent, //Make the button background transparent
                          shadowColor: Colors.transparent, //Remove the shadow
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
