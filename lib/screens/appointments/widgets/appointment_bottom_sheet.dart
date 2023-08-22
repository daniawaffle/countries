import 'package:countries_app/screens/appointments/appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/apointments_model.dart';
import 'add_note.dart';
import 'alert_dialog.dart';
import 'client_card.dart';

Future<void> showAppoitmentDetails(
    {required BuildContext context,
    required Appoint appointment,
    required AppointmentsBloc bloc}) {
  return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      builder: (BuildContext context) {
        return Container(
          // decoration: const BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(25.0),
          //         topRight: Radius.circular(25.0))),
          height: MediaQuery.of(context).size.height * 0.75,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 0,
                      ),
                      const Text(
                        "Meeting\nwith",
                        textAlign: TextAlign.center,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close))
                    ],
                  ),
                ),
                ClientCard(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Date:"),
                      Text(
                        DateFormat("yyyy-M-d").format(appointment.dateFrom!),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Day:"),
                      Text(
                        DateFormat.EEEE().format(appointment.dateFrom!),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Session Type:"),
                      Text(
                        "Scheduled",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Session Time:"),
                      Text(
                        DateFormat.jm().format(appointment.dateFrom!),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Session Duration:"),
                      Text(
                        bloc.formatDuration(
                            dateFrom: appointment.dateFrom!,
                            dateTo: appointment.dateTo!),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Session Status:"),
                      Text(
                        "Active",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Price:"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "${appointment.priceBeforeDiscount} JD".toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            " ${appointment.priceAfterDiscount} JD".toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Client Note:"),
                      Text(
                        appointment.noteFromClient ?? "No Notes to show",
                        style: TextStyle(
                            color: appointment.noteFromClient == null
                                ? Colors.grey
                                : Colors.black,
                            fontWeight: appointment.noteFromClient == null
                                ? FontWeight.normal
                                : FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Mentor Note:"),
                      Text(
                        appointment.noteFromMentor ?? "No Notes to show",
                        style: TextStyle(
                            color: appointment.noteFromMentor == null
                                ? Colors.grey
                                : Colors.black,
                            fontWeight: appointment.noteFromMentor == null
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
                            MaterialStatePropertyAll<Size>(Size.fromHeight(50)),
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.blue)),
                    onPressed: () {
                      displayTextInputDialog(
                          appointmentID: appointment.id!,
                          bloc: bloc,
                          context: context);
                    },
                    child: Text("Add / Edit Notes")),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        minimumSize:
                            MaterialStatePropertyAll<Size>(Size.fromHeight(50)),
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.red)),
                    onPressed: () => showAlertDialog(
                          context: context,
                          appointmentID: appointment.id!,
                          bloc: bloc,
                        ),
                    child: Text("Cancel Attend")),
              ],
            ),
          ),
        );
      });
}
