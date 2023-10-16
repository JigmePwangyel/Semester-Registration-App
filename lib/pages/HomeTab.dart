import 'package:flutter/material.dart';
import 'components/homePairOfCards.dart';
import 'components/homeMainCard.dart';
import 'components/homeNotRegisteredMessage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
