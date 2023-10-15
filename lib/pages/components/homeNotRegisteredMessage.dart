import 'package:flutter/material.dart';

class notRegisteredContainer extends StatelessWidget {
  const notRegisteredContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromRGBO(0xF5, 0x8C, 0x68, 0.54), // Background color
          border: Border.all(
              color: Color.fromRGBO(0xED, 0x91, 0x91, 1.0)), // Border (stroke)
          borderRadius: BorderRadius.circular(5.0), // Rounded corners
        ),
        padding: EdgeInsets.all(8.0), // Padding inside the container
        child: const Row(
          children: [
            Icon(
              Icons.warning, // Icon
              color: Color.fromRGBO(0xF6, 0x38, 0x38, 1.0), // Icon color
            ),
            SizedBox(width: 8.0), // Space between the icon and label
            Text(
              'You Have Been Registered', //label text
              style: TextStyle(
                color:
                    Color.fromRGBO(0x4D, 0x4D, 0x4D, 1.0), // Label text color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
