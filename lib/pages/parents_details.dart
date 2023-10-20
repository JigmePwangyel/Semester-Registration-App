import 'package:flutter/material.dart';
import 'package:semester_registration_app/pages/semester_info.dart';

void main() {
  runApp(MaterialApp(
    home: ParentsDetails(),
  ));
}

class ParentsDetails extends StatefulWidget {
  @override
  _ParentsDetailsState createState() => _ParentsDetailsState();
}

class _ParentsDetailsState extends State<ParentsDetails> {
  final TextEditingController parentNameController = TextEditingController();
  final TextEditingController parentMobileController = TextEditingController();
  final TextEditingController parentEmailController = TextEditingController();
  final TextEditingController parentAddressController = TextEditingController();

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
        title: Text('Parents Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: MyCustomForm(
          parentNameController: parentNameController,
          parentMobileController: parentMobileController,
          parentEmailController: parentEmailController,
          parentAddressController: parentAddressController,
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

  MyCustomForm({
    required this.parentNameController,
    required this.parentMobileController,
    required this.parentEmailController,
    required this.parentAddressController,
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
        SizedBox(height: 50),
        buildTextField(
          label: 'Parents Name',
          controller: widget.parentNameController,
        ),
        SizedBox(height: 20),
        buildTextField(
          label: "Parents' Mobile Number",
          controller: widget.parentMobileController,
        ),
        SizedBox(height: 20),
        buildTextField(
          label: "Parents' Email ID",
          controller: widget.parentEmailController,
        ),
        SizedBox(height: 20),
        buildTextField(
          label: "Current Address",
          controller: widget.parentAddressController,
        ),
        SizedBox(height: 60),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  String parentName = widget.parentNameController.text;
                  String parentMobile = widget.parentMobileController.text;
                  String parentEmail = widget.parentEmailController.text;
                  String parentAddress = widget.parentAddressController.text;

                  // Handle the data as needed
                  print('Parents Name: $parentName');
                  print("Parents' Mobile Number: $parentMobile");
                  print("Parents' Email: $parentEmail");
                  print('Current Address: $parentAddress');

                  // Navigate to Semester Information Details
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SemesterDetails();
                      },
                    ),
                  );
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
                  'Save',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to Semester Information Details
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return SemesterDetails();
                      },
                    ),
                  );
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
                  'Next',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
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
        Text(label, style: TextStyle(fontSize: 16)),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
