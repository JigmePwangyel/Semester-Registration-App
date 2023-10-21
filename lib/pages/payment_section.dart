import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PaymentSection(),
    );
  }
}

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20), // Add space on all sides
        child: CardContainer1(), // Wrap the Card in a Container
      ),
    );
  }
}
class CardContainer1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50), // Add space between AppBar and Card
      child: Card(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(0), // Add padding to the Download content
              child: Download(),
            ),
            DisplayFees(),
            Button(), // Add the "Download Receipt" button
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class Download extends StatelessWidget {
  const Download({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      color: const Color.fromRGBO(0, 40, 168, 1),
      alignment: Alignment.center,
      child: const Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Icon(
            Icons.info,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(height: 30),
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
  const DisplayFees({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
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
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 44,
      child: ElevatedButton(
        onPressed: () {
          // Button Clicked Action
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
        child: const Text(
          'Send the Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),

    );
  }
}