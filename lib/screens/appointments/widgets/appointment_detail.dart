import 'package:countries_app/screens/appointments/widgets/appointment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/apointments_model.dart';
import '../appointment_bloc.dart';

import 'alert_dialog.dart';

import 'client_card.dart';

class AppointmentDetail extends StatelessWidget {
  final AppointmentsBloc bloc = AppointmentsBloc();
  AppointmentDetail({super.key});
  final Map<String, dynamic> appointmentJson = {
    "id": 13,
    "date_from": "2023-08-16T14:00:00",
    "date_to": "2023-08-16T15:00:00",
    "client_id": 1,
    "mentor_id": 2,
    "appointment_type": 1,
    "price_before_discount": 12,
    "price_after_discount": 12,
    "state": 1,
    "note_from_client": null,
    "note_from_mentor": null,
    "channel_id": "test13",
    "profile_img": "",
    "suffixe_name": "Dr.",
    "first_name": "abed alrahman 2",
    "last_name": "al haj hussain",
    "category_id": 1,
    "categoryName": "طب نفسي"
  };

  @override
  Widget build(BuildContext context) {
    final Appoint appointment = Appoint.fromJson(appointmentJson);
    final AppointmentsBloc bloc = AppointmentsBloc();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  showAppoitmentDetails(
                    appointment: appointment,
                    bloc: bloc,
                    context: context,
                  );
                },
                child: Text("show"))
          ],
        ),
      ),
    );
  }
}
