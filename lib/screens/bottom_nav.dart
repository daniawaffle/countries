import 'package:flutter/material.dart';

import '../constants.dart';
import 'appointments/appointments_screen.dart';
import 'equiti/equiti_academy_screen.dart';

class BottomSheetNav extends StatefulWidget {
  const BottomSheetNav({super.key});

  @override
  State<BottomSheetNav> createState() => _BottomSheetNavState();
}

class _BottomSheetNavState extends State<BottomSheetNav> {
  final List<Widget> _pages = [
    const EquitiAcademyScreen(),
    const AppointmentsScreen()
  ];
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        selectedIconTheme: IconThemeData(
          color: primaryColor,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.menu,
              ),
              label: ''),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int i) {
    setState(() {
      _selectedIndex = i;
    });
  }
}
