import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class StudentRegistrationProvider extends ChangeNotifier {
  String studentMobileNumber = '';
  String studentEmail = '';
  String parentName = '';
  String parentMobileNumber = '';
  String parentEmailId = '';
  String parentCurrentAddress = '';
  String semester = '';
  String year = '';
  String journalNUmber = '';
  String scholarship = '';
  String amount = '';
  XFile? _paymentScreenshot; // Add selectedImage property
  XFile? get selectedImage => _paymentScreenshot; // Getter for selectedImage

  void setSelectedImage(XFile? image) {
    _paymentScreenshot = image; // Setter for selectedImage
    notifyListeners(); // Notify listeners of the change
  }

  void printThings() {
    print(studentMobileNumber);
    print(studentEmail);
    print(parentName);
    print(parentMobileNumber);
    print(parentEmailId);
    print(parentCurrentAddress);
    print(semester);
    print(year);
    print(journalNUmber);
    print(_paymentScreenshot);
  }

  void clearData() {
    studentMobileNumber = '';
    studentEmail = '';
    parentName = '';
    parentMobileNumber = '';
    parentEmailId = '';
    parentCurrentAddress = '';
    semester = '';
    year = '';
    journalNUmber = '';
    scholarship = '';
    amount = '';
    _paymentScreenshot = null; // Add selectedImage property
  }
}
