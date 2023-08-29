import 'package:countries_app/screens/appointments/appointment_bloc.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/apointments_model.dart';
import 'add_note.dart';
import 'alert_dialog.dart';
import 'appointment_info.dart';
import 'client_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> showAppoitmentDetails(
    {required BuildContext context,
    required Appoint appoint,
    required AppointmentsBloc bloc}) {
  return showModalBottomSheet<void>(
      isScrollControlled: false,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                AppointmentInfo(
                  noteValuesNotifier: bloc.noteValuesNotifier,
                  appointmentsBloc: bloc,
                  appoint: appoint,
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
                            appoint.state == 1
                                ? AppConstants.primaryColor
                                : Colors.grey)),
                    onPressed: appoint.state == 1
                        ? () {
                            displayTextInputDialog(
                                noteValuesNotifier: bloc.noteValuesNotifier,
                                formKey: bloc.addNoteFormKey,
                                noteController: bloc.noteTextFieldController,
                                appointment: appoint,
                                noteValidation: bloc.validateAddNoteField,
                                addNote: bloc.addAppointmentNote,
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
                                fetchAppointments: bloc.fetchAppointments,
                                context: context,
                                cancelAppointment: bloc.cancelAppointment,
                                appoitmentID: appoint.id!);
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
