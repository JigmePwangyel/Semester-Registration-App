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

    const colorScheme = ColorScheme(
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
        title: const Text("Your Registration Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder<String>(
            future: getRegistrationDetail(username),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // While the Future is still running (loading state)
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                // If there's an error during the Future execution
                return Text('Error: ${snapshot.error}');
              } else {
                //Data Has Been Successfully loaded
                // Parse the data and use it as needed
                try {
                  final apiResponse = snapshot.data!;
                  final studentDetail =
                      parseStudentRegistrationDetail(apiResponse);
                  final parentDetail = parseParentDetail(apiResponse);
                  final semesterDetail = parseSemesterDetail(apiResponse);

                  // Continue with the rest of your UI or business logic
                  print(studentDetail);
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
                        color: colorScheme.surface,
                        // Set the border radius.
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5.0,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Container(
                                alignment: Alignment.center,
                                child: const Text(
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
                                        const Text(
                                          "Name:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '$studentName',
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const Text(
                                          "Student Number:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '$studentNumber',
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const Text(
                                          "Date of Birth:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '$date_of_birth',
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const Text(
                                          "Mobile Number:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '$studentMobile',
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                child: const Text(
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
                                        const Text(
                                          "Semester Name:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '$semesterName',
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const Text(
                                          "Programme:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '$programme',
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const Text(
                                          "Year:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '$year',
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const Text(
                                          "Semester:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '$semester',
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
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
                                child: const Text(
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
                                        const Text(
                                          "Parent Name:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '$parentName',
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const Text(
                                          "Email ID:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '$parentEmailID',
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const Text(
                                          "Current Address:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '$parentAddress',
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        const Text(
                                          "Mobile Number:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          '$parentMobile',
                                          style: const TextStyle(fontSize: 14),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                } catch (e) {
                  // Handle the exception thrown during parsing
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.warning,
                          size: 80.0,
                          color: Colors.orange,
                        ),
                        SizedBox(height: 16.0),
                        Text(
                          'Please register to see your registration details.',
                          style: TextStyle(fontSize: 18.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
