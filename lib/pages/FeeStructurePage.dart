import 'package:flutter/material.dart';

class FeeStructurePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fee Structure'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Self-Finance Student',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FeeDetailsCard(
                feeDetails: [
                  FeeDetail('Tuition Fee', 'Nu. 45,823'),
                  FeeDetail('Hostel Fee', 'Nu. 12,500'),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Repeating Student',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FeeDetailsCard(
                feeDetails: [
                  FeeDetail('Fee per Module', 'Nu. 9164'),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'For backpaper',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FeeDetailsCard(
                feeDetails: [
                  FeeDetail('Each Paper', 'Nu. 200'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeeDetail {
  final String title;
  final String amount;

  FeeDetail(this.title, this.amount);
}

class FeeDetailsCard extends StatelessWidget {
  final List<FeeDetail> feeDetails;

  FeeDetailsCard({required this.feeDetails});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Table(
          columnWidths: {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
          },
          children: feeDetails
              .map((detail) => TableRow(
                    children: [
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            detail.title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      TableCell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(detail.amount),
                        ),
                      ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
