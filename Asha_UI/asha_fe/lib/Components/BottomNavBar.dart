import 'package:flutter/material.dart';

class AshaBottomNavBar extends StatefulWidget {
  @override
  State<AshaBottomNavBar> createState() => _AshaBottomNavBarState();
}

class _AshaBottomNavBarState extends State<AshaBottomNavBar> {
  final int selectedIndex = 0;
  // Move this line outside the build method
  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      print(index);
    }

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_circle_left_outlined),
          label: 'Previous',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.arrow_circle_right_outlined),
          label: 'Next',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
