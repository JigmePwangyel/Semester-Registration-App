import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/models/FetchPaymentDetailModel.dart';
import 'package:semester_registration_app/provider/user_provider.dart';
import '../src/payment_detail.dart';

class ReceiptPage extends StatefulWidget {
  const ReceiptPage({super.key});

  @override
  State<ReceiptPage> createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
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
      child: FutureBuilder<PaymentResponse>(
          future: getPaymentDetail(username),
          builder:
              (BuildContext context, AsyncSnapshot<PaymentResponse> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While the Future is still running (loading state)
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If there's an error during the Future execution
              return Text('Error: ${snapshot.error}');
            } else {
              final paymentResponse = snapshot.data!;

              final paymentDetail = paymentResponse.paymentDetail[0];
              final feeBreakdown = paymentResponse.feeBreakdown;
              final totalFee = paymentResponse.totalFee;

              return Card(
                child: Column(
                  children: [
                    Donwload(
                        paymentDetail.journalNumber,
                        paymentDetail.receiptNumber,
                        paymentDetail.paymentDate,
                        feeBreakdown,
                        totalFee),
                    ReceitpInfo(
                      receiptNumber: paymentDetail.receiptNumber,
                      paymentDate: paymentDetail.paymentDate,
                    ),
                    DisplayFees(feeBreakdown, totalFee),
                    JournalNumber(journalNumber: paymentDetail.journalNumber),
                  ],
                ),
              );
            }
          }),
    ));
  }
}

class Donwload extends StatefulWidget {
  final String? receiptNumber;
  final String? paymentDate;
  List<dynamic>? feeBreakdown;
  int? totalFee;
  String? journalNumber;

  Donwload(this.journalNumber, this.receiptNumber, this.paymentDate,
      this.feeBreakdown, this.totalFee,
      {super.key});

  @override
  State<Donwload> createState() => _DonwloadState();
}

class _DonwloadState extends State<Donwload> {
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
        Button(widget.journalNumber, widget.receiptNumber, widget.paymentDate,
            widget.feeBreakdown, widget.totalFee),
      ]),
    );
  }
}

class ReceitpInfo extends StatefulWidget {
  final String? receiptNumber;
  final String? paymentDate;

  const ReceitpInfo(
      {super.key, required this.receiptNumber, required this.paymentDate});

  @override
  State<ReceitpInfo> createState() => _ReceitpInfoState();
}

