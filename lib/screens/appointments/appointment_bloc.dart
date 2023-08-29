import 'dart:async';
import 'package:countries_app/utils/meeting_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../../constants.dart';
import '../../locater.dart';
import '../../models/apointments_model.dart';
import '../../services/api.dart';
import '../../services/hive.dart';

class AppointmentsBloc {
  StreamController<List<Appoint>> appointmentsStreamController =
      StreamController<List<Appoint>>();
  StreamController<AppointmentsModel> appointmentModelStreamController =
      StreamController<AppointmentsModel>();
  final TextEditingController noteTextFieldController = TextEditingController();
  final addNoteFormKey = GlobalKey<FormState>();
  ValueNotifier<String> noteValuesNotifier = ValueNotifier<String>(""); // ?
  List<Appoint> appointments = []; //??
  MeetingDataSource dataSource = MeetingDataSource(AppointmentsModel());
  AppointmentsModel? allAppointmentsModel;

  String getLan() {
    return locator<HiveService>().getValue(
            boxName: AppConstants.hiveBox, key: AppConstants.languageHiveKey) ??
        "en";
  }

  String _getUserToken() {
    return locator<HiveService>().getValue(
            boxName: AppConstants.hiveBox, key: AppConstants.userTokenKey) ??
        "";
  }

  Future<AppointmentsModel> getAppointments() async {
    String? userToken = _getUserToken();
    final response = await locator<ApiService>().apiRequest(
      path: AppConstants.appointmentMethod,
      method: AppConstants.getMethod,
      options: Options(
        headers: {'lang': getLan(), "Authorization": "Bearer $userToken"},
      ),
    );

    return AppointmentsModel.fromJson(response);
  }

  static String formatDuration(
      {required DateTime dateFrom, required DateTime dateTo}) {
    Duration duration = dateTo.difference(dateFrom);
    if (duration.inMinutes < 60) {
      return '${duration.inMinutes} min';
    } else {
      int hours = duration.inMinutes ~/ 60;
      int minutes = duration.inMinutes % 60;
      String result = (minutes == 0 ? "$hours h" : '$hours h $minutes min');
      return result;
    }
  }

  Future<void> cancelAppointment(int id) async {
    String? userToken = _getUserToken();
    await locator<ApiService>().apiRequest(
      path: AppConstants.cancelAppointmentMethod,
      method: AppConstants.postMethod,
      queryParameters: {"id": id},
      options: Options(
        headers: {'lang': getLan(), "Authorization": "Bearer $userToken"},
      ),
    );
  }

  Future<void> addAppointmentNote(
      {required int appointmentID, required String note}) async {
    String? userToken = _getUserToken();
    await locator<ApiService>().apiRequest(
      path: AppConstants.commentMethod,
      method: AppConstants.postMethod,
      body: {"id": appointmentID, "comment": note},
      options: Options(
        headers: {'lang': getLan(), "Authorization": "Bearer $userToken"},
      ),
    );
  }

  bool validateAddNoteField({String? note}) {
    if (note == null || note.trim().isEmpty) {
      return false;
    }
    return true;
  }

  // void saveInNoteTextController(String? note) {
  //   noteTextFieldController.text = note ?? "";
  // }

  // void updateNoteValuesNotifier(String? note) {
  //   noteValuesNotifier.value = note ?? "";
  // }

  Future fetchAppointments() async {
    final appointmentsModel = await getAppointments();

    dataSource = MeetingDataSource(appointmentsModel);
    allAppointmentsModel = appointmentsModel;
    appointmentModelStreamController.sink.add(appointmentsModel);
    return appointmentsModel;
  }
}
