import 'package:countries_app/constants.dart';
import 'package:countries_app/locater.dart';
import 'package:countries_app/screens/startup/startup_bloc.dart';
import 'package:countries_app/services/hive.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

import 'hive_test.mocks.dart';

late HiveService hiveService;
late MockBox mockBox;

Future<void> main() async {
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
      final startupBloc = StartupBloc();

      when(hiveService.getValue<String>(
              key: key, boxName: AppConstants.hiveBox))
          .thenReturn(expectedValue);
      var x = mockBox.get(key);
      print(x);

      final result = startupBloc.getLan();

      expect(result, expectedValue);
    });
    test('getLan should return default value "en" from HiveService', () {
      const key = AppConstants.languageHiveKey;
      final startupBloc = StartupBloc();

      when(hiveService.getValue<String>(
              key: key, boxName: AppConstants.hiveBox))
          .thenReturn(null);

      final result = startupBloc.getLan();

      expect(result, 'en');
    });
  });

  group('saveLanguageToHive', () {
    test('saveLanguageToHive', () async {
      hiveService.languageBox = mockBox;
      const value = 'testValue';

      final startupBloc = StartupBloc();
      when(hiveService.setValue<String>(
              key: AppConstants.languageHiveKey,
              boxName: AppConstants.hiveBox,
              value: value))
          .thenAnswer((_) => Future.value());
      startupBloc.saveLanguageToHive(value);

      verify(hiveService.setValue<String>(
              key: AppConstants.languageHiveKey,
              boxName: AppConstants.hiveBox,
              value: value))
          .called(1);
    });

    test('saveLanguageToHive calls mockBox.put', () async {
      const value = 'ttt';

      final startupBloc = StartupBloc();

      startupBloc.saveLanguageToHive(value);

      verify(mockBox.put(AppConstants.languageHiveKey, value)).called(1);
    });
  });
}

void mockMethodChannel() {
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  channel.setMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });
}
