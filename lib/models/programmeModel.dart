class programme {
  final String programmeName;

  programme({
    required this.programmeName,
  });

  factory programme.fromJson(Map<String, dynamic> json) {
    return programme(
      programmeName: json['departmentName'],
    );
  }
}
