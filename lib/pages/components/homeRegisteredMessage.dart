import 'package:flutter/material.dart';

class registeredContainer extends StatelessWidget {
  const registeredContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 350,
        height: 40,
        decoration: BoxDecoration(
          color: Color.fromRGBO(103, 194, 58, 0.37), // Background color
          border: Border.all(
              color: Color.fromRGBO(57, 156, 48, 0.56)), // Border (stroke)
          borderRadius: BorderRadius.circular(5.0), // Rounded corners
        ),
        padding: EdgeInsets.all(8.0), // Padding inside the container
        child: const Row(
          children: [
            Icon(
              Icons.check_circle, // Icon
              color: Color.fromRGBO(0, 166, 168, 1.0), // Icon color
            ),
            SizedBox(width: 8.0), // Space between the icon and label
            Text(
              'You Have Not Registered', //label text
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
