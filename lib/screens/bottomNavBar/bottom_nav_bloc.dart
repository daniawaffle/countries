import 'package:flutter/material.dart';

class BottomNav {
  final ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }
}
