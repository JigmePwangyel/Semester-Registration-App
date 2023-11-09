import 'dart:convert';
import 'package:http/http.dart' as http;

//To get the username
/// Please create a model and try again
Future<String> getUserName(String userId) async {
  final apiUrl =
      'http://192.168.77.122:3000/user/$userId'; // Replace with your API endpoint
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
  final apiUrl = 'http://192.168.77.122:3000/user/$userId/IsRegistered';
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
      'http://192.168.77.122:3000/registration/$userId/RegistrationDetail'; // Replace with your API endpoint
  try {
    final response = await http.get(Uri.parse(apiUrl));
    return response.body;
  } catch (e) {
    // Handle any network or request-related errors
    throw Exception('Exception: $e');
  }
}
