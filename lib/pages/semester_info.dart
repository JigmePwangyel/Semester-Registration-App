import 'package:flutter/material.dart';
import 'package:semester_registration_app/pages/repeat_module.dart';

const List<String> years = [
  'First year',
  'Second year',
  'Third year',
  'Fourth year',
  'Fifth year',
];

const List<String> semesters = [
  '1st',
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

void main() {
  runApp(MaterialApp(
    home: SemesterDetails(),
  ));
}

class SemesterDetails extends StatefulWidget {
  SemesterDetails({Key? key}) : super(key: key);

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
        backgroundColor: Color.fromRGBO(0, 40, 168, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Semester Details'),
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
                Padding(
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
            label: 'Program',
            controller: widget.programController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the program';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          buildDropdownMenu(
            label: 'Year',
            items: years,
            selectedItem: widget.selectedYear,
            onSelected: (value) {
              setState(() {
                widget.selectedYear = value;
              });
            },
          ),
          SizedBox(height: 20),
          buildDropdownMenu(
            label: 'Semester',
            items: semesters,
            selectedItem: widget.selectedSemester,
            onSelected: (value) {
              setState(() {
                widget.selectedSemester = value;
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
                    String program = widget.programController.text;
                    String year = widget.selectedYear;
                    String semester = widget.selectedSemester;

                    print('Program: $program');
                    print('Year: $year');
                    print('Semester: $semester');

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return RepeatModule();
                        },
                      ),
                    );
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
