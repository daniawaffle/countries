import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../main.dart';
import '../startup_bloc.dart';

class LanguageButton extends StatefulWidget {
  const LanguageButton({
    super.key,
    required this.startupBloc,
    required this.localLanguage,
    required this.label,
  });

  final StartupBloc startupBloc;
  final String localLanguage;
  final String label;
  @override
  State<LanguageButton> createState() => _LanguageButtonState();
}

class _LanguageButtonState extends State<LanguageButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(120, 45),
          backgroundColor: widget.startupBloc.getLan() == widget.localLanguage
              ? primaryColor
              : Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          )),
      onPressed: () async {
        widget.startupBloc.saveLanguageToHive(widget.localLanguage);
        if (mounted) MainApp.of(context)?.rebuild();
      },
      child: Text(
        widget.label,
        style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: widget.startupBloc.getLan() == widget.localLanguage
                ? secendaryColor
                : primaryColor),
      ),
    );
  }
}
