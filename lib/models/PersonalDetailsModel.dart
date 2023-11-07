class Student {
  final String studentName;
  final int stdID;
  final String scholarship;

  Student({
    required this.studentName,
    required this.stdID,
    required this.scholarship,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentName: json['studentName'],
      stdID: json['stdID'],
      scholarship: json['scholarship'],
    );
  }
}
