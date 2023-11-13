import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:semester_registration_app/models/RepeatModule.dart';
import 'dart:io';
import 'package:semester_registration_app/pages/MyHomePage.dart';
import 'package:semester_registration_app/provider/RepeaterCheckProvider.dart';
import 'package:semester_registration_app/provider/StoreRepeatModule.dart';
import 'package:semester_registration_app/provider/form_provider.dart';
import 'package:semester_registration_app/provider/registration_provider.dart';
import 'package:semester_registration_app/provider/repeat_module_provider.dart';
import 'package:semester_registration_app/provider/user_provider.dart';
import 'package:semester_registration_app/src/registration_form.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: false,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: CardContainer1(),
        ),
      ),
    );
  }
}

class CardContainer1 extends StatelessWidget {
  const CardContainer1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50),
      child: Column(
        children: [
          Card(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  child: const Detail(),
                ),
                const DisplayFees(),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const SendPaymentInfo(),
        ],
      ),
    );
  }
}

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      color: const Color.fromRGBO(0, 40, 168, 1),
      alignment: Alignment.center,
      child: const Column(
        children: [
          SizedBox(height: 15),
          Icon(
            Icons.info,
            size: 40,
            color: Colors.white,
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              "Transfer fees to account no: xxxxxxxxx \n\n In the remark, please enter your student number",
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 1),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DisplayFees extends StatelessWidget {
  const DisplayFees({super.key});

  @override
  Widget build(BuildContext context) {
    final String formType = context.watch<FormProvider>().formType;
    EnteredModuleProvider repeatModuleProvider =
        context.watch<EnteredModuleProvider>();
    StudentRegistrationProvider studentDataProvider =
        Provider.of<StudentRegistrationProvider>(context, listen: false);
    RepeaterCheckProvider repeaterProvider =
        context.read<RepeaterCheckProvider>();
    final typeOfRepeat = repeaterProvider.result;
    print("The type of repeat is $typeOfRepeat");

    int amount = 0;
    int tuitionFees = 45823;
    int hostelFees = 12500;
    int totalRepaetModule = repeatModuleProvider.enteredModules.length;
    String scholarship = studentDataProvider.scholarship;
    // Additional fees based on formType
    List<Widget> additionalTiles = [];
    UserProvider userProvider = context.watch();

    if (userProvider.isLoggedIn == false) {
      additionalTiles = [];
      amount = 0;
    }

    print("The type of repeat is $typeOfRepeat");
    //To handle calculation of fees
    if (formType == "SelfFunding" && totalRepaetModule == 0) {
      // Only tuition and hostel fees for self-funding
      additionalTiles = [
        ListTile(
          leading: Text("Tuition Fees"),
          trailing: Text("Nu. $tuitionFees"),
        ),
        ListTile(
          leading: Text("Hostel Fees"),
          trailing: Text("Nu. $hostelFees"),
        ),
      ];
      amount = tuitionFees + hostelFees;
      studentDataProvider.amount = amount.toString();
    } else if (formType == "repeater") {
      if (typeOfRepeat == "repeater") {
        //Only pays for that module
        print("This should be printed");
        for (int i = 0; i < totalRepaetModule; ++i) {
          additionalTiles.add(
            ListTile(
              leading: Text(repeatModuleProvider.enteredModules[i].moduleCode),
              trailing: Text("Nu. 9164"),
            ),
          );
        }
        amount = 9164 * totalRepaetModule;
        studentDataProvider.amount = amount.toString();
      } else if ((typeOfRepeat == "backpaper") && scholarship == "Government") {
        //Pays for modules only
        for (int i = 0; i < totalRepaetModule; ++i) {
          additionalTiles.add(
            ListTile(
              leading: Text(repeatModuleProvider.enteredModules[i].moduleCode),
              trailing: Text("Nu. 200"),
            ),
          );
        }
        amount = 200 * totalRepaetModule;
      } else if ((typeOfRepeat == "backpaper") &&
          scholarship == "Self Funding") {
        //Pays for repeat module and tuition fees.
        additionalTiles.add(
          ListTile(
            leading: Text("Tuition Fees"),
            trailing: Text("Nu. $tuitionFees"),
          ),
        );
        additionalTiles.add(
          ListTile(
            leading: Text("Hostel Fees"),
            trailing: Text("Nu. $hostelFees"),
          ),
        );
        for (int i = 0; i < totalRepaetModule; ++i) {
          additionalTiles.add(
            ListTile(
              leading: Text(repeatModuleProvider.enteredModules[i].moduleCode),
              trailing: Text("Nu. 200"),
            ),
          );
        }
        amount = 200 * totalRepaetModule + hostelFees + tuitionFees;
        studentDataProvider.amount = amount.toString();
      }
    }
    return ListView(
      shrinkWrap: true,
      children: [
        ...additionalTiles,
        Divider(),
        ListTile(
          leading: Text(
            "Total",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            "Nu. $amount",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class SendPaymentInfo extends StatefulWidget {
  const SendPaymentInfo({super.key});

  @override
  _SendPaymentInfoState createState() => _SendPaymentInfoState();
}

class _SendPaymentInfoState extends State<SendPaymentInfo> {
  final TextEditingController moduleCodeController = TextEditingController();
  XFile? selectedImage;
  String? errorText;

  Future<void> pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  // void showSuccessDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         contentPadding: const EdgeInsets.all(10),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             const Icon(
  //               Icons.check_circle,
  //               color: Color.fromARGB(209, 74, 209, 207),
  //               size: 70,
  //             ),
  //             const SizedBox(height: 10),
  //             const Text("You Have Been Successfully Registered"),
  //             const SizedBox(height: 20),
  //             ElevatedButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                     builder: (context) => const MyHomePage(),
  //                   ),
  //                 );
  //               },
  //               style: ElevatedButton.styleFrom(
  //                 backgroundColor: const Color.fromRGBO(255, 102, 0, 1.0),
  //                 minimumSize: const Size(150, 40),
  //               ),
  //               child: const Text('Back to Home'),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    //Provider to store details
    StudentRegistrationProvider studentDataProvider =
        Provider.of<StudentRegistrationProvider>(context, listen: false);
    EnteredModuleProvider repeatModuleProvider =
        context.watch<EnteredModuleProvider>();
    List<Module> addedModule = repeatModuleProvider.enteredModules;

    final String formType = context.watch<FormProvider>().formType;
    final String username = context.watch<UserProvider>().username;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        buildImageSelectionButton(),
        const SizedBox(height: 20),
        buildTextField(
          label: 'Journal Number',
          controller: moduleCodeController,
        ),
        if (errorText != null)
          Text(
            errorText!,
            style: const TextStyle(color: Colors.red),
          ),
        const SizedBox(height: 40),
        Center(
          child: SizedBox(
            width: 400,
            height: 40,
            child: ElevatedButton(
              onPressed: () async {
                if (validateJournalNumber()) {
                  //showSuccessDialog(context);
                }
                final journalNUmber = moduleCodeController.text;

                studentDataProvider.journalNUmber = journalNUmber;
                studentDataProvider.setSelectedImage(selectedImage);
                studentDataProvider.printThings();

                //Setting up the variables
                String studentMobileNumber =
                    studentDataProvider.studentMobileNumber;
                String studentEmail = studentDataProvider.studentEmail;
                String parentName = studentDataProvider.parentName;
                String parentMobileNumber =
                    studentDataProvider.parentMobileNumber;
                String parentEmailId = studentDataProvider.parentEmailId;
                String parentCurrentAddress =
                    studentDataProvider.parentCurrentAddress;
                String semester = studentDataProvider.semester;
                String year = studentDataProvider.year;
                String amount = studentDataProvider.amount;
                XFile? paymentScreenshot = selectedImage;

                print("Hello");
                print("The amount from provider is $amount");
                /**
               * Handle Form Submission
               */
                if (formType == "SelfFunding") {
                  //For Self Funding
                  print(parentMobileNumber);
                  int statuscode = await uploadSeflFinaceStudentData(
                    username,
                    studentMobileNumber,
                    studentEmail,
                    parentName,
                    parentMobileNumber,
                    parentEmailId,
                    parentCurrentAddress,
                    semester,
                    year,
                    journalNUmber,
                    amount,
                    paymentScreenshot,
                  );

                  if (statuscode == 200) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Thank You'),
                            content:
                                Text('You have been successfully Registered!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const MyHomePage();
                                      },
                                    ),
                                  );
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Registration Unsuccessfull'),
                            content: Text('Journal Number cannot be same'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        });
                  }
                } else {
                  //Will have repeat modules
                  List<String> moduleCodes = [];
                  for (Module module in addedModule) {
                    String moduleCode = module.moduleCode;
                    // Do something with the moduleCode, such as print it
                    moduleCodes.add(moduleCode);
                    print('Module Code2: $moduleCode');
                  }
                  int statusCode = await uploadRepeatStudentData(
                      username,
                      studentMobileNumber,
                      studentEmail,
                      parentName,
                      parentMobileNumber,
                      parentEmailId,
                      parentCurrentAddress,
                      semester,
                      year,
                      journalNUmber,
                      amount,
                      moduleCodes,
                      paymentScreenshot);
                  print("The status code is please be $statusCode");
                  if (statusCode == 200) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Thank You'),
                            content:
                                Text('You have been successfully Registered!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const MyHomePage();
                                      },
                                    ),
                                  );
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Registration Unsuccessfull'),
                            content: Text('Journal Number cannot be same'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        });
                  }
                }
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(255, 102, 0, 1.0),
                  ), // Set the background color

                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          5), // Adjust the border radius as needed
                    ),
                  )),
              child: const Text(
                'Submit',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget buildImageSelectionButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const Text('Add Screenshot', style: TextStyle(fontSize: 16)),
        SizedBox(
          height: 40,
          width: 200,
          child: ElevatedButton(
            onPressed: () {
              pickImage();
            },
            child: const Text('Select Image'),
          ),
        ),
        const SizedBox(height: 10),
        if (selectedImage != null)
          Image.file(
            File(selectedImage!.path),
            height: 150,
            width: 100,
          ),
      ],
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        TextField(
          style: const TextStyle(fontSize: 16),
          keyboardType: TextInputType.number, // Set the keyboard type to number
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly, // Allow only digits
          ],
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          controller: controller,
        ),
      ],
    );
  }

  bool validateJournalNumber() {
    final value = moduleCodeController.text;
    if (value.isEmpty) {
      setState(() {
        errorText = 'Journal Number is required.';
      });
      return false;
    } else if (int.tryParse(value) == null) {
      setState(() {
        errorText = 'Invalid Journal Number';
      });
      return false;
    } else if (selectedImage == null) {
      setState(() {
        errorText = 'Please select an image.';
      });
      return false;
    } else {
      setState(() {
        errorText = null;
      });
    }
    return true;
  }
}
