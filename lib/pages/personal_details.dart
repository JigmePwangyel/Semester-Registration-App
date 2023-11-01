import 'package:flutter/material.dart';
import 'package:semester_registration_app/pages/parents_details.dart';

const List<String> hostelType = [
  "Hostel A",
  "Hostel B",
  "Hostel C",
  "Hostel D",
  "Hostel E",
  "Hostel F",
  "RK",
  "NK"
];

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  final TextEditingController studentNameController = TextEditingController();
  final TextEditingController studentNumberController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController scholarshipTypeController =
      TextEditingController(); // Updated
  String selectedHostelType = hostelType[0];

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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: MyCustomForm(
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
  final TextEditingController scholarshipTypeController; // Updated
  String selectedHostelType; // Updated

  MyCustomForm({super.key, 
    required this.studentNameController,
    required this.studentNumberController,
    required this.mobileNumberController,
    required this.emailController,
    required this.scholarshipTypeController, // Updated
    required this.selectedHostelType, // Updated
  });

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        buildTextField(
          label: 'Student Name',
          controller: widget.studentNameController,
        ),
        const SizedBox(height: 20),
        buildTextField(
          label: 'Student Number',
          controller: widget.studentNumberController,
        ),
        const SizedBox(height: 20),
        buildTextField(
          label: 'Mobile Number',
          controller: widget.mobileNumberController,
        ),
        const SizedBox(height: 20),
        buildTextField(
          label: 'Email ID',
          controller: widget.emailController,
        ),
        const SizedBox(height: 20),
        buildTextField(
          label: 'Scholarship Type',
          controller: widget.scholarshipTypeController,
        ),
        const SizedBox(height: 20),
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
        const SizedBox(height: 60),
        Center(
          child: SizedBox(
            width: 105,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                String studentName = widget.studentNameController.text;
                String studentNumber = widget.studentNumberController.text;
                String mobileNumber = widget.mobileNumberController.text;
                String email = widget.emailController.text;
                String scholarshipType =
                    widget.scholarshipTypeController.text; // Updated
                String hostelType = widget.selectedHostelType; // Updated

                // Handle the data as needed
                print('Student Name: $studentName');
                print('Student Number: $studentNumber');
                print('Mobile Number: $mobileNumber');
                print('Email: $email');
                print('Scholarship Type: $scholarshipType'); // Updated
                print('Hostel Type: $hostelType'); // Updated

                // Navigate to the Parent Details page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return const ParentsDetails();
                    },
                  ),
                );
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(255, 102, 0, 1.0),
                  ), // Set the background color

                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5), // Adjust the border radius as needed
                    ),
                  )),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        TextField(
          controller: controller,
          decoration: const InputDecoration(
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
        Text(label, style: const TextStyle(fontSize: 16)),
        DropdownMenu<String>(
          initialSelection: selectedItem,
          onSelected: (String? value) {
            setState(() {
              selectedItem = value!;
            });
          },
          dropdownMenuEntries: items.map<DropdownMenuEntry<String>>((value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
      ],
    );
  }
}
