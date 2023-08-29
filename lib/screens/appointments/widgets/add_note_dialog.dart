import 'package:countries_app/models/apointments_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> addNoteDialog(
    {required BuildContext context,
    required Appoint appointment,
    required Function(int appointmentID, String note) addNote,
    required Function({required String note}) noteValidation}) async {
  TextEditingController noteController = TextEditingController();
  final addNoteFormKey = GlobalKey<FormState>();

  return showDialog(
      context: context,
      builder: (context) {
        noteController.text = appointment.noteFromClient ?? "";
        return Form(
          key: addNoteFormKey,
          child: AlertDialog(
            title: Text(AppLocalizations.of(context)!.addNotesText),
            content: TextFormField(
              onChanged: (value) {
                noteController.text = value;
              },
              controller: noteController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.addNotesText,
              ),
              validator: (value) =>
                  noteValidation(note: value!) ? null : AppLocalizations.of(context)!.alertEmptyNoteText,
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
                  if (addNoteFormKey.currentState!.validate()) {
                    addNote(appointment.id!, noteController.text);

                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      });
}
