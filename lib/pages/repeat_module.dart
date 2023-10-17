import 'package:flutter/material.dart';
import 'add_module.dart';
import 'payment_section.dart';

class RepeatModule extends StatefulWidget {
  @override
  _RepeatModuleState createState() => _RepeatModuleState();
}

class _RepeatModuleState extends State<RepeatModule> {
  List<String> moduleValues = []; // List to store module names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 40, 168, 1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // "Registration" text with a line on the side
            Center(
              child: Align(
                alignment: Alignment(0, -0.9),
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
            ),
            const SizedBox(height: 50),
            // Label text above the list view
            Text(
              'List of Repeat Modules',
              style: TextStyle(
                fontSize: 18, // Customize font size
              ),
            ),
            const SizedBox(height: 20),
            // Display a list of module names with spacing and adjusted width
            Expanded(
              child: ListView.builder(
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
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete), // Delete icon
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
            ),
            const SizedBox(height: 20),
            // Add button
            Center(
              child: Container(
                width: 105,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddModule()),
                    ).then((value) {
                      setState(() {
                        if (value != null) {
                          moduleValues.add(value);
                        }
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  child: Text(
                    'Add',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Add space between buttons
            // Next button
            Center(
              child: Container(
                width: 220,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle the "Next" button action here
                    // Navigate to the Payment Section when "Next" is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PaymentSection()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange, // You can customize the color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(5),
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
