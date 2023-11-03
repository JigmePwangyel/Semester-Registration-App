import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:semester_registration_app/pages/MyHomePage.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CardContainer1(),
        ),
      ),
    );
  }
}

class CardContainer1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Card(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(0),
              child: Download(),
            ),
            DisplayFees(),
            const SizedBox(height: 30),
            SendPaymentInfo(),
          ],
        ),
      ),
    );
  }
}

class Download extends StatelessWidget {
  const Download({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: const Color.fromRGBO(0, 40, 168, 1),
      alignment: Alignment.center,
      child: Column(
        children: [
          const SizedBox(height: 15),
          const Icon(
            Icons.info,
            size: 40,
            color: Colors.white,
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              "Transfer fees to account no: xxxxxxxxx \n\n In the remark, please enter your student number",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayFees extends StatelessWidget {
  const DisplayFees({Key? key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: const [
        ListTile(
          leading: Text("Tuition Fees"),
          trailing: Text("Nu. 54000"),
        ),
        ListTile(
          leading: Text("Mess Fees"),
          trailing: Text("Nu. 2500"),
        ),
        ListTile(
          leading: Text("Hostel Fees"),
          trailing: Text("Nu. 12500"),
        ),
        Divider(),
        ListTile(
          leading: Text(
            "Total",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            "Nu. 54000",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class SendPaymentInfo extends StatefulWidget {
  const SendPaymentInfo({Key? key}) : super(key: key);

  @override
  _SendPaymentInfoState createState() => _SendPaymentInfoState();
}

class _SendPaymentInfoState extends State<SendPaymentInfo> {
  final TextEditingController moduleCodeController = TextEditingController();
  XFile? selectedImage;
  String? errorText;

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

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(10),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Color.fromARGB(209, 74, 209, 207),
                size: 70,
              ),
              const SizedBox(height: 10),
              const Text("You Have Been Successfully Registered"),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyHomePage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(255, 102, 0, 1.0),
                  minimumSize: const Size(150, 40),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildImageSelectionButton(),
        const SizedBox(height: 20),
        buildTextField(
          label: 'Journal Number',
          controller: moduleCodeController,
        ),
        if (errorText != null)
          Text(
            errorText!,
            style: TextStyle(color: Colors.red),
          ),
        const SizedBox(height: 40),
        Center(
          child: SizedBox(
            width: 180,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                if (validateJournalNumber()) {
                  showSuccessDialog(context);
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
        const SizedBox(height: 30),
      ],
    );
  }

  Widget buildImageSelectionButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Text('Add Screenshot', style: const TextStyle(fontSize: 16)),
        SizedBox(
          height: 40,
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              pickImage();
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
    } else if (int.tryParse(value) == null) {
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
        errorText = null;
      });
    }
    return true;
  }
}
