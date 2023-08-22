import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/apointments_model.dart';
import '../../appointment_detail/widgets/client_card.dart';
import '../appointment_bloc.dart';

class AppointmentDetail extends StatelessWidget {
  final AppointmentsBloc bloc = AppointmentsBloc();
  AppointmentDetail({super.key});
  final Map<String, dynamic> appointmentJson = {
    "id": 12,
    "date_from": "2023-02-15T15:00:00",
    "date_to": "2023-02-15T15:30:00",
    "client_id": 1,
    "mentor_id": 6,
    "appointment_type": 1,
    "price_before_discount": 12,
    "price_after_discount": 12,
    "state": 1,
    "note_from_client": null,
    "note_from_mentor": null,
    "profile_img": "",
    "suffixe_name": "Mrs.",
    "first_name": "abed alrahman 6",
    "last_name": "al haj hussain",
    "category_id": 2,
    "categoryName": "طب اطفال"
  };

  @override
  Widget build(BuildContext context) {
    final Appoint appointment = Appoint.fromJson(appointmentJson);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0))),
                      builder: (BuildContext context) {
                        return Container(
                          // decoration: const BoxDecoration(
                          //     borderRadius: BorderRadius.only(
                          //         topLeft: Radius.circular(25.0),
                          //         topRight: Radius.circular(25.0))),
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Meeting\nwith",
                                        textAlign: TextAlign.center,
                                      ),
                                      Icon(Icons.close)
                                    ],
                                  ),
                                ),
                                ClientCard(),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Date:"),
                                      Text(
                                        DateFormat("yyyy-M-d")
                                            .format(appointment.dateFrom!),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Day:"),
                                      Text(
                                        DateFormat.EEEE()
                                            .format(appointment.dateFrom!),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Session Type:"),
                                      Text(
                                        "Scheduled",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Session Time:"),
                                      Text(
                                        DateFormat.jm()
                                            .format(appointment.dateFrom!),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Session Duration:"),
                                      Text(
                                        bloc.formatDuration(
                                            dateFrom: appointment.dateFrom!,
                                            dateTo: appointment.dateTo!),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Session Status:"),
                                      Text(
                                        "Active",
                                        style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Price:"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            "${appointment.priceBeforeDiscount} JD"
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                            ),
                                          ),
                                          Text(
                                            " ${appointment.priceAfterDiscount} JD"
                                                .toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Client Note:"),
                                      Text(
                                        appointment.noteFromClient ??
                                            "No Notes to show",
                                        style: TextStyle(
                                            color: appointment.noteFromClient ==
                                                    null
                                                ? Colors.grey
                                                : Colors.black,
                                            fontWeight:
                                                appointment.noteFromClient ==
                                                        null
                                                    ? FontWeight.normal
                                                    : FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("Mentor Note:"),
                                      Text(
                                        appointment.noteFromMentor ??
                                            "No Notes to show",
                                        style: TextStyle(
                                            color: appointment.noteFromMentor ==
                                                    null
                                                ? Colors.grey
                                                : Colors.black,
                                            fontWeight:
                                                appointment.noteFromMentor ==
                                                        null
                                                    ? FontWeight.normal
                                                    : FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                ),
                                ElevatedButton(
                                    style: const ButtonStyle(
                                        minimumSize:
                                            MaterialStatePropertyAll<Size>(
                                                Size.fromHeight(50)),
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                Colors.blue)),
                                    onPressed: () {},
                                    child: Text("Add / Edit Notes")),
                                SizedBox(
                                  height: 15,
                                ),
                                ElevatedButton(
                                    style: const ButtonStyle(
                                        minimumSize:
                                            MaterialStatePropertyAll<Size>(
                                                Size.fromHeight(50)),
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                Colors.red)),
                                    onPressed: () {},
                                    child: Text("Cancel Attend")),
                              ],
                            ),
                          ),
                        );
                      });
                },
                child: Text("show"))
          ],
        ),
      ),
    );
  }
}
