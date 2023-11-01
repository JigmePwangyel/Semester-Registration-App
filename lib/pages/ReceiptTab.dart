import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/models/FetchPaymentDetailModel.dart';
import 'package:semester_registration_app/provider/user_provider.dart';
import '../src/payment_detail.dart';

class ReceiptPage extends StatelessWidget {
  const ReceiptPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String username = context.watch<UserProvider>().username;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(
        top: 15,
        right: 20,
        left: 20,
        bottom: 15,
      ),
      // child: FutureBuilder<String>(
      //     future: getPaymentDetail(username),
      //     builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         // While the Future is still running (loading state)
      //         return const Center(child: CircularProgressIndicator());
      //       } else if (snapshot.hasError) {
      //         // If there's an error during the Future execution
      //         return Text('Error: ${snapshot.error}');
      //       } else {
      //         final apiResponse = snapshot.data!;
      //         final paymentData = parsePaymentData(apiResponse);
      //       }
      //     }
      // ),
      child: Card(
        child: Column(
          children: [
            Donwload(),
            ReceitpInfo(),
            DisplayFees(),
            JournalNumber(),
          ],
        ),
      ),
    ));
  }
}

class Donwload extends StatelessWidget {
  const Donwload({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: const Color.fromRGBO(0, 40, 168, 1),
      alignment: Alignment.center,
      child: Column(children: [
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: 80,
          height: 80,
          child: Image.asset('assets/cst.png'),
        ),
        const SizedBox(height: 15),
        const Text(
          "Thank You For Paying",
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Button(),
      ]),
    );
  }
}

class ReceitpInfo extends StatelessWidget {
  const ReceitpInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: const Color.fromRGBO(0, 25, 105, 1.0),
      child: const Padding(
        padding: EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        child: Row(
          children: [
            Text(
              "Receipt No #8080",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
            Expanded(
              child: Text(
                "September 10, 2023",
                style: TextStyle(
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
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
      child: ElevatedButton(
        onPressed: () {
          //Button Clciked Action
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromRGBO(255, 102, 0, 1.0),
            ), // Set the background color

            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    5), // Adjust the border radius as needed
              ),
            )),
        child: const Text(
          'Download Receipt',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

class DisplayFees extends StatelessWidget {
  const DisplayFees({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView(
          children: const [
            ListTile(
              leading: Text("Tution Fees"),
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
      ),
    );
  }
}

class JournalNumber extends StatelessWidget {
  const JournalNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5, right: 10),
            child: Text(
              "Journal Number: 3306",
              style: TextStyle(color: Color.fromARGB(255, 0x7D, 0x7D, 0x7E)),
            ),
          ),
        ],
      ),
    );
  }
}
