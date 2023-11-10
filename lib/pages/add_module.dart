import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/models/RepeatModule.dart';
import 'package:semester_registration_app/provider/StoreRepeatModule.dart';
import 'package:semester_registration_app/provider/repeat_module_provider.dart';

class AddModule extends StatelessWidget {
  const AddModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Repeat Module"),
        centerTitle: false,
        backgroundColor: const Color.fromRGBO(0, 40, 168, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const SingleChildScrollView(
        child: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final TextEditingController moduleNameController = TextEditingController();
  final TextEditingController moduleCodeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  bool isInvalid = false; // Added isInvalid variable

  Map<String, String>? moduleMap;
  List<Module> modules = []; // List to store modules

  @override
  Widget build(BuildContext context) {
    moduleMap = context.watch<RepeatModuleProvider>().RepeatModule;
    final enteredModuleProvider = context.watch<EnteredModuleProvider>();
    List<Module> enteredModule = enteredModuleProvider.enteredModules;
    return Container(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 50),
          buildAutoCompleteTextField(
            label: 'Module Name',
            controller: moduleNameController,
            suggestions: moduleMap!.keys.toList(),
            onChanged: (value) {
              if (value == moduleNameController.text) {
                moduleCodeController.text = moduleMap![value] ?? '';
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
            suggestions: moduleMap!.values.toList(),
            onChanged: (value) {
              if (value == moduleCodeController.text) {
                moduleMap!.forEach((key, val) {
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
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  if (!isInputValid()) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Invalid text fields.'),
                    ));
                  } else {
                    String moduleName = moduleNameController.text;
                    String moduleCode = moduleCodeController.text;
                    String status = statusController.text;

                    // Create a Module object and add it to the list
                    Module module = Module(
                      moduleName: moduleName,
                      moduleCode: moduleCode,
                      status: status,
                    );

                    // Use the new provider to add the entered module
                    enteredModuleProvider.addEnteredModule(module);

                    // Accessing properties of each module
                    for (Module module in enteredModule) {
                      String moduleName = module.moduleName;
                      String moduleCode = module.moduleCode;
                      String status = module.status;

                      // Use the properties as needed
                      print(
                          'Module Name: $moduleName, Module Code: $moduleCode, Status: $status');
                    }
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
        isSuggestionValid(
            moduleNameController.text, moduleMap!.keys.toList()) &&
        isSuggestionValid(
            moduleCodeController.text, moduleMap!.values.toList()) &&
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
          controller: controller,
          style: const TextStyle(
              fontSize: 14, color: Color.fromRGBO(0, 40, 168, 1)),
          decoration: const InputDecoration(
            contentPadding:
                EdgeInsets.symmetric(vertical: 1.0, horizontal: 8.0),
            border: OutlineInputBorder(),
          ),
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
