import 'package:flutter/material.dart';

class startButton extends StatelessWidget {
  const startButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      child: ElevatedButton(
        onPressed: () {
          // Button click action
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromRGBO(0, 128, 255, 1.0),
          ), // Set the background color
          side: MaterialStateProperty.all<BorderSide>(
            BorderSide(
                width: 2,
                color: Colors.white), // Set the border (stroke) color and width
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  20), // Adjust the border radius as needed
            ),
          ),
        ),
        child: Text(
          'Start',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
