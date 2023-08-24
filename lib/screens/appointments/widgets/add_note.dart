import 'package:countries_app/models/apointments_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef FutureVoidCallbackWithParams = Future<void> Function(
    {required int appointmentID, required String note});

Future<void> displayTextInputDialog(
    {required BuildContext context,
    required FutureVoidCallbackWithParams onOkPressed,
    required Appoint appointment}) async {
  final TextEditingController textFieldController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? valueText;
  return showDialog(
      context: context,
      builder: (context) {
        return Form(
          key: formKey,
          child: AlertDialog(
            title: Text(AppLocalizations.of(context)!.addNotesText),
            content: TextFormField(
              onChanged: (value) {
                valueText = value;
              },
              controller: textFieldController,
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.addNotesText,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return AppLocalizations.of(context)!.alertEmptyNoteText;
                }
                return null;
              },
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
                    onOkPressed(
                        appointmentID: appointment.id!, note: valueText!);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      });
}
