import 'package:countries_app/utils/formater.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../enum/appoint_state.dart';
import '../../../enum/appoint_type.dart';
import '../../../models/apointments_model.dart';

class AppointmentInfo extends StatefulWidget {
  final Appoint appoint;
  const AppointmentInfo({super.key, required this.appoint});

  @override
  State<AppointmentInfo> createState() => AppointmentInfoState();
}

class AppointmentInfoState extends State<AppointmentInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.dateText),
              Text(
                DateFormat("yyyy-M-d").format(widget.appoint.dateFrom!),
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
                DateFormat.EEEE().format(widget.appoint.dateFrom!),
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
                AppointmentTypeConverter.getTypeFromNumber(widget.appoint.appointmentType!).name,
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
                DateFormat.jm().format(widget.appoint.dateFrom!),
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
                Formater.formatDuration(dateFrom: widget.appoint.dateFrom!, dateTo: widget.appoint.dateTo!),
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
                AppointmentStatusConverter.getStatusFromNumber(widget.appoint.state!).name,
                style: TextStyle(
                    color: AppointmentStatusConverter.getStatusFromNumber(widget.appoint.state!).textColor,
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
                    "${widget.appoint.priceBeforeDiscount} ${AppLocalizations.of(context)!.jdText}".toString(),
                    style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    " ${widget.appoint.priceAfterDiscount} ${AppLocalizations.of(context)!.jdText}".toString(),
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
                widget.appoint.noteFromClient ?? AppLocalizations.of(context)!.noNotesToShowText,
                style: TextStyle(
                    color: widget.appoint.noteFromClient == null ? Colors.grey : Colors.black,
                    fontWeight: widget.appoint.noteFromClient == null ? FontWeight.normal : FontWeight.bold),
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
                widget.appoint.noteFromMentor ?? AppLocalizations.of(context)!.noNotesToShowText,
                style: TextStyle(
                    color: widget.appoint.noteFromMentor == null ? Colors.grey : Colors.black,
                    fontWeight: widget.appoint.noteFromMentor == null ? FontWeight.normal : FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}
