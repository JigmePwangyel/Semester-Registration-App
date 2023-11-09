import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/pages/parents_details.dart';
import 'package:semester_registration_app/provider/registration_provider.dart';
import 'package:semester_registration_app/provider/user_provider.dart';
import '../src/registration_form.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({super.key});

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final TextEditingController studentNameController = TextEditingController();
  final TextEditingController studentNumberController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController scholarshipTypeController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 40, 168, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Personal Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: MyCustomForm(
            formKey: _formKey,
            studentNameController: studentNameController,
            studentNumberController: studentNumberController,
            mobileNumberController: mobileNumberController,
            emailController: emailController,
            scholarshipTypeController: scholarshipTypeController,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    studentNameController.dispose();
    studentNumberController.dispose();
    mobileNumberController.dispose();
    emailController.dispose();
    scholarshipTypeController.dispose();
    super.dispose();
  }
}

class MyCustomForm extends StatefulWidget {
  final TextEditingController studentNameController;
  final TextEditingController studentNumberController;
  final TextEditingController mobileNumberController;
  final TextEditingController emailController;
  final TextEditingController scholarshipTypeController;

  final GlobalKey<FormState> formKey;

  const MyCustomForm({
    super.key,
    required this.studentNameController,
    required this.studentNumberController,
    required this.mobileNumberController,
    required this.emailController,
    required this.scholarshipTypeController,
    required this.formKey,
  });

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    final String username = context.watch<UserProvider>().username;
    fetchAndSetProgramme(context, username);
    //Provider to store details
    StudentRegistrationProvider studentDataProvider =
        Provider.of<StudentRegistrationProvider>(context, listen: false);
    //Provider to store the repeat module details
    return FutureBuilder(
      future: fetchStudentData(username),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final student = snapshot.data;
          return Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 1,
                        width: 50,
                        color: const Color.fromRGBO(50, 57, 65, 1),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 15,
                        ),
                        child: Text(
                          'Registration',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 50,
                        color: const Color.fromRGBO(50, 57, 65, 1),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                const Text('Student Name', style: TextStyle(fontSize: 16)),
                TextFormField(
                  enabled: false,
                  initialValue: student!.studentName,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(213, 216, 222, 1.0)
                              // Change this color to your desired border color
                              ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 8.0),
                    filled: true,
                    fillColor: Color.fromRGBO(233, 236, 241, 1.0),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Student Number', style: TextStyle(fontSize: 16)),
                TextFormField(
                  enabled: false,
                  initialValue: student.stdID.toString(),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(213, 216, 222, 1.0)
                              // Change this color to your desired border color
                              ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 8.0),
                    filled: true,
                    fillColor: Color.fromRGBO(233, 236, 241, 1.0),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Scholarship Type', style: TextStyle(fontSize: 16)),
                TextFormField(
                  enabled: false,
                  initialValue: student.scholarship,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(213, 216, 222, 1.0)
                              // Change this color to your desired border color
                              ),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 1.0, horizontal: 8.0),
                    filled: true,
                    fillColor: Color.fromRGBO(233, 236, 241, 1.0),
                  ),
                ),
                const SizedBox(height: 20),
                buildTextField(
                  label: 'Mobile Number',
                  controller: widget.mobileNumberController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                buildTextField(
                  label: 'Email ID',
                  controller: widget.emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 60),
                Center(
                  child: SizedBox(
                    width: 500,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (widget.formKey.currentState!.validate()) {
                          // Form is valid, handle the data

                          String mobileNumber =
                              widget.mobileNumberController.text;
                          String email = widget.emailController.text;

                          // Storing Data in the Provider
                          studentDataProvider.studentMobileNumber =
                              mobileNumber;
                          studentDataProvider.studentEmail = email;

                          // Navigate to the Parent Details page
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const ParentsDetails();
                              },
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        minimumSize:
                            MaterialStateProperty.all(const Size(500, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(255, 102, 0, 1.0),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        TextFormField(
          controller: controller,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          validator: validator,
          decoration: const InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 1.0, horizontal: 8.0),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
