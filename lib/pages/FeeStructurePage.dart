import 'package:flutter/material.dart';

class FeeStructurePage extends StatefulWidget {
  const FeeStructurePage({super.key});

  @override
  _FeeStructurePageState createState() => _FeeStructurePageState();
}

class _FeeStructurePageState extends State<FeeStructurePage> {
  bool isSelfFinance = true; // Initially, self-financed students are selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fee Structure'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Toggle Switch for Self-Finance and Other Scholarships
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Self-Finance'),
                Switch(
                  value: isSelfFinance,
                  onChanged: (value) {
                    setState(() {
                      isSelfFinance = value;
                    });
                  },
                ),
                const Text('Other Scholarships'),
              ],
            ),

            const SizedBox(height: 20),

            // Fee Structure for Self-Finance Students
            if (isSelfFinance)
              const Column(
                children: <Widget>[
                  Text(
                    'Self-Finance Student Fee Structure',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                   SizedBox(height: 10),
                   Text(
                    'Availing Hostel Fascilities',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Tuition Fee: Nu. 45,823',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Hostel Fee: Nu. 12,500',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'CDF Fee: Nu. 750',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Fee for Day Scholars (No Hostel)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Tuition Fee: Nu. 45,823',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'CDF Fee: Nu. 750',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),

            // Fee Structure for Other Scholarship Students
            if (!isSelfFinance)
              const Column(
                children: <Widget>[
                  Text(
                    'RGoB Scholarship Student Fee Structure',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'CDF Fee: Nu. 750',
                    style: TextStyle(fontSize: 16),
                  ),
                   SizedBox(height: 10),
                  Text(
                    'Other Scholarship Student Fee Structure',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'CDF Fee: Nu. 750',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
