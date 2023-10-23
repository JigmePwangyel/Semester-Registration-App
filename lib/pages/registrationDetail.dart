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
      body: Padding(
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
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: Jigme Phuntsho Wangyel",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Student Number: 02210200",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Date of Birth: 5/11/2003",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Mobile Number:17809910",
                            style: TextStyle(
                              fontSize: 16,
                            ),
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
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
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
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Semester Name: AS2023",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Your Programme: IT",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Year: Third",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Semester:5",
                            style: TextStyle(
                              fontSize: 16,
                            ),
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
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Parent's Details",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name: Jigme Phuntsho Wangyel",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Email id: 02210200.cst@rub.edu.bt",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Current Address: Thimphu",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Mobile Number:17809910",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
