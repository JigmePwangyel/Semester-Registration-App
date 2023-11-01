import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:semester_registration_app/pages/MyHomePage.dart';

void main() {
  runApp(const MaterialApp(
    home: SendPaymentInfo(),
  ));
}
class SendPaymentInfo extends StatelessWidget {
  const SendPaymentInfo({Key? key}) : super(key: key);

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
      body: const SingleChildScrollView(
        child: MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final TextEditingController moduleCodeController = TextEditingController();
  XFile? selectedImage; // Variable to store the selected image
  String? errorText; // Error message

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  // Function to show a success dialog
  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(
              10), // Adjust the padding to increase the dialog size
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Color.fromARGB(209, 74, 209, 207),
                size: 60,
              ),
              const SizedBox(height: 10),
              const Text("You Have Been Successfully Registered"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage())); // Navigate back to the home screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 102, 0, 1.0),
                ),
                child: const Text('Back to Home'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Image selection button
          buildImageSelectionButton(),
          const SizedBox(height: 20),
          buildTextField(
            label: 'Journal Number',
            controller: moduleCodeController,
          ),
          if (errorText != null)
            Text(
              errorText!,
              style: const TextStyle(color: Colors.red),
            ),
          const SizedBox(height: 60),
          Center(
            child: SizedBox(
              width: 200,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  if (validateJournalNumber()) {
                    // Handle the form submission here
                    showSuccessDialog(context); // Show success dialog
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(255, 102, 0, 1.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Send',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImageSelectionButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60),
        const Text('Add Screenshot', style: TextStyle(fontSize: 16)),
        SizedBox(
          height: 44, // Specify the height
          width: 200, // Specify the width
          child: ElevatedButton(
            onPressed: () {
              pickImage(); // Call the function to pick an image
            },
            child: const Text('Select Image'),
          ),
        ),
        const SizedBox(height: 10),
        if (selectedImage != null)
          Image.file(
            File(selectedImage!.path),
            height: 150,
            width: 100,
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
          style: const TextStyle(fontSize: 16),
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          controller: controller,
        ),
      ],
    );
  }

  bool validateJournalNumber() {
    final value = moduleCodeController.text;
    if (value.isEmpty) {
      setState(() {
        errorText = 'Journal Number is required.';
      });
      return false;
    } else if (int.tryParse(value) == null || value.length != 7) {
      setState(() {
        errorText = 'Invalid Journal Number';
      });
      return false;
    } else if (selectedImage == null) {
      setState(() {
        errorText = 'Please select an image.';
      });
      return false;
    } else {
      setState(() {
        errorText = null; // Clear the error message
      });
    }
    return true;
  }
}
