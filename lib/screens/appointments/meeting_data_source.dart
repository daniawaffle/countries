import 'package:countries_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../models/apointments_model.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(AppointmentsModel appointmentsModel) {
    appointments = _convertToAppointments(appointmentsModel.data);
  }

  List<Appointment> _convertToAppointments(List<Appoint>? appointments) {
    final List<Appointment> convertedAppointments = [];
    if (appointments != null) {
      for (final appoint in appointments) {
        convertedAppointments.add(_convertToAppointment(appoint));
      }
    }
    return convertedAppointments;
  }

  Appointment _convertToAppointment(Appoint appoint) {
    return Appointment(
      startTime: appoint.dateFrom!,
      endTime: appoint.dateTo!,
      subject: 'Meeting with ${appoint.firstName} ${appoint.lastName}',
      color: AppConstants.primaryColor,
      isAllDay: false,
    );
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startTime;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endTime;
  }

  @override
  String getSubject(int index) {
    return appointments![index].subject;
  }

  @override
  Color getColor(int index) {
    return appointments![index].color;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
