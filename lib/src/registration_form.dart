import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/models/programmeModel.dart';
import 'package:semester_registration_app/provider/RepeaterCheckProvider.dart';
import 'package:semester_registration_app/provider/form_provider.dart';
import 'package:semester_registration_app/provider/programme_provider.dart';
import 'package:semester_registration_app/provider/repeat_module_provider.dart';
import '../models/PersonalDetailsModel.dart';

//To fetch form type.
Future<void> getFormType(BuildContext context, String userId) async {
  final apiUrl =
      'http://192.168.234.122:3000/registration/$userId/form'; // Replace with your API endpoint
  // Get the ProgrammeProvider and set the programmeName
  final formProvider = context.read<FormProvider>();
  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      String formValue = data['form'].toString();
      print(formValue);
      formProvider.setFormType(formValue);
    } else if (response.statusCode == 401) {
      formProvider.setFormType("NotEligible");
    } else {
      throw Exception('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    // Handle any network or request-related errors
    throw Exception('Exception: $e');
  }
}

//For Personal Details Page
Future<Student> fetchStudentData(String userId) async {
  final apiUrl =
      'http://192.168.234.122:3000/registration/$userId/PersonalDetail'; // Replace with your API endpoint

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    return Student.fromJson(data);
  } else {
    throw Exception('Failed to fetch data: ${response.statusCode}');
  }
}

//For Semester Detail page
Future<void> fetchAndSetProgramme(BuildContext context, String userId) async {
  final apiUrl = 'http://192.168.234.122:3000/registration/$userId/programme';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final programmeName = data['departmentName'];

    // Get the ProgrammeProvider and set the programmeName
    final programmeProvider = context.read<ProgrammeProvider>();
    programmeProvider.setProgrammeName(programmeName);
  } else {
    throw Exception('Failed to fetch data: ${response.statusCode}');
  }
}

//To fetch Repeat Module
Future<void> fetchAndTransformData(BuildContext context, String userId) async {
  final response = await http.get(Uri.parse(
      'http://192.168.234.122:3000/registration/$userId/repeatmodule'));

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseData = json.decode(response.body);
    Map<String, String> moduleMap = Map<String, String>.from(responseData);
    final repeatModuleProvider = context.read<RepeatModuleProvider>();
    repeatModuleProvider.setData(moduleMap);
  } else {
    throw Exception('Failed to load module data');
  }
}

//For uploading details of a normal Student
Future<int> uploadRegularStudentData(
    String username,
    String studentMobileNumber,
    String studentEmail,
    String semester,
    String parentName,
    String parentMobileNumber,
    String parentEmailId,
    String parentCurrentAddress,
    String year) async {
  final apiUrl =
      'http://192.168.234.122:3000/registration/$username/insert-regular';

  try {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'studentMobileNumber': studentMobileNumber,
        'studentEmail': studentEmail,
        'semester': semester,
        'year': year,
        'parentName': parentName,
        'parentEmailId': parentEmailId,
        'parentCurrentAddress': parentCurrentAddress,
        'parentMobileNumber': parentMobileNumber,
      }),
    );

    if (response.statusCode == 200) {
      print('Data uploaded successfully');
      print('Inserted ID: ${jsonDecode(response.body)['insertedId']}');
      return (response.statusCode);
    } else {
      print('Failed to upload data. Status code: ${response.statusCode}');
      print('Response: ${response.body}');
      return (response.statusCode);
    }
  } catch (error) {
    print('Error uploading data: $error');
    return (500);
  }
}

//To fetch repeater or backpaper
Future<void> checkRepeaterStatus(String username, BuildContext context) async {
  try {
    final response = await http.get(Uri.parse(
        'http://192.168.234.122:3000/registration/$username/checkRepeater'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final result = data['result'] ?? '';

      // Assuming you have a RepeaterCheckProvider instance
      final repeaterProvider = context.read<RepeaterCheckProvider>();
      repeaterProvider.setResult(result);
      print("The backend says: ${repeaterProvider.result}");
    } else {
      print('Error: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
  }
}

//For Self Finance Student
Future<int> uploadSeflFinaceStudentData(
    String username,
    String studentMobileNumber,
    String studentEmail,
    String parentName,
    String parentMobileNumber,
    String parentEmailId,
    String parentCurrentAddress,
    String semester,
    String year,
    String journalNUmber,
    String amount,
    XFile? paymentScreenshot) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://192.168.234.122:3000/registration/$username/self-finance'),
    );

    //Add data to the request
    request.fields['journalNumber'] = journalNUmber;
    request.fields['studentMobileNumber'] = studentMobileNumber;
    request.fields['studentEmail'] = studentEmail;
    request.fields['parentName'] = parentName;
    request.fields['parentMobileNumber'] = parentMobileNumber;
    request.fields['parentEmailId'] = parentEmailId;
    request.fields['parentCurrentAddress'] = parentCurrentAddress;
    request.fields['semester'] = semester;
    request.fields['year'] = year;
    request.fields['journalNUmber'] = journalNUmber;
    request.fields['amount'] = amount;

    print(parentEmailId);

    // Add image file if available
    if (paymentScreenshot != null) {
      var imageBytes = await paymentScreenshot.readAsBytes();
      var imageStream = http.ByteStream.fromBytes(imageBytes);
      var length = imageBytes.length;

      request.files.add(
        http.MultipartFile(
          'image',
          imageStream,
          length,
          filename: 'filename.jpg', // Provide a filename for the image
        ),
      );
    }

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('Data uploaded successfully');
      return (200);
    } else {
      print('Failed to upload data. Status code: ${response.statusCode}');
      return (400);
    }
  } catch (error) {
    print('Error uploading data: $error');
    return (500);
    //return (500);
  }
}

Future<int> uploadRepeatStudentData(
    String username,
    String studentMobileNumber,
    String studentEmail,
    String parentName,
    String parentMobileNumber,
    String parentEmailId,
    String parentCurrentAddress,
    String semester,
    String year,
    String journalNumber,
    String amount,
    List<String> moduleCodes,
    XFile? paymentScreenshot) async {
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://192.168.234.122:3000/registration/$username/repeater'),
    );

    // Add data to the request
    request.fields['studentMobileNumber'] = studentMobileNumber;
    request.fields['studentEmail'] = studentEmail;
    request.fields['parentName'] = parentName;
    request.fields['parentMobileNumber'] = parentMobileNumber;
    request.fields['parentEmailId'] = parentEmailId;
    request.fields['parentCurrentAddress'] = parentCurrentAddress;
    request.fields['semester'] = semester;
    request.fields['year'] = year;
    request.fields['journalNUmber'] = journalNumber;
    request.fields['amount'] = amount;

    // Convert the list to a JSON string and add it to the request
    request.fields['moduleCodes'] = jsonEncode(moduleCodes);

    print(parentEmailId);

    // Add image file if available
    if (paymentScreenshot != null) {
      var imageBytes = await paymentScreenshot.readAsBytes();
      var imageStream = http.ByteStream.fromBytes(imageBytes);
      var length = imageBytes.length;

      request.files.add(
        http.MultipartFile(
          'image',
          imageStream,
          length,
          filename: 'filename.jpg', // Provide a filename for the image
        ),
      );
    }

    var response = await http.Response.fromStream(await request.send());

    if (response.statusCode == 200) {
      print('Data uploaded successfully');
      return 200;
    } else {
      print('Failed to upload data. Status code: ${response.statusCode}');
      return 400;
    }
  } catch (error) {
    print('Error uploading data: $error');
    return 500;
  }
}
