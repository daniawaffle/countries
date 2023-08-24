import 'dart:async';
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
  final TextEditingController noteTextFieldController = TextEditingController();
  final addNoteFormKey = GlobalKey<FormState>();
  String? note;

  String getLan() {
    return locator<HiveService>().getValue(
            boxName: AppConstants.hiveBox, key: AppConstants.languageHiveKey) ??
        "en";
  }

  String getUserToken() {
    return locator<HiveService>().getValue(
            boxName: AppConstants.hiveBox, key: AppConstants.userTokenKey) ??
        "";
  }

  List<Appoint> appointments = [];

  Future<AppointmentsModel> getAppointments() async {
    String? userToken = getUserToken();
    final response = await locator<ApiService>().apiRequest(
      path: "client-appointment/",
      method: AppConstants.getMethod,
      options: Options(
        headers: {'lang': getLan(), "Authorization": "Bearer $userToken"},
      ),
    );
    print(response);

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
    String? userToken = getUserToken();
    await locator<ApiService>().apiRequest(
      path: "client-appointment/cancel",
      method: AppConstants.postMethod,
      queryParameters: {"id": id},
      options: Options(
        headers: {'lang': getLan(), "Authorization": "Bearer $userToken"},
      ),
    );
  }

  Future<void> addAppointmentNote(
      {required int appointmentID, required String note}) async {
    String? userToken = getUserToken();
    await locator<ApiService>().apiRequest(
      path: "client-appointment/comment",
      method: AppConstants.postMethod,
      body: {"id": appointmentID, "comment": note},
      options: Options(
        headers: {'lang': getLan(), "Authorization": "Bearer $userToken"},
      ),
    );
  }

  bool validateAddNoteField({String? note, required BuildContext context}) {
    if (note == null || note.trim().isEmpty) {
      return false;
    }
    return true;
  }

  void saveInNoteTextController(String? note) {
    noteTextFieldController.text = note ?? "";
  }
}
