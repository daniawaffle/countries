import 'package:countries_app/models/apointments_model.dart';
import 'package:countries_app/screens/appointments/appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> displayTextInputDialog(
    {required BuildContext context,
    required AppointmentsBloc bloc,
    required Appoint appointment}) async {
  final TextEditingController textFieldController = TextEditingController();

  String? valueText;
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.addNotesText),
          content: TextField(
            onChanged: (value) {
              valueText = value;
            },
            controller: textFieldController,
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.addNotesText),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text(AppLocalizations.of(context)!.cancelText),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              color: Colors.green,
              textColor: Colors.white,
              child: Text(AppLocalizations.of(context)!.okText),
              onPressed: () {
                bloc.addAppointmentNote(
                    appointmentID: appointment.id!, note: valueText!);
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}
