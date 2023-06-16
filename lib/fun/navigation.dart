import 'package:flutter/material.dart';

import '../pages/TasksPage.dart';
import '../pages/homePage.dart';
import '../pages/profilePage.dart';
import '../pages/progressPage.dart';

class BottomNavigation extends StatefulWidget {

  BottomNavigation({super.key, required this.currentIndex});
  int currentIndex;
  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

const List<Widget> screens = [
  ProgressPage(),
  HomePage(),
  TasksPage(),
  ProfilePage()
];

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.deepPurpleAccent,
        currentIndex: widget.currentIndex,
        onTap: (index) {
          setState(() {
            widget.currentIndex = index;
          });
        },
        items: const [

          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: "Progress"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.timeline), label: "Habits"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
    );
  }
}
