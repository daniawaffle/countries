import 'dart:async';
import 'package:countries_app/utils/meeting_data_source.dart';
import 'package:dio/dio.dart';
import '../../constants.dart';
import '../../locater.dart';
import '../../models/apointments_model.dart';
import '../../services/api.dart';
import '../../services/hive.dart';

class AppointmentsBloc {
  MeetingDataSource dataSource = MeetingDataSource(AppointmentsModel());
  AppointmentsModel? allAppointmentsModel;

  String getLan() {
    return locator<HiveService>().getValue(boxName: AppConstants.hiveBox, key: AppConstants.languageHiveKey) ?? "en";
  }

  String _getUserToken() {
    return locator<HiveService>().getValue(boxName: AppConstants.hiveBox, key: AppConstants.userTokenKey) ?? "";
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

  Future<void> cancelAppointment(int appointmentID) async {
    String? userToken = _getUserToken();
    await locator<ApiService>().apiRequest(
      path: AppConstants.cancelAppointmentMethod,
      method: AppConstants.postMethod,
      queryParameters: {"id": appointmentID},
      options: Options(
        headers: {'lang': getLan(), "Authorization": "Bearer $userToken"},
      ),
    );
  }

  Future<void> addAppointmentNote({required int appointmentID, required String note}) async {
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

  Future fetchAppointments() async {
    final appointmentsModel = await getAppointments();

    dataSource = MeetingDataSource(appointmentsModel);
    allAppointmentsModel = appointmentsModel;
    return appointmentsModel;
  }
}
