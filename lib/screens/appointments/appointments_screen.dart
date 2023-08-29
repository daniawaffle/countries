import 'package:countries_app/constants.dart';
import 'package:countries_app/screens/appointments/widgets/add_note_dialog.dart';
import 'package:countries_app/screens/appointments/widgets/alert_dialog.dart';
import 'package:countries_app/screens/appointments/widgets/appointment_details_bottom_sheet.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: FutureBuilder(
            future: bloc.fetchAppointments(),
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
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      monthViewSettings: MonthViewSettings(
                          showAgenda: true, appointmentDisplayCount: bloc.dataSource.appointments!.length),
                      onTap: (calendarTapDetails) async {
                        if (calendarTapDetails.targetElement == CalendarElement.appointment) {
                          final Appointment appointment = calendarTapDetails.appointments!.first;

                          final matchingAppoint = bloc.allAppointmentsModel!.data!.firstWhere(
                            (app) => app.dateFrom == appointment.startTime && app.dateTo == appointment.endTime,
                          );

                          if (context.mounted) {
                            appointmentDetailsBottomSheet(
                                context: context,
                                appoint: matchingAppoint,
                                showNotes: () {
                                  addNoteDialog(
                                      appointment: matchingAppoint,
                                      noteValidation: bloc.validateAddNoteField,
                                      addNote: (appointmentID, note) {
                                        bloc.addAppointmentNote(appointmentID: appointmentID, note: note).then((value) {
                                          bloc.fetchAppointments();
                                        });
                                      },
                                      context: context);
                                },
                                cancel: (id) {
                                  showAlertDialog(
                                    context: context,
                                    appoitmentID: id,
                                    cancelAppointment: () {
                                      bloc.cancelAppointment(id).then((value) {
                                        bloc.fetchAppointments();
                                      });
                                    },
                                  );
                                });
                          }
                        }
                      },
                    ),
                  ),
                ],
              );
            }),
      ),
    ));
  }
}
