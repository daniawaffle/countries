import 'package:countries_app/models/apointments_model.dart';
import 'package:countries_app/screens/appointments/appointment_bloc.dart';
import 'package:flutter/material.dart';

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
          title: const Text('TextField in Dialog'),
          content: TextField(
            onChanged: (value) {
              valueText = value;
            },
            controller: textFieldController,
            decoration: const InputDecoration(hintText: "Text Field in Dialog"),
          ),
          actions: <Widget>[
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MaterialButton(
              color: Colors.green,
              textColor: Colors.white,
              child: const Text('OK'),
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
