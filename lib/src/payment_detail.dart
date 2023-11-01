import 'package:http/http.dart' as http;

//To fetch payment details.
Future<String> getPaymentDetail(String userId) async {
  final apiUrl =
      'http://192.168.23.159:3000/payment/total-paid/$userId'; // Replace with your API endpoint
  try {
    final response = await http.get(Uri.parse(apiUrl));
    return response.body;
  } catch (e) {
    // Handle any network or request-related errors
    throw Exception('Exception: $e');
  }
}
