import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class AddModule extends StatelessWidget {
  const AddModule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 40, 168, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  MyCustomForm({Key? key});

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final TextEditingController moduleNameController = TextEditingController();
  final TextEditingController moduleCodeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  bool isInvalid = false; // Added isInvalid variable

  final Map<String, String> moduleMap = {
    //civil first year
    "Calculus and Infinite Series": "MAT101",
    "Introduction to Programming": "CPL101",
    "Engineering Physics-I": "PHY101",
    "Engineering Chemistry": "CHE101",
    "Engineering Graphics": "EGP101",
    //civil second year
    "Engineering Mathematics-III": "MAT204",
    "Fluid Mechanics": "FMH201",
    "Principles of Surveying-I": "SUR201",
    "Strength of Materials": "TSM202",
    "Building Drawing": "BPD202",
    //civil third year
    "Enterpreneurship": "EDP101",
    "Introduction to Research": "PRW301",
    "Design of Steel Structure-I": "DOS301",
    "Hydrology": "EVE301",
    "Structural Mechanics-II": "TSM304",
    "Soil Mechanics": "FED301",
    //civil fourth year
    "Design of Concrete Structures-II": "DOS404",
    "Hydraulics Structures & Water Power Engineering": "FMH403",
    "Environmental Engineering-II": "EVE403",
    "Estimating Costing and Tendering": "BPD403",
    "Highway Engineering": "HWE401",
    //"":"",
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 50),
          buildAutoCompleteTextField(
            label: 'Module Name',
            controller: moduleNameController,
            suggestions: moduleMap.keys.toList(),
            onChanged: (value) {
              if (value == moduleNameController.text) {
                moduleCodeController.text = moduleMap[value] ?? '';
                isInvalid = false;
              } else {
                isInvalid = true;
              }
            },
          ),
          const SizedBox(height: 20),
          buildAutoCompleteTextField(
            label: 'Module Code',
            controller: moduleCodeController,
            suggestions: moduleMap.values.toList(),
            onChanged: (value) {
              if (value == moduleCodeController.text) {
                moduleMap.forEach((key, val) {
                  if (val == value) {
                    moduleNameController.text = key;
                  }
                });
                isInvalid = false;
              } else {
                isInvalid = true;
              }
            },
          ),
          if (isInvalid)
            const Text(
              'Invalid value entered. Please use the suggestions.',
              style: TextStyle(color: Colors.red),
            ),
          const SizedBox(height: 20),
          buildAutoCompleteTextField(
            label: 'Status (First or Second Repeat)',
            controller: statusController,
            suggestions: ["First Repeat", "Second Repeat"],
          ),
          const SizedBox(height: 60),
          Center(
            child: SizedBox(
              width: 105,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  if (!isInputValid()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Invalid text fields.'),
                    ));
                  } else {
                    String moduleName = moduleNameController.text;
                    Navigator.of(context).pop(moduleName);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 102, 0, 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
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

  bool isInputValid() {
    return !isInvalid &&
        isSuggestionValid(moduleNameController.text, moduleMap.keys.toList()) &&
        isSuggestionValid(
            moduleCodeController.text, moduleMap.values.toList()) &&
        isSuggestionValid(
            statusController.text, ["First Repeat", "Second Repeat"]);
  }

  bool isSuggestionValid(String input, List<String> suggestions) {
    return suggestions.contains(input);
  }

  Widget buildAutoCompleteTextField({
    required String label,
    required TextEditingController controller,
    required List<String> suggestions,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        AutoCompleteTextField<String>(
          key: GlobalKey<AutoCompleteTextFieldState<String>>(),
          clearOnSubmit: false,
          suggestions: suggestions,
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          controller: controller,
          itemFilter: (item, query) {
            return item.toLowerCase().startsWith(query.toLowerCase());
          },
          itemSorter: (a, b) {
            return a.compareTo(b);
          },
          itemSubmitted: (item) {
            controller.text = item;
            isInvalid =
                false; // Reset isInvalid when a valid suggestion is selected
            if (onChanged != null) {
              onChanged(item);
            }
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
  runApp(const MaterialApp(
    home: AddModule(),
  ));
}
