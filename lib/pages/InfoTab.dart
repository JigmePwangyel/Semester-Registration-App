import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // College Logo
              Image.asset(
                'assets/cst.png',
                width: 100, // Adjust the size as needed
                height: 100,
              ),

              // Brief Description
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Welcome to the Semester Registration App!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text(
                'Our app simplifies the semester registration process, making it easy for students to select and enroll in their desired courses.',
                style: TextStyle(fontSize: 16),
              ),

              // Mission and Vision
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Mission and Vision',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Text(
                'Our mission is to provide students with a seamless and efficient semester registration experience, '
                'enabling them to focus on their academic journey.',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'We envision a future where students can register for their courses with ease, '
                'ensuring they make the most of their college experience.',
                style: TextStyle(fontSize: 16),
              ),

              // Team Members
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'Team Members',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // List of Team Members
              Column(
                children: <Widget>[
                  TeamMemberCard(
                    name: 'John Doe',
                    role: 'Lead Developer',
                  ),
                  TeamMemberCard(
                    name: 'Jane Smith',
                    role: 'UI/UX Designer',
                  ),
                  TeamMemberCard(
                    name: 'David Johnson',
                    role: 'Project Manager',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;

  TeamMemberCard({required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text(name),
        subtitle: Text(role),
      ),
    );
  }
}
