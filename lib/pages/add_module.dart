import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class AddModule extends StatelessWidget {
  AddModule({Key? key}) : super(key: key);

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
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  MyCustomForm({Key? key});

  final TextEditingController moduleNameController = TextEditingController();
  final TextEditingController moduleCodeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // "Registration" text with a line on the side
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

          // Module Name text input field
          buildAutoCompleteTextField(
            label: 'Module Name',
            controller: moduleNameController,
            suggestions: [
              "Human Computer Interaction",
              "Advanced Web Technology",
              "Mobile Application Development",
            ],
          ),

          SizedBox(height: 20),

          // Module Code text input field
          buildAutoCompleteTextField(
            label: 'Module Code',
            controller: moduleCodeController,
            suggestions: ["CTE308", "CTE307", "DIS302"],
          ),

          SizedBox(height: 20),

          // Status text input field
          buildAutoCompleteTextField(
            label: 'Status (First or Second Repeat)',
            controller: statusController,
            suggestions: ["First Repeat", "Second Repeat"],
          ),

          SizedBox(height: 60),

          // Add button
          Center(
            child: Container(
              width: 105,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  String moduleName = moduleNameController.text;
                  Navigator.of(context).pop(moduleName);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAutoCompleteTextField({
    required String label,
    required TextEditingController controller,
    required List<String> suggestions,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        AutoCompleteTextField<String>(
          key: GlobalKey<AutoCompleteTextFieldState<String>>(),
          clearOnSubmit: false,
          suggestions: suggestions,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          controller: controller,
          //readOnly: true, // Prevent user input
          itemFilter: (item, query) {
            return item.toLowerCase().startsWith(query.toLowerCase());
          },
          itemSorter: (a, b) {
            return a.compareTo(b);
          },
          itemSubmitted: (item) {
            controller.text = item;
          },
          itemBuilder: (context, item) {
            return ListTile(
              title: Text(item),
            );
          },
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AddModule(),
  ));
}
