import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showAlertDialog(
    {required Function(int id) cancelAppointment,
    required Function() fetchAppointments,
    required int appoitmentID,
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
              cancelAppointment(appoitmentID);
              int count = 0;
              fetchAppointments();
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
          ),
        ],
      );
    },
  );
}
