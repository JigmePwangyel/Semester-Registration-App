import 'dart:convert';

class StudentRegistrationDetail {
  final String studentName;
  final String stdID;
  final String dateOfBirth;
  final String mobileNumber;

  StudentRegistrationDetail({
    required this.studentName,
    required this.stdID,
    required this.dateOfBirth,
    required this.mobileNumber,
  });
}

class ParentDetail {
  final String parentName;
  final String parentEmail;
  final String currentAddress;
  final String parentMobile;

  ParentDetail({
    required this.parentName,
    required this.parentEmail,
    required this.currentAddress,
    required this.parentMobile,
  });
}

class SemesterDetail {
  final String departmentName;
  final String year;
  final String semester;

  SemesterDetail({
    required this.departmentName,
    required this.year,
    required this.semester,
  });
}

// Function to parse the JSON response and return a StudentRegistrationDetail object
StudentRegistrationDetail parseStudentRegistrationDetail(String apiResponse) {
  final jsonData = json.decode(apiResponse);

  return StudentRegistrationDetail(
    studentName: jsonData['StudentRegistrationDetial'][0]['studentName'],
    stdID: jsonData['StudentRegistrationDetial'][0]['stdID'].toString(),
    dateOfBirth: jsonData['StudentRegistrationDetial'][0]['date_of_birth'],
    mobileNumber: jsonData['StudentRegistrationDetial'][0]['mobileNumber'],
  );
}

// Function to parse the JSON response and return a Parent object
ParentDetail parseParentDetail(String apiResponse) {
  final jsonData = json.decode(apiResponse);

  return ParentDetail(
    parentName: jsonData['ParentDetail'][0]['parentName'],
    parentEmail: jsonData['ParentDetail'][0]['parentEmail'],
    currentAddress: jsonData['ParentDetail'][0]['current_address'],
    parentMobile: jsonData['ParentDetail'][0]['parentMobile'].toString(),
  );
}

// Function to parse the JSON response and return a SemesterDetail object
SemesterDetail parseSemesterDetail(String apiResponse) {
  final jsonData = json.decode(apiResponse);

  return SemesterDetail(
    departmentName: jsonData['SemesterDetail'][0]['departmentName'],
    year: jsonData['SemesterDetail'][0]['year'],
    semester: jsonData['SemesterDetail'][0]['semester'],
  );
}
