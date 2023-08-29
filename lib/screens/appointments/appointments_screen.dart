import 'package:countries_app/constants.dart';
import 'package:countries_app/models/apointments_model.dart';
import 'package:countries_app/screens/appointments/widgets/appointment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'appointment_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  AppointmentsBloc bloc = AppointmentsBloc();

  @override
  initState() {
    bloc.fetchAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAppointments();
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: StreamBuilder<AppointmentsModel>(
            stream: bloc.appointmentModelStreamController.stream,
            builder: (context, snapshot) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.appointText,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () async {
                              await bloc.fetchAppointments();
                              setState(() {});
                            },
                            icon: const Icon(Icons.refresh))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * .55,
                    child: SfCalendar(
                      todayHighlightColor: AppConstants.primaryColor,
                      cellBorderColor: AppConstants.secendaryColor,
                      view: CalendarView.month,
                      dataSource: bloc.dataSource,
                      onTap: (calendarTapDetails) async {
                        if (calendarTapDetails.targetElement ==
                            CalendarElement.appointment) {
                          final Appointment appointment =
                              calendarTapDetails.appointments!.first;

                          final matchingAppoint =
                              bloc.allAppointmentsModel!.data!.firstWhere(
                            (app) =>
                                app.dateFrom == appointment.startTime &&
                                app.dateTo == appointment.endTime,
                          );

                          if (context.mounted) {
                            showAppoitmentDetails(
                              context: context,
                              appoint: matchingAppoint,
                              bloc: bloc,
                            );
                          }
                        }
                      },
                      monthViewSettings: MonthViewSettings(
                          showAgenda: true,
                          appointmentDisplayCount:
                              bloc.dataSource.appointments!.length),
                    ),
                  ),
                ],
              );
            }),
      ),
    ));
  }
}
