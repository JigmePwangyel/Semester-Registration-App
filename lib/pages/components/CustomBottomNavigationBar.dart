import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color.fromRGBO(0, 40, 168, 1),
          selectedItemColor: const Color.fromRGBO(255, 255, 255, 1),
          unselectedItemColor: Colors.grey,
          currentIndex: widget
              .selectedIndex, // Use the selectedIndex passed from MyHomePage
          onTap: widget
              .onItemTapped, // Use the onItemTapped callback passed from MyHomePage
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.attach_money), label: 'Receipt'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          ],
        ),
      ),
    );
  }
}
