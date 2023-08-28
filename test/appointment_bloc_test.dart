// import 'package:countries_app/constants.dart';
// import 'package:countries_app/locater.dart';
// import 'package:countries_app/screens/appointments/appointment_bloc.dart';
// import 'package:countries_app/services/hive.dart';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:mockito/mockito.dart';

// import 'hive_test.dart';
// import 'hive_test.mocks.dart';

// late HiveService hiveService;
// late MockBox mockBox;
// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   setUpAll(() async {
//     mockMethodChannel();
//     Hive.initFlutter();

//     mockBox = MockBox();
//     hiveService = HiveService();
//     if (!locator.isRegistered<HiveService>()) {
//       locator.registerSingleton<HiveService>(hiveService);
//     }

//     hiveService.languageBox = mockBox;
//   });

//   group('getLan', () {
//     test('getLan should return value from HiveService', () {
//       const key = AppConstants.languageHiveKey;
//       const expectedValue = 'ar';
//       final appsBloc = AppointmentsBloc();

//       when(hiveService.getValue<String>(
//               key: key, boxName: AppConstants.hiveBox))
//           .thenReturn(expectedValue);
//       var x = mockBox.get(key);
//       print(x);

//       final result = appsBloc.getLan();

//       expect(result, expectedValue);
//     });
//     test('getLan should return default value "en" from HiveService', () {
//       const key = AppConstants.languageHiveKey;
//       final appsBloc = AppointmentsBloc();

//       when(hiveService.getValue<String>(
//               key: key, boxName: AppConstants.hiveBox))
//           .thenReturn(null);

//       final result = appsBloc.getLan();

//       expect(result, 'en');
//     });
//   });

//   group('getUserToken', () {
//     test('getUserToken should return value from HiveService', () {
//       const key = AppConstants.userTokenKey;
//       const expectedValue = 'hgjhgjgjh';
//       final appsBloc = AppointmentsBloc();

//       when(hiveService.getValue<String>(
//               key: key, boxName: AppConstants.hiveBox))
//           .thenReturn(expectedValue);
//       var x = mockBox.get(key);
//       print(x);

//       final result = appsBloc.getUserToken();

//       expect(result, expectedValue);
//     });
//     test('getUserToken should return default value "" from HiveService', () {
//       const key = AppConstants.userTokenKey;
//       final appsBloc = AppointmentsBloc();

//       when(hiveService.getValue<String>(
//               key: key, boxName: AppConstants.hiveBox))
//           .thenReturn(null);

//       final result = appsBloc.getUserToken();

//       expect(result, '');
//     });
//   });

//   group('formatDuration', () {
//     test('formatDuration returns value less than 1 h', () {
//       DateTime dateFrom = DateTime(2023, 8, 15, 10, 30);
//       DateTime dateTo = DateTime(2023, 8, 15, 11, 15);
//       String result =
//           AppointmentsBloc.formatDuration(dateFrom: dateFrom, dateTo: dateTo);

//       expect(result, '45 min');
//     });

//     test('formatDuration returns value for more than 1 h', () {
//       DateTime dateFrom = DateTime(2023, 8, 15, 10, 30);
//       DateTime dateTo = DateTime(2023, 8, 15, 14, 45);

//       String result =
//           AppointmentsBloc.formatDuration(dateFrom: dateFrom, dateTo: dateTo);

//       expect(result, '4 h 15 min');
//     });

//     test('formatDuration returns value for  1 h', () {
//       DateTime dateFrom = DateTime(2023, 8, 15, 10, 30);
//       DateTime dateTo = DateTime(2023, 8, 15, 11, 30);

//       String result =
//           AppointmentsBloc.formatDuration(dateFrom: dateFrom, dateTo: dateTo);

//       expect(result, '1 h');
//     });
//   });
// }
