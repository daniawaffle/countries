import 'package:countries_app/screens/appointments/widgets/appointment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import '../../../models/apointments_model.dart';
import '../appointment_bloc.dart';

class AppointmentDetail extends StatelessWidget {
  final AppointmentsBloc bloc = AppointmentsBloc();
  AppointmentDetail({super.key});
  final Map<String, dynamic> appointmentJson = {
    "id": 15,
    "date_from": "2023-09-17T17:00:00",
    "date_to": "2023-09-17T18:00:00",
    "client_id": 1,
    "mentor_id": 2,
    "appointment_type": 1,
    "price_before_discount": 7,
    "price_after_discount": 7,
    "state": 1,
    "note_from_client": "this is Client note",
    "note_from_mentor": null,
    "channel_id": "test15",
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
                    appoint: appointment,
                    bloc: bloc,
                    context: context,
                  );
                },
                child: const Text("show"))
          ],
        ),
      ),
    );
  }
}
