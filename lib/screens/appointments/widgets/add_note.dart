import 'package:countries_app/models/apointments_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> displayTextInputDialog(
    {required BuildContext context,
    required ValueNotifier<String> noteValuesNotifier,
    required Appoint appointment,
    required Function({required int appointmentID, required String note})
        addNote,
    required Function({required String note}) noteValidation,
    required GlobalKey<FormState> formKey,
    required TextEditingController noteController}) async {
  noteController.text = appointment.noteFromClient ?? "";
  return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
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
              validator: (value) => noteValidation(note: value!)
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
                  if (formKey.currentState!.validate()) {
                    addNote(
                            appointmentID: appointment.id!,
                            note: noteController.text)
                        .then((value) {
                      appointment.noteFromClient = noteController.text;
                      noteValuesNotifier.value = noteController.text;
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
