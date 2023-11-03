import 'package:flutter/material.dart';
import 'package:semester_registration_app/pages/parents_details.dart';

const List<String> hostelType = ["Dayscholar", "Boarder"];

void main() {
  runApp(MaterialApp(
    home: PersonalDetails(),
  ));
}

class PersonalDetails extends StatefulWidget {
  PersonalDetails({Key? key}) : super(key: key);

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
  String selectedHostelType = hostelType[0];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 40, 168, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Personal Details'),
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
            selectedHostelType: selectedHostelType,
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
  String selectedHostelType;

  final GlobalKey<FormState> formKey;

  MyCustomForm({
    required this.studentNameController,
    required this.studentNumberController,
    required this.mobileNumberController,
    required this.emailController,
    required this.scholarshipTypeController,
    required this.selectedHostelType,
    required this.formKey,
  });

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
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
          SizedBox(height: 50),
          buildTextField(
            label: 'Student Name',
            controller: widget.studentNameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          buildTextField(
            label: 'Student Number',
            controller: widget.studentNumberController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your student number';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 20),
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
          SizedBox(height: 20),
          buildTextField(
            label: 'Scholarship Type',
            controller: widget.scholarshipTypeController,
          ),
          SizedBox(height: 20),
          buildDropdownMenu(
            label: 'Hostel Type',
            items: hostelType,
            selectedItem: widget.selectedHostelType,
            onSelected: (value) {
              setState(() {
                widget.selectedHostelType = value;
              });
            },
          ),
          SizedBox(height: 60),
          Center(
            child: Container(
              width: 500,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    // Form is valid, handle the data
                    String studentName = widget.studentNameController.text;
                    String studentNumber = widget.studentNumberController.text;
                    String mobileNumber = widget.mobileNumberController.text;
                    String email = widget.emailController.text;
                    String scholarshipType =
                        widget.scholarshipTypeController.text;
                    String hostelType = widget.selectedHostelType;

                    // Handle the data as needed
                    print('Student Name: $studentName');
                    print('Student Number: $studentNumber');
                    print('Mobile Number: $mobileNumber');
                    print('Email: $email');
                    print('Scholarship Type: $scholarshipType');
                    print('Hostel Type: $hostelType');

                    // Navigate to the Parent Details page
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return ParentsDetails();
                        },
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(500, 50)),
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

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        TextFormField(
          controller: controller,
          style: TextStyle(fontSize: 15, color: Color.fromRGBO(0, 40, 168, 1)),
          validator: validator,
          decoration: InputDecoration(
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
    required Function(String) onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14)),
        DropdownMenu<String>(
          initialSelection: selectedItem,
          onSelected: (String? value) {
            setState(() {
              selectedItem = value!;
            });
          },
          width: 360,
          dropdownMenuEntries: items.map<DropdownMenuEntry<String>>((value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
      ],
    );
  }
}
