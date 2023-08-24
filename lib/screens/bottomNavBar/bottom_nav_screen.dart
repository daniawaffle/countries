import 'package:flutter/material.dart';

import '../../constants.dart';
import '../appointments/appointments_screen.dart';
import '../equiti/equiti_academy_screen.dart';
import 'bottom_nav_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomSheetNav extends StatefulWidget {
  const BottomSheetNav({super.key});

  @override
  State<BottomSheetNav> createState() => _BottomSheetNavState();
}

class _BottomSheetNavState extends State<BottomSheetNav> {
  final BottomNav navBloc = BottomNav();

  final List<Widget> _pages = [
    const EquitiAcademyScreen(),
    const AppointmentsScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: navBloc.selectedIndex,
        builder: (context, index, _) {
          return Scaffold(
            body: _pages[index],
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: AppConstants.primaryColor,
              selectedIconTheme: IconThemeData(
                color: AppConstants.primaryColor,
              ),
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.home,
                  ),
                  label: AppLocalizations.of(context)!.homeText,
                ),
                const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.menu,
                    ),
                    label: ''),
              ],
              currentIndex: navBloc.selectedIndex.value,
              onTap: (index) {
                navBloc.selectedIndex.value = index;
                navBloc.onItemTapped(index);
              },
            ),
          );
        });
  }
}
