import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../../constants.dart';
import '../../locater.dart';
import '../../models/apointments_model.dart';
import '../../services/api.dart';
import '../../services/hive.dart';

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

  Future<AppointmentsModel> cancelAppointment() async {
    final response = await locator<ApiService>().apiRequest(
      path: "client-appointment/cancel",
      method: postMethod,
      options: Options(
        headers: {'lang': language, "Authorization": "Bearer $userToken"},
      ),
    );
    print(response);

    return AppointmentsModel.fromJson(response);
  }
}
