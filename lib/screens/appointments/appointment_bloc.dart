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
}
