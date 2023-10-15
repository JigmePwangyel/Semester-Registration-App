import 'package:flutter/material.dart';
import 'components/homePairOfCards.dart';
import 'components/homeMainCard.dart';
import 'components/sideMenu.dart';
import 'components/CustomBottomNavigationBar.dart';
import 'components/homeNotRegisteredMessage.dart';
import 'components/homeRegisteredMessage.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: sideMenu(),
      appBar: AppBar(),
      bottomNavigationBar: const CustomBottomNavigationBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Text(
              "Welcome back Jigme",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 25),
            notRegisteredContainer(),
            SizedBox(height: 25),
            infoCard(),
            SizedBox(height: 25),
            homePageCard(),
          ],
        ),
      ),
    );
  }
}
