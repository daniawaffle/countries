import 'package:countries_app/screens/appointments/appointment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants.dart';
import '../../../enum/appoint_type.dart';
import '../../../models/apointments_model.dart';
import '../../../enum/appoint_state.dart';
import 'add_note.dart';
import 'alert_dialog.dart';
import 'client_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                      Text(
                        '${AppLocalizations.of(context)!.meetingText}\n${AppLocalizations.of(context)!.withText}',
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
                      Text(AppLocalizations.of(context)!.dateText),
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
                      Text(AppLocalizations.of(context)!.dayText),
                      Text(
                        DateFormat.EEEE().format(appoint.dateFrom!),
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
                      Text(AppLocalizations.of(context)!.sessionTypeText),
                      Text(
                        AppointmentTypeConverter.getTypeFromNumber(
                                appoint.appointmentType!)
                            .name,
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
                      Text(AppLocalizations.of(context)!.sessionTimeText),
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
                      Text(AppLocalizations.of(context)!.sessionDurationText),
                      Text(
                        AppointmentsBloc.formatDuration(
                            dateFrom: appoint.dateFrom!,
                            dateTo: appoint.dateTo!),
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
                      Text(AppLocalizations.of(context)!.sessionStatus),
                      Text(
                        AppointmentStatusConverter.getStatusFromNumber(
                                appoint.state!)
                            .name,
                        style: TextStyle(
                            color:
                                AppointmentStatusConverter.getStatusFromNumber(
                                        appoint.state!)
                                    .textColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(AppLocalizations.of(context)!.priceText),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            "${appoint.priceBeforeDiscount} ${AppLocalizations.of(context)!.jdText}"
                                .toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          Text(
                            " ${appoint.priceAfterDiscount} ${AppLocalizations.of(context)!.jdText}"
                                .toString(),
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
                      Text(AppLocalizations.of(context)!.clientNoteText),
                      Text(
                        appoint.noteFromClient ??
                            AppLocalizations.of(context)!.noNotesToShowText,
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
                      Text(AppLocalizations.of(context)!.mentorNoteText),
                      Text(
                        appoint.noteFromMentor ??
                            AppLocalizations.of(context)!.noNotesToShowText,
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
                        minimumSize: const MaterialStatePropertyAll<Size>(
                            Size.fromHeight(50)),
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            appoint.state == 1 ? primaryColor : Colors.grey)),
                    onPressed: appoint.state == 1
                        ? () {
                            displayTextInputDialog(
                                appointment: appoint,
                                bloc: bloc,
                                context: context);
                          }
                        : null,
                    child:
                        Text(AppLocalizations.of(context)!.addEditNotesText)),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: const MaterialStatePropertyAll<Size>(
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
                    child:
                        Text(AppLocalizations.of(context)!.cancelAttendText)),
              ],
            ),
          ),
        );
      });
}
