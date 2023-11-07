import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:semester_registration_app/models/programmeModel.dart';
import 'package:semester_registration_app/provider/form_provider.dart';
import 'package:semester_registration_app/provider/programme_provider.dart';
import '../models/PersonalDetailsModel.dart';

//To fetch form type.
Future<void> getFormType(BuildContext context, String userId) async {
  final apiUrl =
      'http://192.168.214.159:3000/registration/$userId/form'; // Replace with your API endpoint
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
      'http://192.168.214.159:3000/registration/$userId/PersonalDetail'; // Replace with your API endpoint

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
  final apiUrl = 'http://192.168.214.159:3000/registration/$userId/programme';

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
Future<Map<String, String>> fetchAndTransformData(String userId) async {
  final response = await http.get(Uri.parse(
      'http://192.168.214.159:3000/registration/$userId/repeatmodule'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    final Map<String, String> moduleMap = {};

    for (var item in jsonData) {
      String moduleCode = item["ModuleCode"];
      String moduleName = item["ModuleName"];
      moduleMap[moduleName] = moduleCode;
    }

    return moduleMap;
  } else {
    throw Exception('Failed to load module data');
  }
}
