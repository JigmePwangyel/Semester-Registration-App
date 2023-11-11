import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/pages/HomeTab.dart';
import 'package:semester_registration_app/pages/MyHomePage.dart';
import 'package:semester_registration_app/pages/payment_section.dart';
import 'package:semester_registration_app/pages/repeat_module.dart';
import 'package:semester_registration_app/provider/RepeaterCheckProvider.dart';
import 'package:semester_registration_app/provider/form_provider.dart';
import 'package:semester_registration_app/provider/programme_provider.dart';
import 'package:semester_registration_app/provider/registration_provider.dart';
import 'package:semester_registration_app/provider/user_provider.dart';
import '../src/registration_form.dart';

const List<String> years = [
  'First year',
  'Second year',
  'Third year',
  'Fourth year',
  'Fifth year',
];

const List<String> semesters = [
  '2nd',
  '3rd',
  '4th',
  '5th',
  '6th',
  '7th',
  '8th',
  '9th',
  '10th',
];

class SemesterDetails extends StatefulWidget {
  const SemesterDetails({super.key});

  @override
  _SemesterDetailsState createState() => _SemesterDetailsState();
}

class _SemesterDetailsState extends State<SemesterDetails> {
  final TextEditingController programController = TextEditingController();
  String selectedYear = years[0];
  String selectedSemester = semesters[0];

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
        title: const Text('Semester Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: MyCustomForm(
            formKey: _formKey,
            programController: programController,
            selectedYear: selectedYear,
            selectedSemester: selectedSemester,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    programController.dispose();
    super.dispose();
  }
}

class MyCustomForm extends StatefulWidget {
  final TextEditingController programController;
  String selectedYear;
  String selectedSemester;

  final GlobalKey<FormState> formKey;

  MyCustomForm({
    super.key,
    required this.programController,
    required this.selectedYear,
    required this.selectedSemester,
    required this.formKey,
  });

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    //Provider to store details
    StudentRegistrationProvider studentDataProvider =
        Provider.of<StudentRegistrationProvider>(context, listen: false);
    final String username = context.watch<UserProvider>().username;
    final String formType = context.watch<FormProvider>().formType;
    bool ButtonCondition = true;
    if (formType == "regular") {
      ButtonCondition = false;
    }

    final String programmeName =
        context.watch<ProgrammeProvider>().programmeName;

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
                  color: Colors.black,
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
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          const Text('Programme', style: TextStyle(fontSize: 16)),
          TextFormField(
            enabled: false,
            initialValue: programmeName,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(213, 216, 222, 1.0)
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
          buildDropdownMenu(
            label: 'Year',
            items: years,
            selectedItem: widget.selectedYear,
            onSelected: (value) {
              print('onSelected callback triggered with value: $value');
              setState(() {
                widget.selectedYear = value!; // Update the selectedYear
                studentDataProvider.year =
                    value; // Set the year in the provider
              });
            },
          ),
          const SizedBox(height: 20),
          buildDropdownMenu(
            label: 'Semester',
            items: semesters,
            selectedItem: widget.selectedSemester,
            onSelected: (value) {
              widget.selectedSemester = value!;
              studentDataProvider.semester = value;
            },
          ),
          const SizedBox(height: 60),
          Center(
            child: SizedBox(
              width: 500,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  BuildContext currentContext = context;
                  if (widget.formKey.currentState!.validate()) {
                    // String year = widget.selectedYear;
                    // String semester = widget.selectedSemester;

                    // Entering into the provider
                    // studentDataProvider.year = year;
                    // studentDataProvider.semester = semester;

                    if (formType == "repeater") {
                      await checkRepeaterStatus(username, context);
                      Navigator.of(currentContext).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const RepeatModule();
                          },
                        ),
                      );
                    } else if (formType == "SelfFunding") {
                      Navigator.of(currentContext).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const PaymentSection();
                          },
                        ),
                      );
                    } else if (formType == "regular") {
                      //Handle Registration
                      String studentMobileNumber =
                          studentDataProvider.studentMobileNumber;
                      String studentEmail = studentDataProvider.studentEmail;
                      String semester = studentDataProvider.semester;
                      String year = studentDataProvider.year;
                      String parentName = studentDataProvider.parentName;
                      String parentMobileNumber =
                          studentDataProvider.parentMobileNumber;
                      String parentEmailId = studentDataProvider.parentEmailId;
                      String parentCurrentAddress =
                          studentDataProvider.parentCurrentAddress;
                      int statusode = await uploadRegularStudentData(
                        username,
                        studentMobileNumber,
                        studentEmail,
                        semester,
                        year,
                        parentName,
                        parentEmailId,
                        parentCurrentAddress,
                        parentMobileNumber,
                      );
                      // Show success dialog

                      print(statusode);
                      if (statusode == 200) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Thank You'),
                                content: Text(
                                    'You have been successfully Registered!'),
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
                        print("Error");
                      }
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(255, 102, 0, 1.0),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: Text(
                  ButtonCondition ? "Next" : "Submit",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ),
        ],
      ),
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
          style: const TextStyle(
              fontSize: 15, color: Color.fromRGBO(0, 40, 168, 1)),
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

  Widget buildDropdownMenu({
    required String label,
    required List<String> items,
    required String selectedItem,
    required void Function(String?)? onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14)),
        DropdownMenu<String>(
          initialSelection: selectedItem,
          onSelected: onSelected,
          width: 310,
          dropdownMenuEntries: items.map<DropdownMenuEntry<String>>((value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
      ],
    );
  }
}
