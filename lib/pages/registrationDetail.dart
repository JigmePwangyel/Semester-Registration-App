import 'package:flutter/material.dart';

class RegistrationDetails extends StatefulWidget {
  const RegistrationDetails({super.key});

  @override
  State<RegistrationDetails> createState() => _RegistrationDetails();
}

class _RegistrationDetails extends State<RegistrationDetails> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = const ColorScheme(
      primary: Colors.blue,
      secondary: Colors.teal,
      background: Colors.white,
      surface: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.black,
      onSurface: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Registration Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Card(
                // Set the color scheme.
                color: colorScheme.surface,
                // Set the border radius.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5.0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15, bottom: 15),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Your Details",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 10, bottom: 10, right: 30),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Name:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'John Doe',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Student Number:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '02210200',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Date of Birth:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '5/11/2023',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Mobile Number:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '17809910',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Card(
                // Set the color scheme.
                color: colorScheme.surface,
                // Set the border radius.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5.0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Semester Detail",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 10, bottom: 10, right: 40),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Semester Name:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'AS2023',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Programme:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'IT',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Year:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'Third',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Semester:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '5',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Card(
                // Set the color scheme.
                color: colorScheme.surface,
                // Set the border radius.
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 5.0,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 15,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Parents Detail",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 10, bottom: 10, right: 40),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Parent Name:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'Jigme Phuntsho Wangyel',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Email ID:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '02210200.cst@rub.edu.bt',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Current Address:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  'Thimphu',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text(
                                  "Mobile Number:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  '1789201',
                                  style: TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
