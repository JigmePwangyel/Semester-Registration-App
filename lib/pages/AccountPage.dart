import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final String studentName;
  final String studentID;
  final String Department;
  final String email;
  final String CID;
  final String imageUrl; // You can use this for the student's profile picture

  AccountPage({
    required this.studentName,
    required this.studentID,
    required this.Department,
    required this.email,
    required this.CID,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Student's Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(imageUrl), // or AssetImage for a local image
            ),
            SizedBox(height: 20),

            // Student's Name and ID
            Text(
              '$studentName',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '$email',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20),

            // Other Student Information
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text(
                      'Email: $email',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.image_aspect_ratio),
                    title: Text(
                      'CID: $CID',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.school),
                    title: Text(
                      'Department: $Department',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
