import 'package:flutter/material.dart';
import 'package:hiremi/home_page.dart';
import 'package:hiremi/profile_page.dart';

class BottomnavbarPage extends StatefulWidget {
  const BottomnavbarPage({super.key});

  @override
  State<BottomnavbarPage> createState() => _BottomnavbarPageState();
}

class _BottomnavbarPageState extends State<BottomnavbarPage> {
  var kprimaryColor =
      Color.fromARGB(255, 137, 2, 2); // Primary color for the design
  int currentIndex = 0; // Default index, make Home selected by default

  List<Widget> screens = [
    // Home page content with white background
    HomePage(),
    Scaffold(),
    Scaffold(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 137, 2, 2),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 5), // Shadow effect for better UI
          ],
        ),
        child: BottomAppBar(
          elevation: 0,
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Left side items with text
              BottomNavItem(
                icon: Icons.home,
                label: 'Home',
                isSelected: currentIndex == 0,
                onTap: () {
                  setState(() {
                    currentIndex = 0; // Home Icon selected
                  });
                },
              ),
              BottomNavItem(
                icon: Icons.article_outlined,
                label: 'Applies',
                isSelected: currentIndex == 1,
                onTap: () {
                  // setState(() {
                  //   currentIndex = 1;
                  // });
                },
              ),
              SizedBox(width: 30), // Space for the custom center widget
              BottomNavItem(
                icon: Icons.message_outlined,
                label: 'Queries',
                isSelected: currentIndex == 2,
                onTap: () {
                  // setState(() {
                  // currentIndex = 2;
                  // });
                },
              ),
              BottomNavItem(
                icon: Icons.person_outline,
                label: 'Profile',
                isSelected: currentIndex == 3,
                onTap: () {
                  setState(() {
                    currentIndex = 3; // Navigate to Profile Screen
                  });
                },
              ),
            ],
          ),
        ),
      ),

      // Custom floatingActionButton with primary color
      floatingActionButton: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white, // Background color
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.all_inclusive, // Infinity icon
              color: Color.fromARGB(255, 137, 2, 2),
              size: 30,
            ),
            Text(
              'HIREMI',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '360',
              style: TextStyle(
                  color: Color.fromARGB(255, 137, 2, 2),
                  fontSize: 12,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      // Add padding to prevent overlap with keyboard
      body: screens[currentIndex],
    );
  }
}

// Custom widget for Bottom Navigation Bar items
class BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  BottomNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 30,
            color: isSelected ? Color.fromARGB(255, 137, 2, 2) : Colors.black,
          ),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Color.fromARGB(255, 137, 2, 2) : Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
