import 'package:countries_app/screens/appointments/appointment_bloc.dart';
import 'package:flutter/material.dart';

Future<void> showAlertDialog(
    {required BuildContext context,
    required AppointmentsBloc bloc,
    required int appointmentID}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        // <-- SEE HERE
        title: const Text('Cancel Appointment'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('Are you sure want to cancel the appointment?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () {
              bloc.cancelAppointment(appointmentID);
              // Navigator.of(context).pop();
              int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);
            },
          ),
        ],
      );
    },
  );
}
