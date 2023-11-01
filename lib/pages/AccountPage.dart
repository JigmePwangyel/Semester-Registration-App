import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final String studentName;
  final String studentID;
  final String Department;
  final String email;
  final String CID;
  final String imageUrl; // You can use this for the student's profile picture

  const AccountPage({super.key, 
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
        title: const Text('My Account'),
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
            const SizedBox(height: 20),

            // Student's Name and ID
            Text(
              studentName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              email,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // Other Student Information
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: Text(
                      'Email: $email',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.image_aspect_ratio),
                    title: Text(
                      'CID: $CID',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.school),
                    title: Text(
                      'Department: $Department',
                      style: const TextStyle(
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
