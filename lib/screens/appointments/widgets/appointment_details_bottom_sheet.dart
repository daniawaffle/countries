import 'package:countries_app/constants.dart';
import 'package:countries_app/models/apointments_model.dart';
import 'package:flutter/material.dart';

import 'appointment_info.dart';
import 'client_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> appointmentDetailsBottomSheet(
    {required BuildContext context,
    required Appoint appoint,
    required Function() showNotes,
    required Function(int) cancel}) {
  return showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
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
                      const SizedBox(width: 0),
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
                ClientCard(appoint: appoint),
                AppointmentInfo(appoint: appoint),
                const Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: const MaterialStatePropertyAll<Size>(Size.fromHeight(50)),
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            appoint.state == 1 ? AppConstants.primaryColor : Colors.grey)),
                    onPressed: () => appoint.state == 1 ? showNotes() : null,
                    child: Text(AppLocalizations.of(context)!.addEditNotesText)),
                const SizedBox(height: 15),
                ElevatedButton(
                    style: ButtonStyle(
                        minimumSize: const MaterialStatePropertyAll<Size>(Size.fromHeight(50)),
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(appoint.state == 1 ? Colors.red : Colors.grey)),
                    onPressed: () => appoint.state == 1 ? cancel(appoint.id!) : null,
                    child: Text(AppLocalizations.of(context)!.cancelAttendText)),
              ],
            ),
          ),
        );
      });
}
