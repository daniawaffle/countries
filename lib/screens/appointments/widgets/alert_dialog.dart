import 'package:countries_app/screens/appointments/appointments_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef FutureCallback = Future<void> Function();
Future<void> showAlertDialog(
    {required VoidCallback onCancelPressed,
    required BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(AppLocalizations.of(context)!.cancelAppointmentText),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(AppLocalizations.of(context)!.alertDeletAppointText),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(AppLocalizations.of(context)!.noText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(AppLocalizations.of(context)!.yesText),
            onPressed: () {
              onCancelPressed();
              int count = 0;

              Navigator.of(context).popUntil((_) => count++ >= 3);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AppointmentsScreen()));
            },
          ),
        ],
      );
    },
  );
}
