import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/pages/MyHomePage.dart';
import 'package:semester_registration_app/provider/user_provider.dart';
import 'package:semester_registration_app/src/user_detail.dart';

class password extends StatefulWidget {
  const password({super.key});

  @override
  State<password> createState() => _passwordState();
}

class _passwordState extends State<password> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String username = context.watch<UserProvider>().username;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Current Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your current password';
                  }
                  // Add any additional validation as needed
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'New Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a new password';
                  }
                  // Add any additional validation as needed
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  } else if (value != _newPasswordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Form is valid, perform password change logic here
                    // You can access the entered values using _currentPasswordController.text,
                    // _newPasswordController.text, and _confirmPasswordController.text
                    // For example, you might call a function like changePassword() here.

                    bool changed = await changePassword(
                        username, _newPasswordController.text);
                    if (changed) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text('Password Changed!'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const MyHomePage();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          });
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text('Password Not changed !'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const MyHomePage();
                                        },
                                      ),
                                    );
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          });
                    }
                  }
                },
                child: Text('Change Password'),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(const Size(500, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(255, 102, 0, 1.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
