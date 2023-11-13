import 'dart:convert';
import 'package:http/http.dart' as http;

//To get the username
/// Please create a model and try again
Future<String> getUserName(String userId) async {
  final apiUrl =
      'http://192.168.234.122:3000/user/$userId'; // Replace with your API endpoint
  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);

      // You can parse and return user details as needed
      final username = userData['studentName'];

      return username;
    } else {
      // Handle error, e.g., API returned an error response
      throw Exception('Failed to load user details');
    }
  } catch (e) {
    // Handle any network or request-related errors
    throw Exception('Exception: $e');
  }
}

/// Please create a mode and try again
//TO check wherether the user is registered
Future<bool> isRegistered(String userId) async {
  final apiUrl = 'http://192.168.234.122:3000/user/$userId/IsRegistered';
  try {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      //If user is registered
      return true;
    }
    //If user is not registered
    return false;
  } catch (error) {
    //Error checking registration status
    print(error);
    return false;
  }
}

//To fetch user's semester registration details.
Future<String> getRegistrationDetail(String userId) async {
  final apiUrl =
      'http://192.168.234.122:3000/registration/$userId/RegistrationDetail'; // Replace with your API endpoint
  try {
    final response = await http.get(Uri.parse(apiUrl));
    return response.body;
  } catch (e) {
    // Handle any network or request-related errors
    throw Exception('Exception: $e');
  }
}

Future<bool> changePassword(String userId, String newPassword) async {
  bool changed = false;
  final apiUrl =
      'http://192.168.234.122:3000/user/$userId/changePassword'; // Replace with your API endpoint
  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'newPassword': newPassword,
      }),
    );
    if (response.statusCode == 200) {
      return changed = true;
    } else {
      return changed;
    }
  } catch (e) {
    // Handle any network or request-related errors
    throw Exception('Exception: $e');
  }
}
