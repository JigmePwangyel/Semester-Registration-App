import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:semester_registration_app/provider/user_provider.dart';

Future<void> loginUser(BuildContext context, username, String password) async {
  final response = await http.post(
    Uri.parse(
        'http://192.168.214.159:3000/auth/login'), // Replace with your API endpoint
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'username': username, 'password': password}),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final token = data['token']; // Assuming the server sends a 'token' field

    if (token != null) {
      if (JwtDecoder.isExpired(token)) {
        print("Token has expired. Please log in again.");
      } else {
        final Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
        final role = decodedToken['role'];
        if (role == "student") {
          context.read<UserProvider>().login(); // Update authentication status
          //print("Logged in as Student");
        } else {
          print("Admin Loggin coming soon!!!");
        }
      }
    }
  } else if (response.statusCode == 401) {
    print("Invalid username or password");
  } else if (response.statusCode == 500) {
    print("Internal Server Error");
  }
}
