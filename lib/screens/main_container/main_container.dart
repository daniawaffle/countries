import 'package:flutter/material.dart';

import '../../constants.dart';
import '../appointments/appointments_screen.dart';
import '../equiti/equiti_academy_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  final List<Widget> _pages = [const EquitiAcademyScreen(), const AppointmentsScreen()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[index],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppConstants.primaryColor,
        selectedIconTheme: IconThemeData(color: AppConstants.primaryColor),
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context)!.homeText,
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.menu), label: ''),
        ],
        onTap: (index) {
          index = index;
          setState(() {});
        },
      ),
    );
  }
}
