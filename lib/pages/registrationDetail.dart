import 'package:flutter/material.dart';
import 'package:semester_registration_app/provider/user_provider.dart';
import '../models/FetchRegistrationDetailModel.dart';
import '../src/user_detail.dart';
import 'package:provider/provider.dart';

class RegistrationDetails extends StatefulWidget {
  const RegistrationDetails({super.key});

  @override
  State<RegistrationDetails> createState() => _RegistrationDetails();
}

class _RegistrationDetails extends State<RegistrationDetails> {
  String? studentName;
  String? studentNumber;
  String? date_of_birth;
  String? studentMobile;
  String? semesterName;
  String? programme;
  String? year;
  String? semester;
  String? parentName;
  String? parentEmailID;
  String? parentAddress;
  String? parentMobile;

  @override
  Widget build(BuildContext context) {
    final String username = context.watch<UserProvider>().username;

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
          child: FutureBuilder<String>(
            future: getRegistrationDetail(username),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While the Future is still running (loading state)
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                // If there's an error during the Future execution
                return Text('Error: ${snapshot.error}');
              } else {
                //Data Has Been Successfully loaded
                // Parse the data and use it as needed
                final apiResponse = snapshot.data!;
                final studentDetail =
                    parseStudentRegistrationDetail(apiResponse);
                final parentDetail = parseParentDetail(apiResponse);
                final semesterDetail = parseSemesterDetail(apiResponse);

                //Setting the variables
                studentName = studentDetail.studentName;
                studentNumber = studentDetail.stdID;
                date_of_birth = studentDetail.dateOfBirth;
                studentMobile = studentDetail.mobileNumber;
                semesterName = "AS2023";
                programme = semesterDetail.departmentName;
                year = semesterDetail.year;
                semester = semesterDetail.semester;
                parentName = parentDetail.parentName;
                parentEmailID = parentDetail.parentEmail;
                parentAddress = parentDetail.currentAddress;
                parentMobile = parentDetail.parentMobile;
                return Column(
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
                                        '$studentName',
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
                                        '$studentNumber',
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
                                        '$date_of_birth',
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
                                        '$studentMobile',
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
                                        '$semesterName',
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
                                        '$programme',
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
                                        '$year',
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
                                        '$semester',
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
                                        '$parentName',
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
                                        '$parentEmailID',
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
                                        '$parentAddress',
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
                                        '$parentMobile',
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
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
