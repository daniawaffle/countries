// import 'package:countries_app/screens/appointments/widgets/appointment_bottom_sheet.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// import '../../../models/apointments_model.dart';
// import '../appointment_bloc.dart';

// import 'alert_dialog.dart';

// import 'client_card.dart';

// class AppointmentDetail extends StatelessWidget {
//   final AppointmentsBloc bloc = AppointmentsBloc();
//   AppointmentDetail({super.key});
//   final Map<String, dynamic> appointmentJson = {
//     "id": 12,
//     "date_from": "2023-02-15T15:00:00",
//     "date_to": "2023-02-15T15:30:00",
//     "client_id": 1,
//     "mentor_id": 6,
//     "appointment_type": 1,
//     "price_before_discount": 12,
//     "price_after_discount": 12,
//     "state": 1,
//     "note_from_client": null,
//     "note_from_mentor": null,
//     "profile_img": "",
//     "suffixe_name": "Mrs.",
//     "first_name": "abed alrahman 6",
//     "last_name": "al haj hussain",
//     "category_id": 2,
//     "categoryName": "طب اطفال"
//   };

//   @override
//   Widget build(BuildContext context) {
//     final Appoint appointment = Appoint.fromJson(appointmentJson);
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   showAppoitmentDetails(context, appointment);
//                 },
//                 child: Text("show"))
//           ],
//         ),
//       ),
//     );
//   }

  
// }
