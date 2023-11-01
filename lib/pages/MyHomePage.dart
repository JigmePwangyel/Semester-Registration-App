import 'package:flutter/material.dart';
import 'package:semester_registration_app/pages/HomeTab.dart';
import 'package:semester_registration_app/pages/InfoTab.dart';
import 'package:semester_registration_app/pages/ReceiptTab.dart';
import 'components/sideMenu.dart';
import 'components/CustomBottomNavigationBar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  AppBar _getAppBar(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return AppBar(title: const Text('Home Page'));
      case 1:
        return AppBar(title: const Text('Receipt Page'));
      case 2:
        return AppBar(title: const Text('Info Page'));
      default:
        return AppBar(title: const Text('Default App Bar'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const sideMenu(),
      appBar: _getAppBar(_selectedIndex),
      body: PageView(
        controller: _pageController,
        children: const [
          HomePage(),
          ReceiptPage(),
          InfoPage(),
        ],
        onPageChanged: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
