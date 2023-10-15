import 'package:flutter/material.dart';

class infoCard extends StatelessWidget {
  const infoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Card(
          child: Container(
            width: 150,
            padding: EdgeInsets.all(20),
            height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.date_range,
                  color: Color.fromRGBO(0, 128, 255, 0.54),
                ),
                SizedBox(height: 10),
                Text(
                  "11/11/2023",
                  style: TextStyle(
                    color: Color.fromRGBO(77, 77, 77, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Final date of registration",
                  style: TextStyle(
                    color: Color.fromRGBO(80, 80, 80, 1),
                  ),
                )
              ],
            ),
          ),
        ),
        Card(
          child: Container(
            width: 150,
            padding: EdgeInsets.all(20),
            height: 140,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: Color.fromRGBO(0, 128, 255, 0.54),
                ),
                SizedBox(height: 10),
                Text(
                  "11/11/2023",
                  style: TextStyle(
                    color: Color.fromRGBO(77, 77, 77, 1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Reporting Date",
                  style: TextStyle(
                    color: Color.fromRGBO(80, 80, 80, 1),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
