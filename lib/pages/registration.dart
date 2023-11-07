import 'package:flutter/material.dart';
import 'payment_section.dart';
import 'parents_details.dart';
import 'personal_details.dart';
import 'semester_info.dart';
import 'repeat_module.dart';

class Registration extends StatefulWidget {
  final String formType;
  const Registration(String s, {super.key, required this.formType});

  @override
  State<Registration> createState() => _MyRegistrationState(formType: formType);
}

class _MyRegistrationState extends State<Registration> {
  final PageController _pageController = PageController();
  final String formType;
  List<Widget> formPages = [];

  _MyRegistrationState({required this.formType});
  @override
  void initState() {
    if (formType == "regular") {
      formPages = [
        const PersonalDetails(),
        const ParentsDetails(),
        const SemesterDetails(),
      ];
    } else if (formType == "SelfFunding") {
      formPages = [
        const PersonalDetails(),
        const ParentsDetails(),
        const SemesterDetails(),
        const PaymentSection(),
      ];
    } else if (formType == "repeater") {
      formPages = [
        const PersonalDetails(),
        const ParentsDetails(),
        const SemesterDetails(),
        const RepeatModule(),
        const PaymentSection(),
      ];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: PageView(
        controller: _pageController,
        children: formPages,
      ),
    );
  }
}
