import 'dart:async';
import 'package:dio/dio.dart';
import '../../constants.dart';
import '../../locater.dart';
import '../../models/apointments_model.dart';
import '../../services/api.dart';
import '../../services/hive.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppointmentsBloc {
  StreamController<List<Appoint>> appointmentsStreamController =
      StreamController<List<Appoint>>();

  String? language =
      locator<HiveService>().getValue(boxName: hiveBox, key: languageHiveKey) ??
          "en";
  String? userToken =
      locator<HiveService>().getValue(boxName: hiveBox, key: userTokenKey) ??
          "";
  List<Appoint> appointments = [];

  Future<AppointmentsModel> getAppointments() async {
    final response = await locator<ApiService>().apiRequest(
      path: "client-appointment/",
      method: getMethod,
      options: Options(
        headers: {'lang': language, "Authorization": "Bearer $userToken"},
      ),
    );
    print(response);

    return AppointmentsModel.fromJson(response);
  }

  String formatDuration(
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
    final Response response = await locator<ApiService>().apiRequest(
      path: "client-appointment/cancel",
      method: postMethod,
      queryParameters: {"id": id},
      options: Options(
        headers: {'lang': language, "Authorization": "Bearer $userToken"},
      ),
    );
    print(response);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Appointment has been cnaceled");
    } else {
      Fluttertoast.showToast(msg: "something went wrong");
    }
  }

  Future<void> addAppointmentNote(
      {required int appointmentID, required String note}) async {
    final response = await locator<ApiService>().apiRequest(
      path: "client-appointment/comment",
      method: postMethod,
      body: {"id": appointmentID, "comment": note},
      options: Options(
        headers: {'lang': language, "Authorization": "Bearer $userToken"},
      ),
    );
    print(response);
  }
}
