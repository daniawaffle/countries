import 'package:flutter/material.dart';
import '../../../constants.dart';

class LanguageButton extends StatelessWidget {
  final String localLanguage;
  final String label;
  final String currentLanguage;
  final Function() saveLanguage;

  const LanguageButton({
    super.key,
    required this.localLanguage,
    required this.label,
    required this.currentLanguage,
    required this.saveLanguage,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(120, 45),
          backgroundColor: currentLanguage == localLanguage ? AppConstants.primaryColor : Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          )),
      onPressed: () => saveLanguage(),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: currentLanguage == localLanguage ? AppConstants.secendaryColor : AppConstants.primaryColor),
      ),
    );
  }
}
