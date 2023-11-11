import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/FetchPaymentDetailModel.dart';

//To fetch payment details.
Future<PaymentResponse> getPaymentDetail(String userId) async {
  final apiUrl =
      'http://192.168.234.122:3000/payment/total-paid/$userId'; // Replace with your API endpoint
  try {
    final response = await http.get(Uri.parse(apiUrl));
    final Map<String, dynamic> jsonData = json.decode(response.body);
    return PaymentResponse.fromJson(jsonData);
  } catch (e) {
    // Handle any network or request-related errors
    throw Exception('Exception: $e');
  }
}
