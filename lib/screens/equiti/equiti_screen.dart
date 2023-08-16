import 'package:flutter/material.dart';

import '../../constants.dart';

class EquitiAcadmyScreen extends StatefulWidget {
  const EquitiAcadmyScreen({super.key});

  @override
  State<EquitiAcadmyScreen> createState() => _EquitiAcadmyScreenState();
}

class _EquitiAcadmyScreenState extends State<EquitiAcadmyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equiti acadamy'),
        backgroundColor: primaryColor,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 3,
              child: Container(
                color: Colors.amber,
              )),
          Expanded(
              flex: 7,
              child: Container(
                color: Colors.red,
              )),
        ],
      ),
    );
  }
}
