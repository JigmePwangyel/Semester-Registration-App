import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/pages/semester_info.dart';
import 'package:semester_registration_app/provider/registration_provider.dart';

void main() {
  runApp(const MaterialApp(
    home: ParentsDetails(),
  ));
}

class ParentsDetails extends StatefulWidget {
  const ParentsDetails({super.key});

  @override
  _ParentsDetailsState createState() => _ParentsDetailsState();
}

class _ParentsDetailsState extends State<ParentsDetails> {
  final TextEditingController parentNameController = TextEditingController();
  final TextEditingController parentMobileController = TextEditingController();
  final TextEditingController parentEmailController = TextEditingController();
  final TextEditingController parentAddressController = TextEditingController();

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
        title: const Text("Parents' Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: MyCustomForm(
            formKey: _formKey,
            parentNameController: parentNameController,
            parentMobileController: parentMobileController,
            parentEmailController: parentEmailController,
            parentAddressController: parentAddressController,
          ),
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  final TextEditingController parentNameController;
  final TextEditingController parentMobileController;
  final TextEditingController parentEmailController;
  final TextEditingController parentAddressController;
  final GlobalKey<FormState> formKey;

  const MyCustomForm({
    super.key,
    required this.parentNameController,
    required this.parentMobileController,
    required this.parentEmailController,
    required this.parentAddressController,
    required this.formKey,
  });

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  @override
  Widget build(BuildContext context) {
    //Provider to store Parent Details
    StudentRegistrationProvider studentDataProvider =
        Provider.of<StudentRegistrationProvider>(context, listen: false);

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
          buildTextField(
            label: "Parents'/Guardians' Name",
            controller: widget.parentNameController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter parents' name";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          buildTextField(
            label: "Parents'/Guardians' Mobile Number",
            controller: widget.parentMobileController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter parents' mobile number";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          buildTextField(
            label: "Parents'/Guardians' Email ID",
            controller: widget.parentEmailController,
          ),
          const SizedBox(height: 20),
          buildTextField(
            label: "Current Address",
            controller: widget.parentAddressController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter current address";
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
                    String parentName = widget.parentNameController.text;
                    String parentMobile = widget.parentMobileController.text;
                    String parentEmail = widget.parentEmailController.text;
                    String parentAddress = widget.parentAddressController.text;

                    // Storing Data in the Provider
                    studentDataProvider.parentName = parentName;
                    studentDataProvider.parentMobileNumber = parentMobile;
                    studentDataProvider.parentEmailId = parentEmail;
                    studentDataProvider.parentCurrentAddress = parentAddress;

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const SemesterDetails();
                        },
                      ),
                    );
                  }
                },
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
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