class _ReceitpInfoState extends State<ReceitpInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: const Color.fromRGBO(0, 25, 105, 1.0),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        child: Row(
          children: [
            Text(
              "Receipt No: #${widget.receiptNumber}",
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
            Expanded(
              child: Text(
                "${widget.paymentDate}",
                style: const TextStyle(
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

class Button extends StatefulWidget {
  List<dynamic>? feeBreakdown;
  final String? receiptNumber;
  final String? paymentDate;
  int? totalFee;
  String? journalNumber;

  Button(this.journalNumber, this.receiptNumber, this.paymentDate,
      this.feeBreakdown, this.totalFee,
      {super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  String generateHtmlTable(List<dynamic>? feeBreakdown) {
    String htmlTable = """
      <table class="items-table">
        <thead>
          <tr>
            <th>Sl.No</th>
            <th>Title</th>
            <th>Amount</th>
          </tr>
        </thead>
        <tbody>
      """;

    for (var i = 0; i < feeBreakdown!.length; i++) {
      var item = feeBreakdown[i];
      var key = item.keys.first;
      var value = item[key].toString();

      htmlTable += "<tr>";
      htmlTable += "<td>${i + 1}</td>";
      htmlTable += "<td>$key</td>";
      htmlTable += "<td>${item[key].toString()}</td>";
      htmlTable += "</tr>";
    }
    // Close the table properly
    htmlTable += """
        </tbody>
      </table>
    """;
    return htmlTable;
  }

  @override
  Widget build(BuildContext context) {
    final String username = context.watch<UserProvider>().username;
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () async {
          print(generateHtmlTable(widget.feeBreakdown));
          String htmlTable = generateHtmlTable(widget.feeBreakdown!);
          final String receipt = """
              <!DOCTYPE html>
              <html>
                <head>
                  <style>
                    body {
                      font-family: Arial, sans-serif;
                      background-color: #f2f2f2;
                    }

                    .receipt {
                      max-width: 600px;
                      margin: 0 auto;
                      background-color: #fff;
                      border: 2px solid #333;
                      border-radius: 10px;
                      padding: 20px;
                      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                    }

                    .header {
                      text-align: center;
                      margin-bottom: 20px;
                    }

                    .header img {
                      padding-top: 15px;
                      width: 100px;
                      height: 100px;
                    }

                    .title {
                      font-size: 24px;
                      margin-bottom: 10px;
                    }

                    .info {
                      font-size: 16px;
                      display: flex;
                      justify-content: space-between;
                    }

                    .details {
                      margin-top: 20px;
                    }

                    .items-table {
                      width: 100%;
                      border-collapse: collapse;
                      margin-top: 20px;
                    }

                    .items-table th,
                    .items-table td {
                      border: 1px solid #ddd;
                      padding: 10px;
                      text-align: left;
                    }

                    .items-table th {
                      background-color: #f2f2f2;
                    }

                    .total {
                      margin-top: 20px;
                      text-align: right;
                      font-size: 18px;
                    }
                  </style>
                </head>
                <body>
                  <div class="receipt">
                    <div class="info">
                      <div class="receipt-info">
                        <p class="title">Money Receipt</p>
                        <p>Date: ${widget.paymentDate}</p>
                        <p>Receipt Number: #${widget.receiptNumber}</p>
                        <p>Journal Number: ${widget.journalNumber}</p>
                      </div>
                      <div class="header">
                        <img src="cst.png" alt="Your Company Logo" />
                      </div>
                    </div>
                    <div class="details">
                      <p>Student Number: $username </p>
                    </div>
                    $htmlTable
                    <div class="total">
                      <p>Total Amount: Nu.${widget.totalFee}</p>
                    </div>
                  </div>
                </body>
              </html>
            """;

          // //Receipt receipt2 = Receipt(receipt);

          // try {
          //   await receipt2.createDocument();
          //   print('PDF document created successfully');
          // } catch (e) {
          //   print('Failed to create PDF document: $e');
          // }
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

class DisplayFees extends StatefulWidget {
  List<dynamic>? feeBreakdown;
  int? totalFee;
  DisplayFees(this.feeBreakdown, this.totalFee, {super.key});

  @override
  State<DisplayFees> createState() => _DisplayFeesState();
}

class _DisplayFeesState extends State<DisplayFees> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView.builder(
          itemCount: widget.feeBreakdown!.length + 1,
          itemBuilder: (context, index) {
            if (index < widget.feeBreakdown!.length) {
              var item = widget.feeBreakdown![index];
              var key = item.keys.first;
              var value = item[key].toString();

              return ListTile(
                leading: Text(key), // Set the key as leading
                trailing: Text("Nu.$value"), // Set the value as trailing
              );
            } else {
              return Column(
                children: [
                  const Divider(),
                  ListTile(
                    leading: const Text(
                      "Total",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      "Nu.${widget.totalFee}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class JournalNumber extends StatefulWidget {
  String? journalNumber;
  JournalNumber({super.key, required this.journalNumber});

  @override
  State<JournalNumber> createState() => _JournalNumberState();
}

class _JournalNumberState extends State<JournalNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, right: 10),
            child: Text(
              "Journal Number: ${widget.journalNumber}",
              style:
                  const TextStyle(color: Color.fromARGB(255, 0x7D, 0x7D, 0x7E)),
            ),
          ),
        ],
      ),
    );
  }
}
