import 'package:countries_app/screens/appointments/widgets/appointment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/apointments_model.dart';
import 'appointment_bloc.dart';
import 'meeting_data_source.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  AppointmentsBloc appBloc = AppointmentsBloc();
  MeetingDataSource dataSource = MeetingDataSource(AppointmentsModel());

  @override
  void initState() {
    super.initState();
    fetchAppointments();
  }

  fetchAppointments() async {
    final appointmentsModel = await appBloc.getAppointments();
    setState(() {
      dataSource = MeetingDataSource(appointmentsModel);
    });

    return appointmentsModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Appointments',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .55,
              child: SfCalendar(
                view: CalendarView.month,
                dataSource: dataSource,
                onTap: (calendarTapDetails) async {
                  AppointmentsModel allApp = await fetchAppointments();
                  if (calendarTapDetails.targetElement ==
                      CalendarElement.appointment) {
                    final Appointment appointment =
                        calendarTapDetails.appointments!.first;
                    final matchingAppoint = allApp.data!.firstWhere(
                      (app) =>
                          app.dateFrom == appointment.startTime &&
                          app.dateTo == appointment.endTime,
                    );
                    if (matchingAppoint != null) {
                      showAppoitmentDetails(
                        context: context,
                        appoint: matchingAppoint,
                        bloc: appBloc,
                      );
                    }
                  }
                },

                monthViewSettings: const MonthViewSettings(
                    showAgenda: true,
                    appointmentDisplayCount:
                        5), // display count length of list on this date
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
