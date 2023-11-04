import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/models/FetchPaymentDetailModel.dart';
import 'package:semester_registration_app/provider/user_provider.dart';
import '../src/payment_detail.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:lecle_downloads_path_provider/lecle_downloads_path_provider.dart';
import 'package:open_document/open_document.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

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
              final name = username;

              return Card(
                child: Column(
                  children: [
                    Donwload(
                        paymentDetail.journalNumber,
                        paymentDetail.receiptNumber,
                        paymentDetail.paymentDate,
                        feeBreakdown,
                        totalFee,
                        name as String?),
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

class Donwload extends StatelessWidget {
  final String? receiptNumber;
  final String? paymentDate;
  List<dynamic>? feeBreakdown;
  int? totalFee;
  String? journalNumber;
  String? name;

  Donwload(this.journalNumber, this.receiptNumber, this.paymentDate,
      this.feeBreakdown, this.totalFee, this.name,
      {super.key});

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
        Button(journalNumber, receiptNumber, paymentDate, feeBreakdown,
            totalFee, name),
      ]),
    );
  }
}

class ReceitpInfo extends StatelessWidget {
  final String? receiptNumber;
  final String? paymentDate;

  const ReceitpInfo(
      {super.key, required this.receiptNumber, required this.paymentDate});

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
              "Receipt No: #$receiptNumber",
              style: const TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
            Expanded(
              child: Text(
                "$paymentDate",
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
  String? name;

  Button(this.journalNumber, this.receiptNumber, this.paymentDate,
      this.feeBreakdown, this.totalFee, this.name,
      {super.key});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  //Data for the table
  List<List<String>> data = [];
  String? receiptNumber;
  String? paymentDate;
  int? totalFee;
  String? journalNumber;
  String? name;

  @override
  void initState() {
    super.initState();
    data = convertToDesiredFormat(widget.feeBreakdown!);
    receiptNumber = widget.receiptNumber;
    paymentDate = widget.paymentDate;
    totalFee = widget.totalFee;
    journalNumber = widget.journalNumber;
    name = widget.name;
  }

  //To convert the data to the correct format
  List<List<String>> convertToDesiredFormat(List<dynamic> initialData) {
    List<List<String>> desiredFormat = [];

    for (int i = 0; i < initialData.length; i++) {
      if (i == 0) {
        desiredFormat.add(["Sl.No", "Title", "Amount"]);
      }
      String index = (i + 1).toString();
      String key = initialData[i].keys.first;
      String value = initialData[i][key].toString();
      desiredFormat.add([index, key, value]);
    }

    return desiredFormat;
  }

  //For downloading pdf
  Future makePdf() async {
    final font = await PdfGoogleFonts.robotoMedium();
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('assets/cst.png');
    final Uint8List byteList = bytes.buffer.asUint8List();

    //Progress to indicate pdf generation
    ProgressDialog pr;

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.only(
          left: 40,
          right: 40,
          top: 30,
        ),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
            children: [
              pw.Container(
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "Money Receipt",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 20,
                            font: font,
                          ),
                        ),
                        pw.SizedBox(
                          height: 20,
                        ),
                        pw.Text(
                          "Date: $paymentDate",
                          style: pw.TextStyle(
                            fontSize: 17,
                            font: font,
                          ),
                        ),
                        pw.Text("Receipt Number: #$receiptNumber",
                            style: pw.TextStyle(
                              fontSize: 18,
                              font: font,
                            )),
                        pw.Text("Journal: MBOB: $journalNumber",
                            style: pw.TextStyle(
                              fontSize: 18,
                              font: font,
                            )),
                        pw.SizedBox(
                          height: 15,
                        ),
                        pw.Text("Student Number: $name",
                            style: pw.TextStyle(
                              fontSize: 18,
                              font: font,
                            )),
                      ],
                    ),
                    pw.Image(
                      pw.MemoryImage(byteList),
                      width: 115,
                      height: 115,
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 60),
              pw.TableHelper.fromTextArray(
                border: pw.TableBorder.all(),
                data: data,
              ),
              pw.SizedBox(
                height: 15,
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text(
                    "Total Amount: Nu.$totalFee",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 20,
                      font: font,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    //Progress Dialog
    pr = ProgressDialog(context);
    pr.style(
        message: 'Downnloading Receipt',
        progressWidget: CircularProgressIndicator(),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.w600));
    await pr.show(); // Show the progress dialog

    String? downloadsDirectoryPath =
        (await DownloadsPath.downloadsDirectory())?.path;
    final baseFilePath = '$downloadsDirectoryPath/receipt';

    int fileCounter = 0;
    String filePath;

    while (true) {
      try {
        if (fileCounter == 0) {
          filePath = "$baseFilePath($fileCounter).pdf";
          final file = File(filePath);
          await file.writeAsBytes(await pdf.save());

          await pr.hide(); // Hide the progress dialog

          // Open the PDF document using open_document
          try {
            await OpenDocument.openDocument(filePath: filePath);
          } catch (e) {
            print('Error opening the document: $e');
          }

          break;
        } else {
          filePath = "$baseFilePath($fileCounter).pdf";
          final file = File(filePath);
          await file.writeAsBytes(await pdf.save());

          await pr.hide(); // Hide the progress dialog
          // Open the PDF document using open_document
          try {
            await OpenDocument.openDocument(filePath: filePath);
          } catch (e) {
            print('Error opening the document: $e');
          }
          break;
        }
      } catch (e) {
        fileCounter++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String username = context.watch<UserProvider>().username;
    return SizedBox(
      width: 200,
      child: ElevatedButton(
        onPressed: () async {
          makePdf();
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
  List<dynamic>? feeBreakdown;
  int? totalFee;
  DisplayFees(this.feeBreakdown, this.totalFee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: ListView.builder(
          itemCount: feeBreakdown!.length + 1,
          itemBuilder: (context, index) {
            if (index < feeBreakdown!.length) {
              var item = feeBreakdown![index];
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
                      "Nu.$totalFee",
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

class JournalNumber extends StatelessWidget {
  String? journalNumber;
  JournalNumber({required this.journalNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5, right: 10),
            child: Text(
              "Journal Number: $journalNumber",
              style:
                  const TextStyle(color: Color.fromARGB(255, 0x7D, 0x7D, 0x7E)),
            ),
          ),
        ],
      ),
    );
  }
}
