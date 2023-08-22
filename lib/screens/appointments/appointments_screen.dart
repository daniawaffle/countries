import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/apointments_model.dart';
import 'appointment_bloc.dart';
import 'meeting_data_source.dart';
import 'widgets/appointment_bottom_sheet.dart';

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

  Future<void> fetchAppointments() async {
    final appointmentsModel = await appBloc.getAppointments();
    setState(() {
      dataSource = MeetingDataSource(appointmentsModel);
    });
  }

  void _handleCalendarTap(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.calendarCell) {
      // Open the bottom sheet when tapping on a date cell
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return AppointmentBottomSheet(); // Your bottom sheet widget
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
              onTap: _handleCalendarTap,
              monthViewSettings: const MonthViewSettings(
                  showAgenda: true,
                  appointmentDisplayCount:
                      5), // display count length of list on this date
            ),
          ),
        ],
      ),
    ));
  }
}
