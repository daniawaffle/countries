import 'package:countries_app/models/apointments_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../appointment_bloc.dart';

Future<void> displayTextInputDialog(
    {required BuildContext context,
    required Appoint appointment,
    required AppointmentsBloc bloc}) async {
  bloc.saveInNoteTextController(appointment.noteFromClient);
  return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: bloc.addNoteFormKey,
          child: AlertDialog(
            title: Text(AppLocalizations.of(context)!.addNotesText),
            content: TextFormField(
              onChanged: (value) {
                bloc.note = value;
              },
              controller: bloc.noteTextFieldController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.addNotesText,
              ),
              validator: (value) => bloc.validateAddNoteField(note: value)
                  ? null
                  : AppLocalizations.of(context)!.alertEmptyNoteText,
            ),
            actions: <Widget>[
              MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text(AppLocalizations.of(context)!.cancelText),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              MaterialButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text(AppLocalizations.of(context)!.okText),
                onPressed: () {
                  if (bloc.addNoteFormKey.currentState!.validate()) {
                    bloc
                        .addAppointmentNote(
                            appointmentID: appointment.id!, note: bloc.note!)
                        .then((value) {
                      appointment.noteFromClient = bloc.note;
                      bloc.updateNoteValuesNotifier(bloc.note!);
                    });
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      });
}
