import 'package:flutter/material.dart';
import 'add_module.dart';
import 'payment_section.dart';

class RepeatModule extends StatefulWidget {
  @override
  _RepeatModuleState createState() => _RepeatModuleState();
}

class _RepeatModuleState extends State<RepeatModule> {
  List<String> moduleValues = [];

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
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              const Text(
                'List of Repeat Modules',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: moduleValues.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
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
                            icon: const Icon(Icons.delete),
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
              const SizedBox(height: 60), // Add space
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Buttons next to each other
                children: [
                  SizedBox(
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
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(160, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(255, 102, 0, 1.0),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Add',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentSection()),
                        );
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(160, 50)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromRGBO(255, 102, 0, 1.0),
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
