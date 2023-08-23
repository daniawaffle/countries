import 'package:countries_app/screens/appointments/appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/apointments_model.dart';
import 'add_note.dart';
import 'alert_dialog.dart';
import 'client_card.dart';

Future<void> showAppoitmentDetails(
    {required BuildContext context,
    required Appoint appoint,
    required AppointmentsBloc bloc}) {
  return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            // decoration: const BoxDecoration(
            //     borderRadius: BorderRadius.only(
            //         topLeft: Radius.circular(25.0),
            //         topRight: Radius.circular(25.0))),
            height: MediaQuery.of(context).size.height * 0.75,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
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
                  ClientCard(
                    appoint: appoint,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("Date:"),
                        Text(
                          DateFormat("yyyy-M-d").format(appoint.dateFrom!),
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
                          DateFormat.EEEE().format(appoint.dateFrom!),
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
                          DateFormat.jm().format(appoint.dateFrom!),
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
                          AppointmentsBloc.formatDuration(
                              dateFrom: appoint.dateFrom!,
                              dateTo: appoint.dateTo!),
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
                              "${appoint.priceBeforeDiscount} JD".toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              " ${appoint.priceAfterDiscount} JD".toString(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                          appoint.noteFromClient ?? "No Notes to show",
                          style: TextStyle(
                              color: appoint.noteFromClient == null
                                  ? Colors.grey
                                  : Colors.black,
                              fontWeight: appoint.noteFromClient == null
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
                          appoint.noteFromMentor ?? "No Notes to show",
                          style: TextStyle(
                              color: appoint.noteFromMentor == null
                                  ? Colors.grey
                                  : Colors.black,
                              fontWeight: appoint.noteFromMentor == null
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
                      style: ButtonStyle(
                          minimumSize: MaterialStatePropertyAll<Size>(
                              Size.fromHeight(50)),
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              appoint.state == 1 ? Colors.red : Colors.grey)),
                      onPressed: appoint.state == 1
                          ? () {
                              displayTextInputDialog(
                                  appointment: appoint,
                                  bloc: bloc,
                                  context: context);
                            }
                          : null,
                      child: Text("Add / Edit Notes")),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          minimumSize: MaterialStatePropertyAll<Size>(
                              Size.fromHeight(50)),
                          backgroundColor: MaterialStatePropertyAll<Color>(
                              appoint.state == 1 ? Colors.red : Colors.grey)),
                      onPressed: appoint.state == 1
                          ? () {
                              showAlertDialog(
                                context: context,
                                appointmentID: appoint.id!,
                                bloc: bloc,
                              );
                            }
                          : null,
                      child: Text("Cancel Attend")),
                ],
              ),
            ),
          ),
        );
      });
}
