import 'package:flutter/material.dart';

class PaymentSection extends StatelessWidget {
  PaymentSection({Key? key}) : super(key: key);

  final TextEditingController moduleNameController = TextEditingController();
  final TextEditingController moduleCodeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

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
        child: MyCustomForm(),
      ),
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
    return Column(
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
        // Spacer to add space
        const SizedBox(height: 20),

        Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffb9d9f9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Color(0xff1565c0), width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info,
                color: Colors.blue,
                size: 32,
              ),
              const SizedBox(height: 8),
              Text(
                'Transfer fees to account no: xxxxxxxxx \n In the remark, please enter your student number',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff1565c0),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        Expanded(
          child: ListView(
            children: [
              ListTile(
                title: Text("CDF"),
                trailing: Text("Nu. 750"),
              ),
              ListTile(
                title: Text("Mess Fees"),
                trailing: Text("Nu. 2500"),
              ),
              ListTile(
                title: Text("Tuition Fees"),
                trailing: Text("Nu. 54000"),
              ),
              const Divider(),
              ListTile(
                title: Text(
                  "Total",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  "Nu. 67000",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Add a Send button at the bottom
        Center(
          child: Container(
            margin: EdgeInsets.only(bottom: 50),
            width: 105,
            height: 45,
            child: ElevatedButton(
              onPressed: () {
                // Handle the send button click here
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Send",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
