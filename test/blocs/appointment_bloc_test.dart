import 'package:countries_app/constants.dart';
import 'package:countries_app/locater.dart';
import 'package:countries_app/screens/appointments/appointment_bloc.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

import '../hive_test.mocks.dart';

late HiveService hiveService;
late MockBox mockBox;
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    mockMethodChannel();
    Hive.initFlutter();

    mockBox = MockBox();
    hiveService = HiveService();
    if (!locator.isRegistered<HiveService>()) {
      locator.registerSingleton<HiveService>(hiveService);
    }

    hiveService.languageBox = mockBox;
  });

  group('getLan', () {
    test('getLan should return value from HiveService', () {
      const key = AppConstants.languageHiveKey;
      const expectedValue = 'ar';
      final appsBloc = AppointmentsBloc();

      when(hiveService.getValue<String>(
              key: key, boxName: AppConstants.hiveBox))
          .thenReturn(expectedValue);
      var x = mockBox.get(key);
      if (kDebugMode) {
        print(x);
      }

      final result = appsBloc.getLan();

      expect(result, expectedValue);
    });
    test('getLan should return default value "en" from HiveService', () {
      const key = AppConstants.languageHiveKey;
      final appsBloc = AppointmentsBloc();

      when(hiveService.getValue<String>(
              key: key, boxName: AppConstants.hiveBox))
          .thenReturn(null);

      final result = appsBloc.getLan();

      expect(result, 'en');
    });
  });

  // group('getUserToken', () {
  //   test('getUserToken should return value from HiveService', () {
  //     const key = AppConstants.userTokenKey;
  //     const expectedValue = 'hgjhgjgjh';
  //     final appsBloc = AppointmentsBloc();

  //     when(hiveService.getValue<String>(
  //             key: key, boxName: AppConstants.hiveBox))
  //         .thenReturn(expectedValue);
  //     var x = mockBox.get(key);
  //     print(x);

  //     final result = appsBloc.getUserToken();

  //     expect(result, expectedValue);
  //   });
  //   test('getUserToken should return default value "" from HiveService', () {
  //     const key = AppConstants.userTokenKey;
  //     final appsBloc = AppointmentsBloc();

  //     when(hiveService.getValue<String>(
  //             key: key, boxName: AppConstants.hiveBox))
  //         .thenReturn(null);

  //     final result = appsBloc.getUserToken();

  //     expect(result, '');
  //   });
  // });
}

void mockMethodChannel() {
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (method) {
    return null;
  });
}
