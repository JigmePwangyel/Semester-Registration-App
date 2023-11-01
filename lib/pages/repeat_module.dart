import 'package:flutter/material.dart';
import 'add_module.dart';
import 'payment_section.dart';

class RepeatModule extends StatefulWidget {
  const RepeatModule({super.key});

  @override
  _RepeatModuleState createState() => _RepeatModuleState();
}
class _RepeatModuleState extends State<RepeatModule> {
  List<String> moduleValues = []; // List to store module names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: const Text("Register"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 40, 168, 1),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              // Label text above the list view
              const Text(
                'List of Repeat Modules',
                style: TextStyle(
                  fontSize: 18, // Customize font size
                ),
              ),
              const SizedBox(height: 20),
              // Display a list of module names with spacing and adjusted width
              ListView.builder(
                shrinkWrap: true, // Let the list take the necessary space
                itemCount: moduleValues.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0), // Add spacing here
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                moduleValues[index],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete), // Delete icon
                            onPressed: () {
                              setState(() {
                                moduleValues.removeAt(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 120),
              // Add button
              Center(
                child: SizedBox(
                  width: 105,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const AddModule()),
                      ).then((value) {
                        setState(() {
                          if (value != null) {
                            moduleValues.add(value);
                          }
                        });
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                          0xFFFF6600), // Set button color to #FF6600
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.all(5),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), // Add space between buttons
              // Next button
              Center(
                child: SizedBox(
                  width: 353,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle the "Next" button action here
                      // Navigate to the Payment Section when "Next" is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PaymentSection()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6600), // Set button color to #FF6600
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      padding: const EdgeInsets.all(5),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}