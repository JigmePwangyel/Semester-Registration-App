import 'package:flutter/material.dart';

import 'homeStartButton.dart';

class homePageCard extends StatelessWidget {
  const homePageCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(
                  Icons.announcement_outlined,
                  color: Color.fromRGBO(0, 40, 168, 1),
                  size: 30,
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "Registration is now open",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(0, 128, 255, 1.0),
                      Color.fromRGBO(0, 128, 255, 0),
                    ],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        top: 10,
                      ),
                      child: Text(
                        "Register for the semester",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                bottom: 16, // Adjust the bottom value as needed
                right: 16, // Adjust the right value as needed
                child: startButton(),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: Color.fromRGBO(0, 128, 255, 0.54),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "Registration is now open",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Color.fromRGBO(0, 0, 0, 0.56),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Icon(
                  Icons.monetization_on,
                  color: Color.fromRGBO(0, 128, 255, 0.54),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  "View Fee Structure",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: Color.fromRGBO(0, 0, 0, 0.56),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
